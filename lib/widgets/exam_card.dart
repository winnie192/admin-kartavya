import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ExamCard extends StatelessWidget {
  final String title;
  final String duration;
  final String dateRange;
  final String description;
  final VoidCallback? onTap;

  const ExamCard({
    super.key,
    this.title = '',
    this.duration = '45 mins',
    this.dateRange = '06 Dec 2023-12 Dec 2023',
    this.description =
        'Assess your skills in writing complex SQL queries..........',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderGrey),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 12, color: AppColors.orange),
                const SizedBox(width: 3),
                Text(
                  'Duration : $duration',
                  style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 12, color: AppColors.primaryBlue),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    dateRange,
                    style:
                        const TextStyle(fontSize: 9, color: AppColors.textGrey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 10, color: AppColors.textDark),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.more_horiz,
                  color: AppColors.textGrey, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
