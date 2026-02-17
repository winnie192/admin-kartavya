import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class PmTopNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const PmTopNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: AppColors.topNavBg,
      child: Row(
        children: [
          _buildNavItem(0, Icons.dashboard_outlined, 'Dashboard'),
          const SizedBox(width: 6),
          _buildNavItem(1, Icons.people_outlined, 'Manage LMS'),
          const SizedBox(width: 6),
          _buildNavItem(2, Icons.assignment_outlined, 'Requests'),
          const SizedBox(width: 6),
          _buildNavItem(3, Icons.swap_horiz, 'Change Role'),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
