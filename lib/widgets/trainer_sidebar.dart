import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class TrainerSidebar extends StatelessWidget {
  const TrainerSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(color: AppColors.darkSidebar),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/images/kartavya_logo.png',
              width: 140,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Text(
                'KARTAVYA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Role icon + label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text('👋', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                const Text(
                  'Trainer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Profile completion status',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 9,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.0,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.orange),
                      minHeight: 4,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '0%',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          _buildStaticItem(Icons.link, 'LMS Link'),
          const SizedBox(height: 4),
          _buildStaticItem(Icons.build_outlined, 'Tool Kit'),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildStaticItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 16),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
