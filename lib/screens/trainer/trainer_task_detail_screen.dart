import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class TrainerTaskDetailScreen extends StatefulWidget {
  const TrainerTaskDetailScreen({super.key});

  @override
  State<TrainerTaskDetailScreen> createState() => _TrainerTaskDetailScreenState();
}

class _TrainerTaskDetailScreenState extends State<TrainerTaskDetailScreen> {
  final _submissions = const [
    _SubmissionRow('Monika', 'Verma', 'Submitted', '12-04-2025, 09:34 AM', true),
    _SubmissionRow('Monika', 'Verma', 'Not Submit', '', false),
    _SubmissionRow('Monika', 'Verma', 'Not Submit', '', false),
    _SubmissionRow('Monika', 'Verma', 'Pending', '12-04-2025, 10:28 AM', true),
    _SubmissionRow('Monika', 'Verma', 'Resubmitted', '12-04-2025, 09:31 AM', true),
    _SubmissionRow('Monika', 'Verma', 'Submitted', '09-04-2025, 09:34 AM', true),
    _SubmissionRow('Monika', 'Verma', 'Not Submit', '', false),
  ];

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
                      const Text('Task Details',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task info
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title + Status
                              Row(
                                children: [
                                  const Text('Title', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: AppColors.borderGrey),
                                      ),
                                      child: const Text('Complete All Pending Assignments',
                                          style: TextStyle(fontSize: 11, color: AppColors.textDark)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.green.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: AppColors.green),
                                    ),
                                    child: const Text('Completed', style: TextStyle(fontSize: 10, color: AppColors.green, fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Description
                              Row(
                                children: [
                                  const Text('Description', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: AppColors.borderGrey),
                                      ),
                                      child: const Text('Complete All Pending Assignments',
                                          style: TextStyle(fontSize: 11, color: AppColors.textDark)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Attachment + Assigned by
                              Row(
                                children: [
                                  const Text('Attachment', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                                  const SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: AppColors.borderGrey),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.attach_file, size: 14, color: AppColors.textGrey),
                                        const SizedBox(width: 4),
                                        const Text('Task1.pdf', style: TextStyle(fontSize: 11, color: AppColors.textDark)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.textDark,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.person_outline, size: 14, color: Colors.white),
                                        const SizedBox(width: 6),
                                        const Text('Devesh Dharmnath Singh Gupta',
                                            style: TextStyle(fontSize: 10, color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Stats row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildStatCard('Trainees', '123', const Color(0xFF2196F3), Icons.people),
                              const SizedBox(width: 12),
                              _buildStatCard('Assignment Date', '08-03-2025', const Color(0xFF455A64), Icons.calendar_today),
                              const SizedBox(width: 12),
                              _buildStatCard('Submission Date', '12-03-2025', const Color(0xFFFF9800), Icons.date_range),
                              const SizedBox(width: 12),
                              _buildStatCard('Submitted', '117', const Color(0xFF4CAF50), Icons.thumb_up),
                              const SizedBox(width: 12),
                              _buildStatCard('Not Submitted', '05', const Color(0xFFE53935), Icons.thumb_down),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Submissions table
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
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 30),
                                    _hCell('First name', flex: 2),
                                    _hCell('Last Name', flex: 2),
                                    _hCell('Status', flex: 2),
                                    _hCell('Submitted Timeout', flex: 3),
                                    _hCell('View', flex: 1),
                                    _hCell('Action', flex: 1),
                                  ],
                                ),
                              ),
                              ..._submissions.map((s) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 30, child: Checkbox(value: false, onChanged: (_) {}, visualDensity: VisualDensity.compact)),
                                        Expanded(flex: 2, child: Text(s.firstName, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                                        Expanded(flex: 2, child: Text(s.lastName, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                                        Expanded(flex: 2, child: _statusDot(s.status)),
                                        Expanded(flex: 3, child: Text(s.timeout, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                                        Expanded(
                                          flex: 1,
                                          child: s.hasView
                                              ? GestureDetector(
                                                  onTap: () => _showDocumentViewer(context),
                                                  child: const Text('View', style: TextStyle(fontSize: 10, color: AppColors.primaryBlue)),
                                                )
                                              : const SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.edit_note, size: 16, color: AppColors.textGrey),
                                              const SizedBox(width: 6),
                                              const Icon(Icons.groups, size: 16, color: AppColors.textGrey),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              // Pagination
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                child: Row(
                                  children: [
                                    Text('1-${_submissions.length} of 1', style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
                                    const Spacer(),
                                    Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.chevron_left, color: Colors.white, size: 18)),
                                    const SizedBox(width: 4),
                                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)), child: const Text('1/1', style: TextStyle(color: Colors.white, fontSize: 10))),
                                    const SizedBox(width: 4),
                                    Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.chevron_right, color: Colors.white, size: 18)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 9, color: color)),
              Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hCell(String label, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.orange)),
          const SizedBox(width: 3),
          Icon(Icons.filter_list, size: 10, color: AppColors.orange),
        ],
      ),
    );
  }

  Widget _statusDot(String status) {
    Color color;
    switch (status) {
      case 'Submitted': color = AppColors.orange; break;
      case 'Not Submit': color = AppColors.red; break;
      case 'Pending': color = AppColors.orange; break;
      case 'Resubmitted': color = AppColors.primaryBlue; break;
      default: color = AppColors.textGrey;
    }
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(status, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }

  void _showDocumentViewer(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: AppColors.topNavBg, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Expanded(child: Text('Reetu_Task1.pdf', style: TextStyle(color: Colors.white, fontSize: 12))),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(4)), child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 10))),
                    const SizedBox(width: 6),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)), child: const Text('100', style: TextStyle(color: Colors.white, fontSize: 10))),
                    const SizedBox(width: 12),
                    const Icon(Icons.download, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: const Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: Text('Reetu Kudia Assignment', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark))),
              const SizedBox(height: 16),
              _detailRow(Icons.calendar_today, 'Assignment Date', '08-03-2025', const Color(0xFF455A64)),
              _detailRow(Icons.date_range, 'Submission Date', '12-03-2025', AppColors.orange),
              _detailRow(Icons.check_circle, 'Submitted Date', '10-03-2025', AppColors.green, hasActions: true),
              _detailRow(Icons.feedback, 'Feedback', 'Clean layout and good responsiveness. Please use company font in assignment.', const Color(0xFF9C27B0)),
              _detailRow(Icons.replay, 'Reassign Date', '08-03-2025', const Color(0xFFE91E63)),
              _detailRow(Icons.redo, 'Resubmitted Date', '10-03-2025', const Color(0xFF00BCD4), hasActions: true),
              _detailRow(Icons.info, 'Status', 'Submitted', AppColors.primaryBlue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value, Color color, {bool hasActions = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120,
            child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
          if (hasActions) ...[
            const Icon(Icons.download, size: 16, color: AppColors.textGrey),
            const SizedBox(width: 8),
            const Icon(Icons.visibility, size: 16, color: AppColors.textGrey),
          ],
        ],
      ),
    );
  }
}

class _SubmissionRow {
  final String firstName, lastName, status, timeout;
  final bool hasView;
  const _SubmissionRow(this.firstName, this.lastName, this.status, this.timeout, this.hasView);
}
