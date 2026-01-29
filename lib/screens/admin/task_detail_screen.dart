import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TaskDetailScreen extends StatefulWidget {
  final bool isTrainerView;
  const TaskDetailScreen({super.key, this.isTrainerView = true});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  int _statusTab = 0; // 0=Ongoing, 1=Completed, 2=Upcoming

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTaskHeader(),
          const SizedBox(height: 16),
          if (widget.isTrainerView) ...[
            _buildStatusTabs(),
            const SizedBox(height: 12),
            _buildSubmissionsTable(),
          ] else ...[
            _buildTaskProgress(),
          ],
        ],
      ),
    );
  }

  Widget _buildTaskHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.amber,
                child: const Text('D', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              const Text('Devesh Dharmnath Singh Gupta', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            ],
          ),
          const SizedBox(height: 12),
          _fieldRow('Title', 'Complete All Pending Assignments'),
          const SizedBox(height: 8),
          _fieldRow('Description', 'Complete All Pending Assignments'),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Attachment  ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textGrey)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.lightBlue, borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.attach_file, size: 10, color: AppColors.primaryBlue),
                    SizedBox(width: 4),
                    Text('Task1.pdf', style: TextStyle(fontSize: 9, color: AppColors.primaryBlue)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Stats row
          Row(
            children: [
              _statChip('Trainees', '123', AppColors.primaryBlue),
              const SizedBox(width: 8),
              _statChip('Assignment Date', '08-03-2025', AppColors.textDark),
              const SizedBox(width: 8),
              _statChip('Submission Date', '12-03-2025', AppColors.textDark),
              const SizedBox(width: 8),
              _statChip('Submitted', '117', AppColors.green),
              const SizedBox(width: 8),
              _statChip('Not Submitted', '05', AppColors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fieldRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textGrey))),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
      ],
    );
  }

  Widget _statChip(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }

  Widget _buildStatusTabs() {
    final tabs = ['Ongoing', 'Completed', 'Upcoming'];
    return Row(
      children: tabs.asMap().entries.map((e) {
        final isActive = _statusTab == e.key;
        return GestureDetector(
          onTap: () => setState(() => _statusTab = e.key),
          child: Container(
            margin: const EdgeInsets.only(right: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
            ),
            child: Text(e.value, style: TextStyle(fontSize: 10, color: isActive ? Colors.white : AppColors.textGrey)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubmissionsTable() {
    final submissions = [
      _Submission('Monika', 'Verma', 'Submitted', '12-04-2025 , 09:34 AM'),
      _Submission('Monika', 'Verma', 'Not Submit', ''),
      _Submission('Monika', 'Verma', 'Not Submit', ''),
      _Submission('Monika', 'Verma', 'Pending', '12-04-2025 , 10:28 AM'),
      _Submission('Monika', 'Verma', 'Resubmitted', '12-04-2025 , 09:31 AM'),
      _Submission('Monika', 'Verma', 'Submitted', '09-04-2025 , 09:34 AM'),
      _Submission('Monika', 'Verma', 'Not Submit', ''),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(8))),
            child: Row(
              children: const [
                Expanded(child: Text('First name', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                Expanded(child: Text('Last Name', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                Expanded(child: Text('Status', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                Expanded(flex: 2, child: Text('Submitted Timeout', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                SizedBox(width: 40, child: Text('View', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                SizedBox(width: 40, child: Text('Action', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
              ],
            ),
          ),
          ...submissions.map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                child: Row(
                  children: [
                    Expanded(child: Text(s.firstName, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(child: Text(s.lastName, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(child: _submissionStatus(s.status)),
                    Expanded(flex: 2, child: Text(s.timeout, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    SizedBox(
                      width: 40,
                      child: s.status == 'Submitted' || s.status == 'Resubmitted' || s.status == 'Pending'
                          ? const Text('View', style: TextStyle(fontSize: 9, color: AppColors.primaryBlue, fontWeight: FontWeight.w500))
                          : const SizedBox(),
                    ),
                    const SizedBox(width: 40, child: Icon(Icons.more_vert, size: 14, color: AppColors.textGrey)),
                  ],
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text('1/1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                SizedBox(width: 16),
                Text('1-6  of  1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                SizedBox(width: 8),
                Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
                Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _submissionStatus(String status) {
    Color color;
    switch (status) {
      case 'Submitted':
        color = AppColors.green;
        break;
      case 'Not Submit':
        color = AppColors.red;
        break;
      case 'Pending':
        color = AppColors.amber;
        break;
      case 'Resubmitted':
        color = AppColors.primaryBlue;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTaskProgress() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Task Progress', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          _progressItem('Assignment Date', '08-03-2025'),
          _progressItem('Submission Date', '12-03-2025'),
          _progressItem('Submitted Date', '10-03-2025'),
          _progressItem('Status', 'Submitted'),
          const SizedBox(height: 8),
          const Text('Feedback', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textGrey)),
          const SizedBox(height: 4),
          const Text(
            'Clean layout and good responsiveness. Please use company font in assignment.',
            style: TextStyle(fontSize: 9, color: AppColors.textDark),
          ),
          const SizedBox(height: 8),
          _progressItem('Resubmitted Date', '10-03-2025'),
          _progressItem('Reassign Date', '08-03-2025'),
        ],
      ),
    );
  }

  Widget _progressItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primaryBlue, width: 2))),
          const SizedBox(width: 8),
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
          Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        ],
      ),
    );
  }
}

class _Submission {
  final String firstName, lastName, status, timeout;
  _Submission(this.firstName, this.lastName, this.status, this.timeout);
}
