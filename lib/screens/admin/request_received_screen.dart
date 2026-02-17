import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/expandable_table_row.dart';
import '../../widgets/status_workflow_dialog.dart';

class RequestReceivedScreen extends StatefulWidget {
  const RequestReceivedScreen({super.key});

  @override
  State<RequestReceivedScreen> createState() => _RequestReceivedScreenState();
}

class _RequestReceivedScreenState extends State<RequestReceivedScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(),
          const SizedBox(height: 12),
          _buildRequestTable(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Row(
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
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0), child: const Text('Search', style: TextStyle(fontSize: 10))),
        const Spacer(),
        ..._buildFilters(),
      ],
    );
  }

  List<Widget> _buildFilters() {
    return ['Business Segment', 'Department', 'Client', 'Program'].map((l) => Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(l, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
        ]),
      ),
    )).toList();
  }

  Widget _buildRequestTable() {
    final requests = [
      _RequestData('07-03-2024', '10-03-2024', 'Niloy Deb', 'Program Manager', 'Delete Course', 'Approved',
        courseName: 'MIT Introduction to Computer Science', courseDesc: 'Comprehensive CS course', duration: '21hrs', author: 'Niloy Deb', programManager: 'Shital Patil', trainer: 'Clement Pinto', learnerCount: '312', reason: 'Course content outdated', attachment: 'reason.pdf'),
      _RequestData('9-9-2025', '12-9-2025', 'Reetu Kulita', 'Program Manager', 'Guest Delete', 'Approved',
        guestName: 'Ashish Singh', courseName: 'UI/UX Designs for Beginners', roleAssign: 'Guest Trainer', businessSegment: 'Design', department: 'UX Team', client: 'Beta Inc', program: 'Design Program', startDate: '01-10-2025', endDate: '31-12-2025', hoursAssigned: '40', mobile: '9876543210', email: 'ashish@example.com', reason: 'Guest no longer available'),
      _RequestData('07-03-2024', '08-03-2024', 'Niloy Deb', 'Program Manager', 'Delete Course', 'Rejected',
        courseName: 'Software Testing Manual', courseDesc: 'Testing fundamentals', duration: '29hrs', author: 'Piyush Notani', programManager: 'Ganesh AnandRaj', trainer: 'Ashish Singh', learnerCount: '0', reason: 'Duplicate course', attachment: 'details.pdf'),
      _RequestData('15-04-2025', '', 'Shruti Shubham Patil', 'Program Manager', 'Guest Delete', 'New',
        guestName: 'Zohra Sawant', courseName: 'NLP with AI', roleAssign: 'Trainee', businessSegment: 'AI/ML', department: 'Research', client: 'Gamma Ltd', program: 'AI Masters', startDate: '01-05-2025', endDate: '31-08-2025', hoursAssigned: '60', mobile: '9123456789', email: 'zohra@example.com', reason: 'Project reassignment'),
      _RequestData('07-03-2024', '09-03-2024', 'Niloy Deb', 'Program Manager', 'Delete Course', 'Approved',
        courseName: 'The new course for coders', courseDesc: 'Future coding skills', duration: '21hrs', author: 'Niloy Deb', programManager: 'Shital Patil', trainer: 'Clement Pinto', learnerCount: '312', reason: 'Restructuring program', attachment: 'approval.pdf'),
      _RequestData('20-07-2025', '25-07-2025', 'Clement Pinto', 'Program Manager', 'Delete Course', 'Rejected',
        courseName: 'Natural Language Processing', courseDesc: 'NLP fundamentals with AI', duration: '11hrs', author: 'Divya Shetty', programManager: 'Rachana Singh', trainer: 'Prasant Dihge', learnerCount: '0', reason: 'Active learners enrolled', attachment: ''),
      _RequestData('01-08-2025', '', 'Lavesh Paryani', 'Program Manager', 'Guest Delete', 'Under Review',
        guestName: 'Dimple Didwani', courseName: 'Software Testing', roleAssign: 'Guest Trainer', businessSegment: 'QA', department: 'Testing', client: 'Delta Corp', program: 'QA Program', startDate: '01-09-2025', endDate: '31-12-2025', hoursAssigned: '50', mobile: '9871234567', email: 'dimple@example.com', reason: 'Guest contract ended'),
      _RequestData('10-09-2025', '12-09-2025', 'Piyush Notani', 'Program Manager', 'Exam Course', 'Approved',
        courseName: 'Advanced SQL Queries', courseDesc: 'Exam for SQL proficiency', duration: '45mins', author: 'Piyush Notani', programManager: 'Ganesh AnandRaj', trainer: 'Ashish Singh', learnerCount: '24', reason: 'Quarterly assessment', attachment: 'exam_schedule.pdf'),
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(children: [
              _hdr('Info', 30), _hdr('Date', 70), _hdr('Requester Name', 110), _hdr('Role', 90), _hdr('Request Type', 80), _hdr('Status', 70), _hdr('Action', 40),
            ]),
          ),
          ...requests.map((r) => ExpandableTableRow(
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(children: [
                const SizedBox(width: 30, child: Icon(Icons.info_outline, size: 12, color: AppColors.textGrey)),
                SizedBox(width: 70, child: Text(r.date, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                SizedBox(width: 110, child: Text(r.requesterName, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                SizedBox(width: 90, child: Text(r.role, style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
                SizedBox(width: 80, child: Row(children: [
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: r.requestType == 'Exam Course' ? AppColors.primaryBlue : r.requestType.contains('Delete') ? AppColors.red : AppColors.amber, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text(r.requestType, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                ])),
                SizedBox(width: 70, child: _statusBadge(r.status)),
              ]),
            ),
            expandedContent: _buildExpandedRequest(r),
          )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              const Text('1-6  of  6', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
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

  Widget _buildExpandedRequest(_RequestData r) {
    if (r.requestType == 'Guest Delete') {
      return _buildGuestDeleteDetail(r);
    } else if (r.requestType == 'Exam Course') {
      return _buildExamCourseDetail(r);
    } else {
      return _buildDeleteCourseDetail(r);
    }
  }

  Widget _buildGuestDeleteDetail(_RequestData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate),
          _detailItem('Request Type', r.requestType),
          _detailItem('Requester Name', r.requesterName),
        ]),
        const SizedBox(height: 6),
        Row(children: [const Text('Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)), _statusBadge(r.status)]),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Guest Name', r.guestName),
          _detailItem('Course Name', r.courseName),
          _detailItem('Role Assign', r.roleAssign),
          _detailItem('Business Segment', r.businessSegment),
          _detailItem('Department', r.department),
          _detailItem('Client', r.client),
          _detailItem('Program', r.program),
          _detailItem('Start Date', r.startDate),
          _detailItem('End Date', r.endDate),
          _detailItem('Hours Assigned', r.hoursAssigned),
          _detailItem('Mobile Number', r.mobile),
          _detailItem('Email ID', r.email),
        ]),
        const SizedBox(height: 8),
        _detailItem('Reason', r.reason),
        if (r.status == 'New') ...[
          const SizedBox(height: 10),
          _buildActionButtons(),
        ],
      ],
    );
  }

  Widget _buildDeleteCourseDetail(_RequestData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate),
          _detailItem('Request Type', r.requestType),
          _detailItem('Requester Name', r.requesterName),
        ]),
        const SizedBox(height: 6),
        Row(children: [const Text('Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)), _statusBadge(r.status)]),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Name', r.courseName),
          _detailItem('Course Description', r.courseDesc),
          _detailItem('Duration', r.duration),
          _detailItem('Author', r.author),
          _detailItem('Program Manager', r.programManager),
          _detailItem('Trainer', r.trainer),
          _detailItem('Learner Count', r.learnerCount),
        ]),
        const SizedBox(height: 6),
        _detailItem('Reason', r.reason),
        if (r.attachment.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.attach_file, size: 12, color: AppColors.primaryBlue),
            const SizedBox(width: 4),
            Text(r.attachment, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
          ]),
        ],
        if (r.status == 'New') ...[
          const SizedBox(height: 10),
          _buildActionButtons(),
        ],
      ],
    );
  }

  Widget _buildExamCourseDetail(_RequestData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate),
          _detailItem('Request Type', r.requestType),
          _detailItem('Requester Name', r.requesterName),
        ]),
        const SizedBox(height: 6),
        Row(children: [const Text('Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)), _statusBadge(r.status)]),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Name', r.courseName),
          _detailItem('Course Description', r.courseDesc),
          _detailItem('Duration', r.duration),
          _detailItem('Author', r.author),
          _detailItem('Program Manager', r.programManager),
          _detailItem('Trainer', r.trainer),
          _detailItem('Learner Count', r.learnerCount),
        ]),
        const SizedBox(height: 6),
        _detailItem('Reason', r.reason),
        if (r.attachment.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.attach_file, size: 12, color: AppColors.primaryBlue),
            const SizedBox(width: 4),
            Text(r.attachment, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
          ]),
        ],
        if (r.status == 'New' || r.status == 'Under Review') ...[
          const SizedBox(height: 10),
          _buildActionButtons(),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        SizedBox(
          height: 26,
          child: ElevatedButton(
            onPressed: () => showWorkflowDialog(context, action: WorkflowAction.approve, title: 'Approve Request'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 10), elevation: 0),
            child: const Text('Approve', style: TextStyle(fontSize: 9)),
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          height: 26,
          child: ElevatedButton(
            onPressed: () => showWorkflowDialog(context, action: WorkflowAction.reject, title: 'Reject Request'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 10), elevation: 0),
            child: const Text('Reject', style: TextStyle(fontSize: 9)),
          ),
        ),
      ],
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
          Text(value.isEmpty ? '-' : value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _hdr(String text, double width) => SizedBox(width: width, child: Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey)));

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'Approved': color = AppColors.green; break;
      case 'Rejected': color = AppColors.red; break;
      case 'New': color = AppColors.primaryBlue; break;
      case 'Under Review': color = AppColors.amber; break;
      default: color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }
}

class _RequestData {
  final String date, actionDate, requesterName, role, requestType, status;
  final String courseName, courseDesc, duration, author, programManager, trainer, learnerCount, reason, attachment;
  final String guestName, roleAssign, businessSegment, department, client, program, startDate, endDate, hoursAssigned, mobile, email;

  _RequestData(this.date, this.actionDate, this.requesterName, this.role, this.requestType, this.status, {
    this.courseName = '', this.courseDesc = '', this.duration = '', this.author = '', this.programManager = '', this.trainer = '', this.learnerCount = '', this.reason = '', this.attachment = '',
    this.guestName = '', this.roleAssign = '', this.businessSegment = '', this.department = '', this.client = '', this.program = '', this.startDate = '', this.endDate = '', this.hoursAssigned = '', this.mobile = '', this.email = '',
  });
}
