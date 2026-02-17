import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/expandable_table_row.dart';
import '../../widgets/status_workflow_dialog.dart';
import '../../widgets/feedback_dialog.dart';

class ManageCourseScreen extends StatefulWidget {
  const ManageCourseScreen({super.key});

  @override
  State<ManageCourseScreen> createState() => _ManageCourseScreenState();
}

class _ManageCourseScreenState extends State<ManageCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(context),
          const SizedBox(height: 12),
          _buildCourseTable(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180, height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 14),
                  prefixIconConstraints: const BoxConstraints(minWidth: 30),
                  hintText: 'Search ...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/create-course'),
              icon: const Icon(Icons.add, size: 12),
              label: const Text('New Course', style: TextStyle(fontSize: 10)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildFilterChip('Business Segment'),
            _buildFilterChip('Department'),
            _buildFilterChip('Client'),
            _buildFilterChip('Program'),
            _buildFilterChip('Program Manager'),
            _buildFilterChip('Trainer'),
            _buildFilterChip('Author'),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
        ]),
      ),
    );
  }

  Widget _buildCourseTable() {
    final courses = [
      _CourseData('The new course for the coders of future....', '21hrs:32mins', '312', 'Published', 'Self', '12-01-2024', '12-01-2024', 'Engineering', 'Software Dev', 'Acme Corp', 'Coding Bootcamp', 'Niloy Deb', 'Shital Patil', 'Clement Pinto', true, '01-02-2024', '30-06-2024'),
      _CourseData('UI/UX Designs for Beginners with Generative', '104hrs:53mins', '109', 'Rejected', 'Request', '05-03-2025', '10-03-2025', 'Design', 'UX Team', 'Beta Inc', 'Design Program', 'Zohra Sawant', 'Ankit Pandey', 'Reetu Kulita', false, '15-03-2025', '15-09-2025'),
      _CourseData('Natural Language Processing (NLP) with AI', '11hrs:02mins', '0', 'Approved', 'Self', '20-06-2024', '20-06-2024', 'AI/ML', 'Research', 'Gamma Ltd', 'AI Masters', 'Divya Shetty', 'Rachana Singh', 'Prasant Dihge', true, '01-07-2024', '31-12-2024'),
      _CourseData('MIT Introduction to Computer Science and Pr', '01hrs:09mins', '12', 'Inactive', 'Request', '01-01-2023', '15-01-2023', 'Education', 'CS Dept', 'MIT', 'CS101', 'Lavesh Paryani', 'Om Auti', 'Anil Verma', false, '01-02-2023', '30-06-2023'),
      _CourseData('Software Testing - Manual Testing, Automatio', '29hrs:56mins', '0', 'Under Review', 'Self', '10-10-2024', '10-10-2024', 'QA', 'Testing', 'Delta Corp', 'QA Program', 'Piyush Notani', 'Ganesh AnandRaj', 'Ashish Singh', true, '01-11-2024', '30-04-2025'),
      _CourseData('The new course for the coders of future....', '21hrs:32mins', '312', 'Published', 'Self', '12-01-2024', '12-01-2024', 'Engineering', 'Software Dev', 'Acme Corp', 'Coding Bootcamp', 'Niloy Deb', 'Shital Patil', 'Clement Pinto', true, '01-02-2024', '30-06-2024'),
      _CourseData('The new course for the coders of future....', '21hrs:32mins', '312', 'Published', 'Request', '12-01-2024', '15-01-2024', 'Engineering', 'Software Dev', 'Acme Corp', 'Coding Bootcamp', 'Niloy Deb', 'Shital Patil', 'Clement Pinto', false, '01-02-2024', '30-06-2024'),
      _CourseData('UI/UX Designs for Beginners with Generative', '104hrs:53mins', '109', 'Rejected', 'Self', '05-03-2025', '05-03-2025', 'Design', 'UX Team', 'Beta Inc', 'Design Program', 'Zohra Sawant', 'Ankit Pandey', 'Reetu Kulita', true, '15-03-2025', '15-09-2025'),
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(children: [
              _headerCell('Select', width: 35),
              _headerCell('Info', width: 20),
              _headerCell('Course Name', flex: 3),
              _headerCell('Duration', flex: 2),
              _headerCell('Learners', flex: 1),
              _headerCell('Status', flex: 2),
              _headerCell('People Involved', flex: 2),
              _headerCell('Actions', flex: 1),
            ]),
          ),
          ...courses.map((c) => ExpandableTableRow(
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(children: [
                SizedBox(width: 35, child: Checkbox(value: false, onChanged: (_) {}, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                SizedBox(width: 20, child: const Icon(Icons.info_outline, size: 12, color: AppColors.textGrey)),
                Expanded(flex: 3, child: Text(c.name, style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
                Expanded(flex: 2, child: Text(c.duration, style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
                Expanded(flex: 1, child: Text(c.learners, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                Expanded(flex: 2, child: _statusBadge(c.status)),
                Expanded(flex: 2, child: _buildPeopleInvolved()),
                Expanded(flex: 1, child: _buildCourseActionMenu(c)),
              ]),
            ),
            expandedContent: _buildExpandedCourseDetail(c),
          )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              const Text('1-8  of  8', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
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

  Widget _buildExpandedCourseDetail(_CourseData c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Course Details
        const Text('Course Details', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 20,
          runSpacing: 6,
          children: [
            _detailItem('Course Name', c.name),
            _detailItem('Creation Date', c.creationDate),
            _detailItem('Last Update Date', c.lastUpdateDate),
            _detailItem('Business Segment', c.businessSegment),
            _detailItem('Department', c.department),
            _detailItem('Client', c.client),
            _detailItem('Program', c.program),
            _detailItem('Author', c.author),
            _detailItem('Program Manager', c.programManager),
            _detailItem('Trainer', c.trainer),
            _detailItem('Certificate', c.hasCertificate ? 'Yes' : 'No'),
            _detailItem('Start Date', c.startDate),
            _detailItem('End Date', c.endDate),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 10),
        // Creation Type
        const Text('Creation Type', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 6),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: c.creationType == 'Request' ? AppColors.amber.withValues(alpha: 0.1) : AppColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(c.creationType, style: TextStyle(fontSize: 9, color: c.creationType == 'Request' ? AppColors.amber : AppColors.primaryBlue, fontWeight: FontWeight.w500)),
          ),
          if (c.creationType == 'Request') ...[
            const SizedBox(width: 12),
            _detailItem('Requester Name', c.author),
            const SizedBox(width: 12),
            _detailItem('Request Date', c.creationDate),
          ],
        ]),
        const SizedBox(height: 12),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 10),
        // Status section
        Row(children: [
          const Text('Status: ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          _statusBadge(c.status),
        ]),
        const SizedBox(height: 12),
        // Workflow buttons
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _workflowButton('Rework', Icons.replay, AppColors.amber, WorkflowAction.rework, 'Course Sent for Rework'),
            _workflowButton('Reject', Icons.cancel_outlined, AppColors.red, WorkflowAction.reject, 'Course is Rejected'),
            _workflowButton('Approve', Icons.check_circle_outline, AppColors.green, WorkflowAction.approve, 'Course is Approved'),
            _workflowButton('Publish', Icons.publish, AppColors.primaryBlue, WorkflowAction.publish, 'Course is Publishing', showProgressBar: true),
            _workflowButton('Activate', Icons.toggle_on_outlined, AppColors.green, WorkflowAction.activate, 'Course is Activating'),
            _workflowButton('Inactivate', Icons.toggle_off_outlined, AppColors.orange, WorkflowAction.inactivate, 'Course is Inactivating'),
            _workflowButton('Delete', Icons.delete_outline, AppColors.red, WorkflowAction.delete, 'Course is getting Delete'),
          ],
        ),
      ],
    );
  }

  Widget _workflowButton(String label, IconData icon, Color color, WorkflowAction action, String title, {bool showProgressBar = false}) {
    return SizedBox(
      height: 26,
      child: ElevatedButton.icon(
        onPressed: () => showWorkflowDialog(
          context,
          action: action,
          title: title,
          showProgressBar: showProgressBar,
          showComment: action != WorkflowAction.publish && action != WorkflowAction.activate && action != WorkflowAction.inactivate,
        ),
        icon: Icon(icon, size: 11),
        label: Text(label, style: const TextStyle(fontSize: 9)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          const SizedBox(height: 1),
          Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  static Widget _headerCell(String text, {double? width, int flex = 1}) {
    final child = Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey));
    if (width != null) return SizedBox(width: width, child: child);
    return Expanded(flex: flex, child: child);
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'Published': color = AppColors.statusPublished; break;
      case 'Rejected': color = AppColors.statusRejected; break;
      case 'Approved': color = AppColors.statusApproved; break;
      case 'Inactive': color = AppColors.statusInactive; break;
      case 'Under Review': color = AppColors.statusUnderReview; break;
      case 'Deleted': color = AppColors.red; break;
      default: color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildPeopleInvolved() {
    return Row(children: [
      _roleDot('PM', AppColors.red),
      _roleDot('A', AppColors.amber),
      _roleDot('T', AppColors.primaryBlue),
    ]);
  }

  Widget _roleDot(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      width: 14, height: 14,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(child: Text(label, style: const TextStyle(fontSize: 6, color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildCourseActionMenu(_CourseData c) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'view', height: 28, child: Text('View', style: TextStyle(fontSize: 10))),
        const PopupMenuItem(value: 'edit', height: 28, child: Text('Edit', style: TextStyle(fontSize: 10))),
        const PopupMenuItem(value: 'inactive', height: 28, child: Text('Inactive', style: TextStyle(fontSize: 10))),
        const PopupMenuItem(value: 'active', height: 28, child: Text('Active', style: TextStyle(fontSize: 10))),
        const PopupMenuItem(value: 'delete', height: 28, child: Text('Delete', style: TextStyle(fontSize: 10, color: AppColors.red))),
        const PopupMenuItem(value: 'reject', height: 28, child: Text('Reject', style: TextStyle(fontSize: 10, color: AppColors.red))),
        const PopupMenuItem(value: 'approve', height: 28, child: Text('Approve', style: TextStyle(fontSize: 10, color: AppColors.green))),
        const PopupMenuItem(value: 'publish', height: 28, child: Text('Published', style: TextStyle(fontSize: 10))),
        const PopupMenuItem(value: 'feedback', height: 28, child: Text('Feedback', style: TextStyle(fontSize: 10))),
      ],
      onSelected: (val) {
        switch (val) {
          case 'inactive': showWorkflowDialog(context, action: WorkflowAction.inactivate, title: 'Course is Inactivating'); break;
          case 'active': showWorkflowDialog(context, action: WorkflowAction.activate, title: 'Course is Activating'); break;
          case 'delete': showWorkflowDialog(context, action: WorkflowAction.delete, title: 'Course is getting Delete', showComment: true); break;
          case 'reject': showWorkflowDialog(context, action: WorkflowAction.reject, title: 'Course is Rejected', showComment: true); break;
          case 'approve': showWorkflowDialog(context, action: WorkflowAction.approve, title: 'Course is Approved'); break;
          case 'publish': showWorkflowDialog(context, action: WorkflowAction.publish, title: 'Course is Publishing', showProgressBar: true); break;
          case 'feedback': showFeedbackDialog(context); break;
          default: break;
        }
      },
    );
  }
}

class _CourseData {
  final String name, duration, learners, status, creationType;
  final String creationDate, lastUpdateDate, businessSegment, department;
  final String client, program, author, programManager, trainer;
  final bool hasCertificate;
  final String startDate, endDate;

  _CourseData(this.name, this.duration, this.learners, this.status,
      this.creationType, this.creationDate, this.lastUpdateDate,
      this.businessSegment, this.department, this.client, this.program,
      this.author, this.programManager, this.trainer, this.hasCertificate,
      this.startDate, this.endDate);
}
