import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Confirm Deletion",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text(
        "Are you sure you want to delete your account? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
