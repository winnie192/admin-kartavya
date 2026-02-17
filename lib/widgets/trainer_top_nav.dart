import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class TrainerTopNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const TrainerTopNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.topNavBg,
      child: Row(
        children: [
          _buildNavItem(0, Icons.dashboard_outlined, 'Dashboard'),
          const SizedBox(width: 4),
          _buildNavItem(1, Icons.menu_book_outlined, 'Courses'),
          const SizedBox(width: 4),
          _buildNavItem(2, Icons.quiz_outlined, 'Exams'),
          const SizedBox(width: 4),
          _buildNavItem(3, Icons.assignment_outlined, 'Requests'),
          const SizedBox(width: 4),
          _buildNavItem(4, Icons.calendar_month_outlined, 'My Schedule'),
          const SizedBox(width: 4),
          _buildNavItem(5, Icons.trending_up, 'Trainee Progress'),
          const SizedBox(width: 4),
          _buildNavItem(6, Icons.swap_horiz, 'Change Role'),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined,
                color: Colors.white, size: 20),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
