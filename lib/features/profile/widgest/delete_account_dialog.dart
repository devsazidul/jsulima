import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Confirm Deletion",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 133, 59, 55),
      content: Text(
        "Are you sure you want to delete your account? This action cannot be undone.",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text(
            "Delete",
            style: TextStyle(color: Color.fromARGB(255, 255, 136, 128)),
          ),
        ),
      ],
    );
  }
}
