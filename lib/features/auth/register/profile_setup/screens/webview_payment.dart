import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/features/bottom_navbar/screen/bottom_navbar_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shimmer/shimmer.dart';

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

    if (kDebugMode) {
      print("Loading URL: ${widget.paymentUrl}");
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (kDebugMode) {
              print("Navigating to: ${request.url}");
            }

            if (request.url.contains("$baseUrl/success") ||
                request.url.contains("http://localhost:3000/success")) {
              // ✅ Intercept and navigate inside app instead of WebView
              Get.offAll(() => BottomNavbarScreen());
              return NavigationDecision.prevent; // stop WebView loading
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
            });
            EasyLoading.showError(error.description);
            if (kDebugMode) {
              print("WebView error: ${error.description}");
            }
          },
        ),
      )
      ..clearCache()
      ..clearLocalStorage()
      ..loadRequest(Uri.parse(widget.paymentUrl)).catchError((e) {
        setState(() {
          _isLoading = false;
        });
        if (kDebugMode) {
          print("Error loading URL: $e");
        }
        EasyLoading.showError("Failed to load URL: $e");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Checkout')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: _ShimmerLoadingWidget()),
        ],
      ),
    );
  }
}

class _ShimmerLoadingWidget extends StatelessWidget {
  const _ShimmerLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
