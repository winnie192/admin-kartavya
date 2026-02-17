import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TraineeExamsScreen extends StatefulWidget {
  const TraineeExamsScreen({super.key});

  @override
  State<TraineeExamsScreen> createState() => _TraineeExamsScreenState();
}

class _TraineeExamsScreenState extends State<TraineeExamsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats row
          Row(
            children: [
              _statBadge('Total Exams : 24', AppColors.textDark),
              const SizedBox(width: 12),
              _statBadge('Upcoming:05', AppColors.primaryBlue),
              const SizedBox(width: 8),
              _statBadge('Completed:10', AppColors.green),
              const SizedBox(width: 8),
              _statBadge('Ongoing:01', AppColors.orange),
              const SizedBox(width: 8),
              _statBadge('Cancel:03', AppColors.red),
            ],
          ),
          const SizedBox(height: 16),
          // Date filters + search
          Row(
            children: [
              _dateChip('27-03-2025'),
              const SizedBox(width: 8),
              _dateChip('27-03-2025'),
              const Spacer(),
              SizedBox(
                width: 200,
                height: 36,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search ...',
                    hintStyle: const TextStyle(
                        fontSize: 12, color: AppColors.textGrey),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: AppColors.borderGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: AppColors.borderGrey),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Exam cards grid
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: _exams.map((e) => _ExamCard(exam: e)).toList(),
          ),
          const SizedBox(height: 16),
          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('1-6  of  123',
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
              Row(
                children: [
                  _pageBtn(Icons.chevron_left),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('1/1',
                        style:
                            TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                  const SizedBox(width: 4),
                  _pageBtn(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget _dateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 14, color: AppColors.textGrey),
          const SizedBox(width: 6),
          Text(date,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _pageBtn(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Icon(icon, size: 16, color: AppColors.textGrey),
    );
  }
}

class _ExamData {
  final String dateRange;
  final String status;
  final String duration;
  final String description;

  const _ExamData({
    required this.dateRange,
    required this.status,
    required this.duration,
    required this.description,
  });
}

const _exams = [
  _ExamData(
    dateRange: '06 Dec 2023-12 Dec 2023',
    status: 'Ongoing',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '11 Apr 2025',
    status: 'Upcoming',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '26 Aug 2023 - 30 Aug 2023',
    status: 'Complete',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '20 Oct 2025 - 29 Oct 2025',
    status: 'Cancel',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '06 Dec 2023-12 Dec 2023',
    status: 'Upcoming',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '21 Nov 2024',
    status: 'Upcoming',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '31 Dec 2025 - 20 Feb 2026',
    status: 'Upcoming',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '01 Jul 2024 - 15 Aug 2024',
    status: 'Complete',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '21 Jun 2023',
    status: 'Ongoing',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '18 Jan 2024 - 22 Jan 2024',
    status: 'Complete',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '02 Dec 2025',
    status: 'Ongoing',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
  _ExamData(
    dateRange: '9 Dec 2026 - 12 Dec 2026',
    status: 'Cancel',
    duration: '45 min',
    description:
        'Assess your skills in writing complex SQL queries..........',
  ),
];

class _ExamCard extends StatelessWidget {
  final _ExamData exam;

  const _ExamCard({required this.exam});

  Color get _statusColor {
    switch (exam.status) {
      case 'Ongoing':
        return AppColors.orange;
      case 'Upcoming':
        return AppColors.primaryBlue;
      case 'Complete':
        return AppColors.green;
      case 'Cancel':
        return AppColors.red;
      default:
        return AppColors.grey;
    }
  }

  String get _actionLabel {
    if (exam.status == 'Complete') return 'View Result';
    return 'Take Test';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(top: BorderSide(color: _statusColor, width: 3)),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: _statusColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(exam.dateRange,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(exam.status,
                    style: TextStyle(
                        fontSize: 10,
                        color: _statusColor,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              Text('Duration - ${exam.duration}',
                  style: const TextStyle(
                      fontSize: 10, color: AppColors.textGrey)),
            ],
          ),
          const SizedBox(height: 10),
          Text(exam.description,
              style: const TextStyle(fontSize: 11, height: 1.4),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (exam.status == 'Complete') {
                  Navigator.pushNamed(context, '/trainee/exam-result');
                } else {
                  Navigator.pushNamed(context, '/trainee/take-test');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: exam.status == 'Complete'
                    ? AppColors.green
                    : AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child:
                  Text(_actionLabel, style: const TextStyle(fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}
