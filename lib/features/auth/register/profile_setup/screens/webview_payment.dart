import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/features/bottom_navbar/screen/bottom_navbar_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewScreen({super.key, required this.paymentUrl});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String baseUrl = Urls.baseUrl;

  @override
  void initState() {
    super.initState();

    // Print the URL for debugging
    if (kDebugMode) {
      print("Loading URL: ${widget.paymentUrl}");
    }

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
                if (kDebugMode) {
                  print("Page started loading: $url");
                }
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
                if (kDebugMode) {
                  print("Page finished loading: $url");
                }
                // Only navigate if the URL indicates payment completion
                if (url.contains("$baseUrl/success") ||
                    url.contains("http://localhost:3000/success")) {
                  Get.off(() => BottomNavbarScreen());
                }
              },
              onWebResourceError: (WebResourceError error) {
                setState(() {
                  _isLoading = false;
                });
                if (kDebugMode) {
                  print("WebView error: ${error.description}");
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed to load page: ${error.description}"),
                  ),
                );
              },
            ),
          )
          ..clearCache() // Clear cache to avoid stale data
          ..clearLocalStorage()
          ..loadRequest(Uri.parse(widget.paymentUrl)).catchError((e) {
            setState(() {
              _isLoading = false;
            });
            if (kDebugMode) {
              print("Error loading URL: $e");
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Failed to load URL: $e")));
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Checkout')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
