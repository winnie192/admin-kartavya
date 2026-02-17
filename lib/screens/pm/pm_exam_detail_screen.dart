import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class PmExamDetailScreen extends StatefulWidget {
  const PmExamDetailScreen({super.key});

  @override
  State<PmExamDetailScreen> createState() => _PmExamDetailScreenState();
}

class _PmExamDetailScreenState extends State<PmExamDetailScreen> {
  int _statusTab = 0;
  final _statusTabs = ['Completed', 'Upcoming', 'Ongoing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title: const Text('Exam Details', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExamInfoHeader(),
            const SizedBox(height: 16),
            _buildStatusTabs(),
            const SizedBox(height: 12),
            _buildAttendanceSummary(),
            const SizedBox(height: 12),
            _buildAttendanceTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildExamInfoHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Advanced SQL Queries Assessment', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 16, runSpacing: 6,
            children: [
              _infoItem('Course', 'Database Management & SQL Optimization'),
              _infoItem('Date Range', '06 Dec 2023 - 12 Dec 2023'),
              _infoItem('Time Slot', 'Evening 05:00 PM - 06:00 PM'),
              _infoItem('Duration', '45 minutes'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Row(
      children: _statusTabs.asMap().entries.map((e) {
        final isActive = e.key == _statusTab;
        Color tabColor;
        switch (e.key) {
          case 0: tabColor = AppColors.green; break;
          case 1: tabColor = AppColors.amber; break;
          default: tabColor = AppColors.primaryBlue;
        }
        return Padding(
          padding: const EdgeInsets.only(right: 6),
          child: GestureDetector(
            onTap: () => setState(() => _statusTab = e.key),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? tabColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isActive ? tabColor : AppColors.borderGrey),
              ),
              child: Text(e.value, style: TextStyle(fontSize: 10, color: isActive ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.w500)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAttendanceSummary() {
    return Row(
      children: [
        _summaryCard('Total Students', '256', AppColors.primaryBlue),
        const SizedBox(width: 8),
        _summaryCard('Present', '250', AppColors.green),
        const SizedBox(width: 8),
        _summaryCard('Absent', '06', AppColors.red),
      ],
    );
  }

  Widget _summaryCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceTable() {
    final students = [
      _Student('Shrey', 'Saraki', 'Present', '06-12-2023', '05:00 PM', '05:58 PM'),
      _Student('Clement', 'Pinto', 'Present', '06-12-2023', '05:02 PM', '06:00 PM'),
      _Student('Monishka', 'Mangnani', 'Absent', '06-12-2023', '-', '-'),
      _Student('Vimla', 'Doliya', 'Present', '06-12-2023', '04:58 PM', '05:55 PM'),
      _Student('Lavesh', 'Paryani', 'Present', '06-12-2023', '05:01 PM', '05:59 PM'),
      _Student('Piyush', 'Notani', 'Absent', '06-12-2023', '-', '-'),
      _Student('Dimple', 'Didwani', 'Present', '06-12-2023', '05:00 PM', '06:00 PM'),
      _Student('Jitisha', 'Sabani', 'Present', '06-12-2023', '05:03 PM', '05:57 PM'),
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(children: [
              _hdr('First Name', 2),
              _hdr('Last Name', 2),
              _hdr('Status', 1),
              _hdr('Date', 2),
              _hdr('Time In', 1),
              _hdr('Time Out', 1),
            ]),
          ),
          ...students.map((s) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
            child: Row(children: [
              Expanded(flex: 2, child: Text(s.firstName, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
              Expanded(flex: 2, child: Text(s.lastName, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
              Expanded(flex: 1, child: _attendanceBadge(s.status)),
              Expanded(flex: 2, child: Text(s.date, style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
              Expanded(flex: 1, child: Text(s.timeIn, style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
              Expanded(flex: 1, child: Text(s.timeOut, style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
            ]),
          )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              Text('1-${students.length}  of  ${students.length}', style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
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

  Widget _attendanceBadge(String status) {
    final isPresent = status == 'Present';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: (isPresent ? AppColors.green : AppColors.red).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status, style: TextStyle(fontSize: 8, color: isPresent ? AppColors.green : AppColors.red, fontWeight: FontWeight.w500)),
    );
  }

  Widget _hdr(String text, int flex) => Expanded(flex: flex, child: Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey)));
}

class _Student {
  final String firstName, lastName, status, date, timeIn, timeOut;
  const _Student(this.firstName, this.lastName, this.status, this.date, this.timeIn, this.timeOut);
}
