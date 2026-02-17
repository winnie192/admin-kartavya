import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'trainee_task_detail_screen.dart';

class TraineeTasksScreen extends StatelessWidget {
  const TraineeTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search + date filters
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search ...',
                      hintStyle:
                          const TextStyle(fontSize: 12, color: AppColors.textGrey),
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
              ),
              const SizedBox(width: 12),
              _dateChip('From', '20-03-2025'),
              const SizedBox(width: 8),
              _dateChip('To', '27-03-2025'),
            ],
          ),
          const SizedBox(height: 16),
          // Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: AppColors.cardShadow, blurRadius: 6)
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.topNavBg,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text('Task Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))),
                      Expanded(
                          flex: 2,
                          child: Text('Assign Date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))),
                      Expanded(
                          flex: 2,
                          child: Text('Submission Date',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))),
                      Expanded(
                          flex: 1,
                          child: Text('Status',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))),
                      Expanded(
                          flex: 2,
                          child: Text('Assigned By',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))),
                      Expanded(
                          flex: 1,
                          child: Text('Action',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
                ..._tasks.map((t) => InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TraineeTaskDetailScreen()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGrey, width: 0.5)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(t.name,
                                    style: const TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)),
                            Expanded(
                                flex: 2,
                                child: Text(t.assignDate,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textGrey))),
                            Expanded(
                                flex: 2,
                                child: Text(t.submissionDate,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textGrey))),
                            Expanded(flex: 1, child: _statusBadge(t.status)),
                            Expanded(
                                flex: 2,
                                child: Text(t.assignedBy,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textGrey))),
                            Expanded(
                              flex: 1,
                              child: Text(
                                t.action,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: t.action == 'Reassign'
                                      ? AppColors.orange
                                      : AppColors.primaryBlue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('1/1',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
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

  Widget _dateChip(String label, String date) {
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
          Text('$label ',
              style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          Text(date,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
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

Widget _statusBadge(String status) {
  Color color;
  switch (status) {
    case 'Submitted':
      color = AppColors.green;
      break;
    case 'Pending':
      color = AppColors.orange;
      break;
    case 'Not Submit':
      color = AppColors.red;
      break;
    case 'Resubmitted':
      color = AppColors.primaryBlue;
      break;
    case 'Assign':
      color = const Color(0xFF00BCD4);
      break;
    case 'Reassign':
      color = AppColors.amber;
      break;
    default:
      color = AppColors.grey;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(status,
        style: TextStyle(
            fontSize: 10, color: color, fontWeight: FontWeight.w600)),
  );
}

class _TaskData {
  final String name;
  final String assignDate;
  final String submissionDate;
  final String status;
  final String assignedBy;
  final String action;

  const _TaskData({
    required this.name,
    required this.assignDate,
    required this.submissionDate,
    required this.status,
    required this.assignedBy,
    required this.action,
  });
}

const _tasks = [
  _TaskData(
      name: 'Complete All Pending Assignments ...',
      assignDate: '16 Mar 2024',
      submissionDate: '02 Apr 2025',
      status: 'Not Submit',
      assignedBy: 'Devesh Gupta',
      action: ''),
  _TaskData(
      name: 'Report EOD to Neloy Sir - EOD of the ...',
      assignDate: '17 Apr 2025',
      submissionDate: '06 Dec 2023',
      status: 'Resubmitted',
      assignedBy: 'Devesh Gupta',
      action: ''),
  _TaskData(
      name: 'Attend 1-1 Meeting - EOD on the ...',
      assignDate: '16 Mar 2024',
      submissionDate: '02 Apr 2025',
      status: 'Pending',
      assignedBy: 'Devesh Gupta',
      action: ''),
  _TaskData(
      name: 'Add a Quiz for Students of 3CO - Report on the ...',
      assignDate: '16 Mar 2024',
      submissionDate: '17 Jun 2025',
      status: 'Reassign',
      assignedBy: 'Devesh Gupta',
      action: 'Reassign'),
  _TaskData(
      name: 'Complete All Pending Assignments ...',
      assignDate: '16 Mar 2024',
      submissionDate: '22 Feb 2025',
      status: 'Assign',
      assignedBy: 'Devesh Gupta',
      action: ''),
  _TaskData(
      name: 'Take meeting of camps team ...',
      assignDate: '17 Apr 2025',
      submissionDate: '24 Oct 2024',
      status: 'Submitted',
      assignedBy: 'Devesh Gupta',
      action: ''),
  _TaskData(
      name: 'Complete All Pending Assignments ...',
      assignDate: '16 Mar 2024',
      submissionDate: '02 Apr 2025',
      status: 'Not Submit',
      assignedBy: 'Niloy Deb',
      action: ''),
  _TaskData(
      name: 'Take meeting of camps team ...',
      assignDate: '17 Jun 2023',
      submissionDate: '29 Oct 2024',
      status: 'Submitted',
      assignedBy: 'Devesh Gupta',
      action: ''),
];
