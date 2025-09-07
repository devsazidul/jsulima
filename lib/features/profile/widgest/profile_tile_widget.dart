import 'package:flutter/material.dart';
import 'package:jsulima/core/utils/constants/colors.dart';

class ProfileTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isLogout;
  final bool? toggleValue;
  final VoidCallback? onToggle;

  const ProfileTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.isLogout = false,
    this.toggleValue,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isLogout ? const Color(0xFF210B0B) : Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          toggleValue != null && onToggle != null
              ? Switch(
                value: toggleValue!,
                onChanged: (_) => onToggle!(),
                activeTrackColor: AppColors.primaryColor,
              )
              : Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white),
              ),
        ],
      ),
    );
  }
}
