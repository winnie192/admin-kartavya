import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TrainerExamsScreen extends StatefulWidget {
  const TrainerExamsScreen({super.key});

  @override
  State<TrainerExamsScreen> createState() => _TrainerExamsScreenState();
}

class _TrainerExamsScreenState extends State<TrainerExamsScreen> {
  final _exams = const [
    _ExamRow('Fundamentals of ReactJS with Gen AI', '06 Dec 2023', '16 Jan 2024', 'Divya Balakrishna Shetty', 'Upcoming'),
    _ExamRow('SQL & Database Handling Assessment', '16 Jan 2024', '26 Aug 2024', 'Rohit Rai', 'Ongoing'),
    _ExamRow('Medical Terminology Assessment', '21 Nov 2025', '06 Dec 2023', 'Clement Pinto', 'Complete'),
    _ExamRow('Healthcare Compliance Certification Test', '26 Aug 2024', '16 Dec 2023', 'Zohra Sawant', 'Cancel'),
    _ExamRow('AI-Generated: Customer Support Roleplay Assessment', '06 Dec 2023', '10 Jun 2025', 'Niloy Deb', 'Complete'),
    _ExamRow('Comprehensive Assessment on Workplace Communication and C...', '16 Dec 2023', '27 Nov 2025', 'Yashoda Anchan', 'Upcoming'),
    _ExamRow('Clinical Documentation and Patient Interaction Knowledge Evalu...', '10 Jun 2025', '16 Jan 2024', 'Rachana Dharmanath Singh', 'Complete'),
    _ExamRow('Hospital Environment Hygiene and Infection Control Skills Assess...', '02 Feb 2023', '06 Dec 2023', 'Shreya Ankit Pandey', 'Ongoing'),
    _ExamRow('Pharmaceutical Terminologies and Prescription Handling Certifica...', '06 Dec 2023', '02 Feb 2023', 'Anshuman Kanojiya', 'Cancel'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Filters
          Row(
            children: [
              _buildFilterChip('Business Segment'),
              const SizedBox(width: 8),
              _buildFilterChip('Department'),
              const SizedBox(width: 8),
              _buildFilterChip('Client'),
              const SizedBox(width: 8),
              _buildFilterChip('Program'),
              const SizedBox(width: 8),
              _buildFilterChip('Course'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Draft', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('New Exam', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
                  child: Row(
                    children: [
                      _hCell('Exam Title', flex: 4),
                      _hCell('Assign Date', flex: 2),
                      _hCell('Exam Date', flex: 2),
                      _hCell('Assigner', flex: 3),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Text('Status', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.orange)),
                            const SizedBox(width: 4),
                            Icon(Icons.filter_list, size: 12, color: AppColors.orange),
                          ],
                        ),
                      ),
                      _hCell('Action', flex: 1),
                    ],
                  ),
                ),
                ..._exams.map((e) => _buildRow(e)),
                // Pagination
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Text('1-${_exams.length} of 1',
                          style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
                      const Spacer(),
                      _pageBtn(Icons.chevron_left),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
                        child: const Text('1/1', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      const SizedBox(width: 4),
                      _pageBtn(Icons.chevron_right),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _hCell(String label, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.orange)),
    );
  }

  Widget _buildRow(_ExamRow exam) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(exam.title, style: const TextStyle(fontSize: 11, color: AppColors.textDark), maxLines: 1, overflow: TextOverflow.ellipsis)),
          Expanded(flex: 2, child: _dateBadge(exam.assignDate)),
          Expanded(flex: 2, child: _dateBadge(exam.examDate)),
          Expanded(flex: 3, child: Text(exam.assigner, style: const TextStyle(fontSize: 11, color: AppColors.textDark), maxLines: 1, overflow: TextOverflow.ellipsis)),
          Expanded(flex: 2, child: _statusBadge(exam.status)),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textGrey),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateBadge(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.borderGrey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(date, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
    );
  }

  Widget _statusBadge(String status) {
    Color bg, fg;
    bool filled = false;
    switch (status) {
      case 'Upcoming':
        bg = AppColors.orange;
        fg = AppColors.orange;
        break;
      case 'Ongoing':
        bg = AppColors.green;
        fg = Colors.white;
        filled = true;
        break;
      case 'Complete':
        bg = AppColors.green;
        fg = AppColors.green;
        break;
      case 'Cancel':
        bg = AppColors.red;
        fg = AppColors.red;
        break;
      default:
        bg = AppColors.textGrey;
        fg = AppColors.textGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: filled ? bg : Colors.transparent,
        border: Border.all(color: bg),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10, color: filled ? fg : bg, fontWeight: FontWeight.w500)),
    );
  }

  Widget _pageBtn(IconData icon) {
    return Container(
      width: 28, height: 28,
      decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

class _ExamRow {
  final String title, assignDate, examDate, assigner, status;
  const _ExamRow(this.title, this.assignDate, this.examDate, this.assigner, this.status);
}
