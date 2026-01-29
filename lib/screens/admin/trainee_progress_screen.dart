import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TraineeProgressScreen extends StatelessWidget {
  final VoidCallback? onTraineeTap;

  const TraineeProgressScreen({super.key, this.onTraineeTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildStatsRow(),
          const SizedBox(height: 12),
          _buildSearchAndFilters(),
          const SizedBox(height: 12),
          _buildProgressTable(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(radius: 20, backgroundColor: AppColors.amber, child: const Text('A', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ankit Dharmnath Pandey', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const Text('Trainee  |  Front Runner', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      _S('Reviewed Courses', '131', AppColors.green),
      _S('New Courses', '93', AppColors.primaryBlue),
      _S('In Progress', '12', AppColors.orange),
      _S('Resubmitted', '12', AppColors.amber),
      _S('Pending', '03', AppColors.red),
    ];
    return Row(
      children: stats.map((s) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: s.color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: s.color.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Text(s.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: s.color)),
              const SizedBox(height: 2),
              Text(s.label, style: const TextStyle(fontSize: 7, color: AppColors.textGrey), textAlign: TextAlign.center),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildSearchAndFilters() {
    return Row(
      children: ['Business Segment', 'Department', 'Client', 'Program'].map((l) => Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(4)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(l, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
          ]),
        ),
      )).toList(),
    );
  }

  Widget _buildProgressTable() {
    final courses = [
      ['01-06-2023', 'MIT Introduction to Computer Science and Programs...', 'Divya Balakrishna Shetty', 'Completed', 'Surest Gupta'],
      ['14 Nov 2024', 'Software Testing - Manual Testing, Automation Test...', 'Clement Pinto', 'Ongoing', 'Surest Gupta'],
      ['07-03-2024', 'Natural Language Processing (NLP) with AI', 'Surest Gupta', 'Completed', 'Surest Gupta'],
      ['17 Apr 2024', 'UI/UX Designs for Beginners...', 'Niloy Deb', 'Upcoming', 'Surest Gupta'],
      ['01-06-2023', 'The new course for coders of future...', 'Reetu Kulita', 'Completed', 'Surest Gupta'],
      ['17 Jun 2024', 'Software Testing - Manual Testing...', 'Ankit Pandey', 'UPCOMING', 'Surest Gupta'],
      ['01-06-2023', 'Communication and C...', 'Shweta Shetty', 'Ongoing', 'Surest Gupta'],
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(children: [
              _hdr('Info', width: 25), _hdr('Date', width: 65), _hdr('Course Name', flex: 3), _hdr('Program Manager', flex: 2), _hdr('Status', flex: 1), _hdr('Action', flex: 1),
            ]),
          ),
          ...courses.map((c) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
            child: Row(children: [
              const SizedBox(width: 25, child: Icon(Icons.info_outline, size: 12, color: AppColors.textGrey)),
              SizedBox(width: 65, child: Text(c[0], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
              Expanded(flex: 3, child: Text(c[1], style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(c[2], style: const TextStyle(fontSize: 9, color: AppColors.textGrey), overflow: TextOverflow.ellipsis)),
              Expanded(flex: 1, child: _statusBadge(c[3])),
              Expanded(flex: 1, child: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey)),
            ]),
          )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              const Text('1-6  of  1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
              const Spacer(),
              const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
              const Text('1/1', style: TextStyle(fontSize: 9)),
              const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
            ]),
          ),
        ],
      ),
    );
  }

  static Widget _hdr(String text, {double? width, int? flex}) {
    final child = Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey));
    if (width != null) return SizedBox(width: width, child: child);
    return Expanded(flex: flex ?? 1, child: child);
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'completed': color = AppColors.green; break;
      case 'ongoing': color = AppColors.primaryBlue; break;
      case 'upcoming': color = AppColors.amber; break;
      default: color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }
}

class _S {
  final String label, value;
  final Color color;
  _S(this.label, this.value, this.color);
}
