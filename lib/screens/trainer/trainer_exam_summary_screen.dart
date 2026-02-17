import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class TrainerExamSummaryScreen extends StatelessWidget {
  const TrainerExamSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Padding(
        padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(20),
          child: Container(
            color: AppColors.background,
            child: Column(
              children: [
                // Top bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: AppColors.topNavBg,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 12),
                      const Text('Exam Result',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          children: [
                            // Exam Summary card
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.assignment, size: 20, color: AppColors.green),
                                      const SizedBox(width: 8),
                                      const Text('Exam Summary',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.green)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  _buildInfoRow('Exam Name :', 'Assess your skills in writing complex SQL queries, joins, and stored procedures.'),
                                  _buildInfoRow('Duration :', '45 Mins'),
                                  _buildInfoRow('Attempt Date :', '12 July 2025'),
                                  _buildInfoRow('Exam Dates :', '01 June 2025  -  19 July 2025'),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Text('Total Questions : ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                                      const Text('100', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                                      const SizedBox(width: 24),
                                      const Text('Attempted Questions : ', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                                      const Text('98', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.green)),
                                      const SizedBox(width: 24),
                                      const Text('Unattempted Questions : ', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                                      const Text('02', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.red)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Performance Summary card
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.emoji_events, size: 20, color: AppColors.orange),
                                      const SizedBox(width: 8),
                                      const Text('Performance Summary',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.orange)),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  // Trophy
                                  const Icon(Icons.emoji_events, size: 80, color: Color(0xFFFFD700)),
                                  const SizedBox(height: 16),
                                  // Score
                                  const Text('78/100',
                                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                                  const SizedBox(height: 8),
                                  // Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCDDC39),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.emoji_events, size: 14, color: AppColors.textDark),
                                        const SizedBox(width: 4),
                                        const Text('Front Runner',
                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text('Congratulations !!! Achievement Unlocked !!!',
                                      style: TextStyle(fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 24),
                                  // Buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.visibility, size: 16),
                                        label: const Text('View Answers', style: TextStyle(fontSize: 12)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFCDDC39),
                                          foregroundColor: AppColors.textDark,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.card_membership, size: 16),
                                        label: const Text('View Certificate', style: TextStyle(fontSize: 12)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryBlue,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12, color: AppColors.textDark))),
        ],
      ),
    );
  }
}
