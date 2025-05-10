import 'package:flutter/material.dart';
import 'package:jsulima/core/utils/constants/colors.dart';

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscured;
  final VoidCallback toggleVisibility;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    required this.isObscured,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          obscureText: isObscured,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                isObscured ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primaryColor,
              ),
              onPressed: toggleVisibility,
            ),
          ),
        ),
      ),
    );
  }
}
