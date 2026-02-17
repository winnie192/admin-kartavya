import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/expandable_table_row.dart';
import 'pm_request_action_dialogs.dart';

class PmRequestsScreen extends StatefulWidget {
  const PmRequestsScreen({super.key});

  @override
  State<PmRequestsScreen> createState() => _PmRequestsScreenState();
}

class _PmRequestsScreenState extends State<PmRequestsScreen> {
  bool _isReceivedTab = true;

  // ── Received tab data ──
  static const _receivedRequests = [
    _ReceivedReqData(
      date: '07-02-2024',
      requesterName: 'Zeenat Khan',
      role: 'Trainer',
      requestType: 'New',
      status: 'Approved',
      actionDate: '10-02-2024',
      courseTitle: 'MIT Introduction to Computer Science',
      courseStatus: 'Published',
      businessSegment: 'Cipla_new',
      department: 'Operations',
      client: 'cipla_abc',
      program: 'cipla_program',
      reason: 'New course submission for review',
    ),
    _ReceivedReqData(
      date: '18-01-1987',
      requesterName: 'Om Padalkar',
      role: 'Author/Trainer',
      requestType: 'Inactive',
      status: 'Approved',
      actionDate: '20-01-1987',
      courseTitle: 'Cloud Computing 101',
      courseStatus: 'Inactive',
      businessSegment: 'Cloud',
      department: 'Infrastructure',
      client: 'cloud_inc',
      program: 'cloud_prog',
      reason: 'Temporarily pause enrollment',
    ),
    _ReceivedReqData(
      date: '09-01-2022',
      requesterName: 'Pratik Indulkar',
      role: 'Author/Trainer',
      requestType: 'Active',
      status: 'New',
      actionDate: '',
      courseTitle: 'NLP with AI',
      courseStatus: 'Active',
      businessSegment: 'AI_seg',
      department: 'Research',
      client: 'ai_client',
      program: 'ai_masters',
      reason: 'Course needs reactivation',
    ),
    _ReceivedReqData(
      date: '31-12-2024',
      requesterName: 'Ankit Pandey',
      role: 'Trainee',
      requestType: 'Expiry',
      status: 'Under Review',
      actionDate: '',
      courseTitle: 'Advanced SQL Queries',
      courseStatus: 'Expired',
      businessSegment: 'Data',
      department: 'Analytics',
      client: 'data_corp',
      program: 'data_prog',
      reason: 'Course access expired, needs extension',
      additionalDate: '31-03-2025',
      attachment: 'extension_request.pdf',
    ),
    _ReceivedReqData(
      date: '12-08-2025',
      requesterName: 'Siddhi Auti',
      role: 'Author',
      requestType: 'Delete',
      status: 'Rejected',
      actionDate: '14-08-2025',
      courseTitle: 'Software Testing Manual',
      courseStatus: 'Published',
      businessSegment: 'Gamma',
      department: 'QA',
      client: 'gamma_ltd',
      program: 'qa_prog',
      reason: 'Course content outdated',
    ),
    _ReceivedReqData(
      date: '17-03-2023',
      requesterName: 'Ganesh Anandraj',
      role: 'Trainer',
      requestType: 'Edit',
      status: 'New',
      actionDate: '',
      courseTitle: 'UI/UX Designs for Beginners',
      courseStatus: 'Published',
      businessSegment: 'Beta',
      department: 'Design',
      client: 'beta_inc',
      program: 'design_prog',
      reason: 'Content update required',
    ),
    _ReceivedReqData(
      date: '01-11-2025',
      requesterName: 'Rachana Dhamnath Singh',
      role: 'Trainee',
      requestType: 'Refresher',
      status: 'Rejected',
      actionDate: '05-11-2025',
      courseTitle: 'Database Management & SQL',
      courseStatus: 'Published',
      businessSegment: 'DB',
      department: 'Backend',
      client: 'db_corp',
      program: 'backend_prog',
      reason: 'Refresher training for batch 2025',
      additionalDate: '20-11-2025',
      suggestions: 'Cover advanced joins and optimization',
    ),
    _ReceivedReqData(
      date: '29-06-2023',
      requesterName: 'Divya Balakrishna Shetty',
      role: 'Trainee',
      requestType: '1-1 Training',
      status: 'Approved',
      actionDate: '02-07-2023',
      courseTitle: 'React Advanced Patterns',
      courseStatus: 'Published',
      businessSegment: 'Web',
      department: 'Frontend',
      client: 'web_inc',
      program: 'frontend_prog',
      reason: 'Personal training session needed',
      additionalDate: '15-07-2023',
      suggestions: 'Focus on hooks and context API',
    ),
  ];

  // ── Send tab data ──
  static const _sendRequests = [
    _SendReqData(
      date: '18-01-1987',
      recipientName: 'Rohit Rai',
      roleCode: 'AD',
      roleFull: 'Admin',
      requestType: 'Delete',
      status: 'Accepted',
      actionDate: '20-01-1987',
      courseTitle: 'Legacy Course Archive',
      courseStatus: 'Published',
      businessSegment: 'Admin_seg',
      department: 'Admin',
      client: 'admin_client',
      program: 'admin_prog',
    ),
    _SendReqData(
      date: '08-01-1993',
      recipientName: 'Divya Balakrishna Shetty',
      roleCode: 'A',
      roleFull: 'Author',
      requestType: 'Feedback',
      status: 'Waiting',
      actionDate: '',
      courseTitle: 'React Advanced Patterns',
      courseStatus: 'Published',
      businessSegment: 'Web',
      department: 'Frontend',
      client: 'web_inc',
      program: 'frontend_prog',
      feedbackType: 'Content Review',
      comment: 'Please review chapter 5 on advanced hooks and provide feedback on accuracy.',
    ),
    _SendReqData(
      date: '28-09-2025',
      recipientName: 'Zeenat Khan,Reetu k ... +14 more',
      roleCode: 'T/T',
      roleFull: 'Trainer',
      requestType: 'Retrain',
      status: 'Accepted',
      actionDate: '01-10-2025',
      courseTitle: 'Cloud Computing 101',
      courseStatus: 'Active',
      businessSegment: 'Cloud',
      department: 'Infrastructure',
      client: 'cloud_inc',
      program: 'cloud_prog',
      recipientList: ['Zeenat Khan', 'Reetu Kulita', 'Om Padalkar', 'Pratik Indulkar'],
      trainerName: 'Ganesh Anandraj',
      comment: 'Retrain batch on updated modules',
      fromDate: '05-10-2025',
      toDate: '20-10-2025',
      slotBatch: 'Batch A',
      slotTime: '10:00 AM - 12:00 PM',
    ),
    _SendReqData(
      date: '09-04-2024',
      recipientName: 'Zeenat Khan,Reetu k ... +9 more',
      roleCode: 'T',
      roleFull: 'Trainer',
      requestType: 'Retrain',
      status: 'Rejected',
      actionDate: '12-04-2024',
      courseTitle: 'NLP with AI',
      courseStatus: 'Active',
      businessSegment: 'AI_seg',
      department: 'Research',
      client: 'ai_client',
      program: 'ai_masters',
      recipientList: ['Zeenat Khan', 'Reetu Kulita', 'Siddhi Auti'],
      trainerName: 'Clement Pinto',
      comment: 'Refresher on NLP concepts',
      fromDate: '15-04-2024',
      toDate: '30-04-2024',
      slotBatch: 'Batch B',
      slotTime: '2:00 PM - 4:00 PM',
    ),
    _SendReqData(
      date: '21-12-2024',
      recipientName: 'Divya Balakrishna Shetty',
      roleCode: 'A',
      roleFull: 'Author',
      requestType: 'Rework',
      status: 'Accepted',
      actionDate: '23-12-2024',
      courseTitle: 'Software Testing Manual',
      courseStatus: 'Published',
      businessSegment: 'Gamma',
      department: 'QA',
      client: 'gamma_ltd',
      program: 'qa_prog',
      reworkReason: 'Content needs revision for accuracy',
      startDate: '01-01-2025',
      endDate: '15-01-2025',
      suggestions: 'Focus on automation testing chapter',
      attachment: 'rework_guidelines.pdf',
    ),
    _SendReqData(
      date: '18-01-1987',
      recipientName: 'Rohit Rai',
      roleCode: 'AD',
      roleFull: 'Admin',
      requestType: 'Delete',
      status: 'Accepted',
      actionDate: '20-01-1987',
      courseTitle: 'Archived Training Module',
      courseStatus: 'Inactive',
      businessSegment: 'Admin_seg',
      department: 'Admin',
      client: 'admin_client',
      program: 'admin_prog',
    ),
    _SendReqData(
      date: '01-07-2023',
      recipientName: 'Jatin Bhalerao Patil',
      roleCode: 'A',
      roleFull: 'Author',
      requestType: 'Forward',
      status: 'Rejected',
      actionDate: '05-07-2023',
      courseTitle: 'Advanced SQL Queries',
      courseStatus: 'Published',
      businessSegment: 'Data',
      department: 'Analytics',
      client: 'data_corp',
      program: 'data_prog',
      comment: 'Forward for additional review',
      attachment: 'forward_note.pdf',
      currentDate: '01-07-2023',
      expectedDate: '15-07-2023',
    ),
    _SendReqData(
      date: '23-06-2026',
      recipientName: 'Yashodha Anchan,Reetu k ... +9 more',
      roleCode: 'T',
      roleFull: 'Trainer',
      requestType: 'Meeting',
      status: 'Waiting',
      actionDate: '',
      courseTitle: 'UI/UX Designs for Beginners',
      courseStatus: 'Active',
      businessSegment: 'Beta',
      department: 'Design',
      client: 'beta_inc',
      program: 'design_prog',
    ),
  ];

  // ── Request type colors ──
  static const _receivedTypeColors = <String, Color>{
    'New': AppColors.primaryBlue,
    'Edit': AppColors.amber,
    'Delete': AppColors.red,
    'Active': AppColors.green,
    'Inactive': AppColors.grey,
    'Expiry': AppColors.orange,
    '1-1 Training': Color(0xFF9C27B0),
    'Refresher': Color(0xFF009688),
  };

  static const _sendTypeColors = <String, Color>{
    'Delete': AppColors.red,
    'Feedback': AppColors.primaryBlue,
    'Rework': AppColors.amber,
    'Forward': AppColors.primaryBlue,
    'Retrain': AppColors.orange,
    'Meeting': AppColors.green,
  };

  // ── Role badge colors for Send tab ──
  static const _roleCodeColors = <String, Color>{
    'AD': AppColors.grey,
    'A': AppColors.amber,
    'T': AppColors.primaryBlue,
    'T/T': AppColors.primaryBlue,
    'TN': AppColors.green,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabToggle(),
          const SizedBox(height: 12),
          _buildSearchAndFilters(),
          const SizedBox(height: 12),
          if (_isReceivedTab) _buildReceivedTable() else _buildSendTable(),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════
  //  Tab toggle (Received / Send pill buttons)
  // ════════════════════════════════════════════════
  Widget _buildTabToggle() {
    return Row(
      children: [
        _pillButton('Received', isActive: _isReceivedTab, onTap: () {
          if (!_isReceivedTab) setState(() => _isReceivedTab = true);
        }),
        const SizedBox(width: 8),
        _pillButton('Send', isActive: !_isReceivedTab, onTap: () {
          if (_isReceivedTab) setState(() => _isReceivedTab = false);
        }),
      ],
    );
  }

  Widget _pillButton(String label, {required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppColors.primaryBlue : AppColors.borderGrey,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.textGrey,
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════
  //  Search bar, date pickers, filter dropdowns
  // ════════════════════════════════════════════════
  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180,
              height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 14),
                  prefixIconConstraints: const BoxConstraints(minWidth: 30),
                  hintText: 'Search ...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
            const Spacer(),
            ..._buildFilters(),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDatePicker('From'),
            const SizedBox(width: 8),
            _buildDatePicker('To'),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.calendar_today, size: 10, color: AppColors.textGrey),
        ],
      ),
    );
  }

  List<Widget> _buildFilters() {
    return ['Business Segment', 'Department', 'Client', 'Program']
        .map((l) => Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
                  ],
                ),
              ),
            ))
        .toList();
  }

  // ════════════════════════════════════════════════
  //  RECEIVED TABLE
  // ════════════════════════════════════════════════
  Widget _buildReceivedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              children: [
                _hdr('Info', flex: 1),
                _hdr('Date', width: 70),
                _hdr('Requester Name', width: 120),
                _hdr('Role', width: 80),
                _hdr('Request Type', width: 80),
                _hdr('Status', width: 80),
                _hdr('Actions', width: 40),
              ],
            ),
          ),
          // Data rows
          ..._receivedRequests.map((r) => ExpandableTableRow(
                header: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Icon(Icons.info_outline, size: 12, color: AppColors.textGrey),
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(r.date, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(r.requesterName, style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(width: 80, child: _roleBadgeFull(r.role)),
                      SizedBox(width: 80, child: _requestTypeBadge(r.requestType, _receivedTypeColors)),
                      SizedBox(width: 80, child: _receivedStatusBadge(r.status)),
                      SizedBox(
                        width: 40,
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'accept', child: Text('Accept', style: TextStyle(fontSize: 10))),
                            PopupMenuItem(value: 'reject', child: Text('Reject', style: TextStyle(fontSize: 10))),
                            PopupMenuItem(value: 'discuss', child: Text('Discussion', style: TextStyle(fontSize: 10))),
                          ],
                          onSelected: (v) {
                            switch (v) {
                              case 'accept':
                                showPmAcceptDialog(context);
                                break;
                              case 'reject':
                                showPmRejectDialog(context);
                                break;
                              case 'discuss':
                                showPmDiscussionDialog(context);
                                break;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                expandedContent: _buildReceivedExpanded(r),
              )),
          // Pagination
          _buildPagination(_receivedRequests.length),
        ],
      ),
    );
  }

  Widget _buildReceivedExpanded(_ReceivedReqData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate.isEmpty ? '-' : r.actionDate),
          _detailItem('Request Type', r.requestType),
        ]),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Requester Name: ', style: TextStyle(fontSize: 8, color: AppColors.textGrey)),
            Text(r.requesterName, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            const SizedBox(width: 6),
            _roleBadgeFull(r.role),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Request Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            _receivedStatusBadge(r.status),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Title', r.courseTitle),
          _detailItem('Course Status', r.courseStatus),
          _detailItem('Business Segment', r.businessSegment),
          _detailItem('Department', r.department),
          _detailItem('Client', r.client),
          _detailItem('Program', r.program),
        ]),
        if (r.reason.isNotEmpty) ...[
          const SizedBox(height: 6),
          _detailItem('Reason', r.reason),
        ],
        if (r.additionalDate.isNotEmpty) ...[
          const SizedBox(height: 4),
          _detailItem('Date', r.additionalDate),
        ],
        if (r.attachment.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.attach_file, size: 12, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              Text(r.attachment, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
            ],
          ),
        ],
        if (r.suggestions.isNotEmpty) ...[
          const SizedBox(height: 4),
          _detailItem('Suggestions', r.suggestions),
        ],
        if (r.status == 'New' || r.status == 'Under Review') ...[
          const SizedBox(height: 10),
          _buildReceivedActionButtons(),
        ],
      ],
    );
  }

  Widget _buildReceivedActionButtons() {
    return Row(
      children: [
        SizedBox(
          height: 26,
          child: ElevatedButton.icon(
            onPressed: () => showPmAcceptDialog(context),
            icon: const Icon(Icons.check, size: 12),
            label: const Text('Accept', style: TextStyle(fontSize: 9)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          height: 26,
          child: ElevatedButton.icon(
            onPressed: () => showPmRejectDialog(context),
            icon: const Icon(Icons.close, size: 12),
            label: const Text('Reject', style: TextStyle(fontSize: 9)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          height: 26,
          child: OutlinedButton.icon(
            onPressed: () => showPmDiscussionDialog(context),
            icon: const Icon(Icons.chat_outlined, size: 12, color: AppColors.primaryBlue),
            label: const Text('Discussion', style: TextStyle(fontSize: 9, color: AppColors.primaryBlue)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════
  //  SEND TABLE
  // ════════════════════════════════════════════════
  Widget _buildSendTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              children: [
                _hdr('Info', flex: 1),
                _hdr('Date', width: 70),
                _hdr('Recipient Name', width: 140),
                _hdr('Role', width: 60),
                _hdr('Request Type', width: 80),
                _hdr('Status', width: 70),
                _hdr('Actions', width: 40),
              ],
            ),
          ),
          // Data rows
          ..._sendRequests.map((r) => ExpandableTableRow(
                header: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Icon(Icons.info_outline, size: 12, color: AppColors.textGrey),
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(r.date, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                      ),
                      SizedBox(
                        width: 140,
                        child: Text(r.recipientName, style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(width: 60, child: _roleCodeBadge(r.roleCode, r.roleFull)),
                      SizedBox(width: 80, child: _requestTypeBadge(r.requestType, _sendTypeColors)),
                      SizedBox(width: 70, child: _sendStatusBadge(r.status)),
                      SizedBox(
                        width: 40,
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'view', child: Text('View', style: TextStyle(fontSize: 10))),
                            PopupMenuItem(value: 'cancel', child: Text('Cancel', style: TextStyle(fontSize: 10))),
                          ],
                          onSelected: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),
                expandedContent: _buildSendExpanded(r),
              )),
          // Pagination
          _buildPagination(_sendRequests.length),
        ],
      ),
    );
  }

  Widget _buildSendExpanded(_SendReqData r) {
    switch (r.requestType) {
      case 'Delete':
        return _buildSendDeleteExpanded(r);
      case 'Feedback':
        return _buildSendFeedbackExpanded(r);
      case 'Rework':
        return _buildSendReworkExpanded(r);
      case 'Forward':
        return _buildSendForwardExpanded(r);
      case 'Retrain':
        return _buildSendRetrainExpanded(r);
      case 'Meeting':
        return _buildSendDeleteExpanded(r); // meeting uses same base layout
      default:
        return _buildSendDeleteExpanded(r);
    }
  }

  // ── Delete / Meeting expanded ──
  Widget _buildSendDeleteExpanded(_SendReqData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate.isEmpty ? '-' : r.actionDate),
          _detailItem('Recipient Name', r.recipientName),
          _detailItem('Request Type', r.requestType),
        ]),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Request Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            _sendStatusBadge(r.status),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Title', r.courseTitle),
          _detailItem('Course Status', r.courseStatus),
          _detailItem('Business Segment', r.businessSegment),
          _detailItem('Department', r.department),
          _detailItem('Client', r.client),
          _detailItem('Program', r.program),
        ]),
      ],
    );
  }

  // ── Feedback expanded ──
  Widget _buildSendFeedbackExpanded(_SendReqData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate.isEmpty ? '-' : r.actionDate),
          _detailItem('Recipient Name', r.recipientName),
          _detailItem('Request Type', r.requestType),
        ]),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Request Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            _sendStatusBadge(r.status),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Title', r.courseTitle),
          _detailItem('Course Status', r.courseStatus),
          _detailItem('Business Segment', r.businessSegment),
          _detailItem('Department', r.department),
          _detailItem('Client', r.client),
          _detailItem('Program', r.program),
        ]),
        const SizedBox(height: 6),
        _detailItem('Feedback Type', r.feedbackType),
        const SizedBox(height: 4),
        _detailItem('Comment', r.comment),
      ],
    );
  }

  // ── Rework expanded ──
  Widget _buildSendReworkExpanded(_SendReqData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate.isEmpty ? '-' : r.actionDate),
          _detailItem('Recipient Name', r.recipientName),
          _detailItem('Request Type', r.requestType),
        ]),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Request Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            _sendStatusBadge(r.status),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Title', r.courseTitle),
          _detailItem('Course Status', r.courseStatus),
          _detailItem('Business Segment', r.businessSegment),
          _detailItem('Department', r.department),
          _detailItem('Client', r.client),
          _detailItem('Program', r.program),
        ]),
        const SizedBox(height: 6),
        _detailItem('Rework Reason', r.reworkReason),
        const SizedBox(height: 4),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Start Date', r.startDate),
          _detailItem('End Date', r.endDate),
        ]),
        if (r.suggestions.isNotEmpty) ...[
          const SizedBox(height: 4),
          _detailItem('Suggestions', r.suggestions),
        ],
        if (r.attachment.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.attach_file, size: 12, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              Text(r.attachment, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
            ],
          ),
        ],
      ],
    );
  }

  // ── Forward expanded ──
  Widget _buildSendForwardExpanded(_SendReqData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate.isEmpty ? '-' : r.actionDate),
          _detailItem('Recipient Name', r.recipientName),
          _detailItem('Request Type', r.requestType),
        ]),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Request Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            _sendStatusBadge(r.status),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Title', r.courseTitle),
          _detailItem('Course Status', r.courseStatus),
          _detailItem('Business Segment', r.businessSegment),
          _detailItem('Department', r.department),
          _detailItem('Client', r.client),
          _detailItem('Program', r.program),
        ]),
        const SizedBox(height: 6),
        _detailItem('Comment', r.comment),
        if (r.attachment.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.attach_file, size: 12, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              Text(r.attachment, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
            ],
          ),
        ],
        const SizedBox(height: 4),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Current Date', r.currentDate),
          _detailItem('Expected Date', r.expectedDate),
        ]),
      ],
    );
  }

  // ── Retrain expanded ──
  Widget _buildSendRetrainExpanded(_SendReqData r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Request Date', r.date),
          _detailItem('Action Date', r.actionDate.isEmpty ? '-' : r.actionDate),
          _detailItem('Request Type', r.requestType),
        ]),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Request Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            _sendStatusBadge(r.status),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.borderGrey),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('Course Title', r.courseTitle),
          _detailItem('Course Status', r.courseStatus),
          _detailItem('Business Segment', r.businessSegment),
          _detailItem('Department', r.department),
          _detailItem('Client', r.client),
          _detailItem('Program', r.program),
        ]),
        const SizedBox(height: 8),
        const Text('Recipients', style: TextStyle(fontSize: 8, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: r.recipientList.map((name) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name, style: const TextStyle(fontSize: 8, color: AppColors.textDark)),
                  const SizedBox(width: 4),
                  _roleCodeBadge(r.roleCode, r.roleFull),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        _detailItem('Trainer Name', r.trainerName),
        const SizedBox(height: 4),
        _detailItem('Comment', r.comment),
        const SizedBox(height: 4),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('From Date', r.fromDate),
          _detailItem('To Date', r.toDate),
          _detailItem('Slot Batch', r.slotBatch),
          _detailItem('Slot Time', r.slotTime),
        ]),
      ],
    );
  }

  // ════════════════════════════════════════════════
  //  Shared widgets
  // ════════════════════════════════════════════════

  Widget _buildPagination(int total) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text('1-$total  of  $total', style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const Spacer(),
          const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
          const Text('1/1', style: TextStyle(fontSize: 9)),
          const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
        ],
      ),
    );
  }

  // ── Role badge (full name) for Received tab ──
  Widget _roleBadgeFull(String role) {
    Color color;
    switch (role) {
      case 'Author':
        color = AppColors.amber;
        break;
      case 'Trainer':
        color = AppColors.primaryBlue;
        break;
      case 'Trainee':
        color = AppColors.green;
        break;
      case 'Author/Trainer':
        color = AppColors.orange;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        role,
        style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // ── Role badge (short code) for Send tab ──
  Widget _roleCodeBadge(String code, String fullRole) {
    final color = _roleCodeColors[code] ?? AppColors.grey;
    return Tooltip(
      message: fullRole,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          code,
          style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ── Request type badge (dot + label) ──
  Widget _requestTypeBadge(String type, Map<String, Color> colorMap) {
    final color = colorMap[type] ?? AppColors.grey;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(type, style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  // ── Status badges ──
  Widget _receivedStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Approved':
        color = AppColors.green;
        break;
      case 'Rejected':
        color = AppColors.red;
        break;
      case 'New':
        color = AppColors.primaryBlue;
        break;
      case 'Under Review':
        color = AppColors.amber;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }

  Widget _sendStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Accepted':
        color = AppColors.green;
        break;
      case 'Rejected':
        color = AppColors.red;
        break;
      case 'Waiting':
        color = AppColors.amber;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }

  // ── Detail item ──
  Widget _detailItem(String label, String value) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          const SizedBox(height: 1),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // ── Header cell ──
  Widget _hdr(String text, {double? width, int? flex}) {
    final child = Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey));
    if (flex != null) {
      return Expanded(flex: flex, child: child);
    }
    return SizedBox(width: width, child: child);
  }
}

// ════════════════════════════════════════════════════════
//  DATA MODELS
// ════════════════════════════════════════════════════════

class _ReceivedReqData {
  final String date;
  final String requesterName;
  final String role;
  final String requestType;
  final String status;
  final String actionDate;
  final String courseTitle;
  final String courseStatus;
  final String businessSegment;
  final String department;
  final String client;
  final String program;
  final String reason;
  final String additionalDate;
  final String attachment;
  final String suggestions;

  const _ReceivedReqData({
    required this.date,
    required this.requesterName,
    required this.role,
    required this.requestType,
    required this.status,
    this.actionDate = '',
    this.courseTitle = '',
    this.courseStatus = '',
    this.businessSegment = '',
    this.department = '',
    this.client = '',
    this.program = '',
    this.reason = '',
    this.additionalDate = '',
    this.attachment = '',
    this.suggestions = '',
  });
}

class _SendReqData {
  final String date;
  final String recipientName;
  final String roleCode;
  final String roleFull;
  final String requestType;
  final String status;
  final String actionDate;
  final String courseTitle;
  final String courseStatus;
  final String businessSegment;
  final String department;
  final String client;
  final String program;
  // Feedback fields
  final String feedbackType;
  final String comment;
  // Rework fields
  final String reworkReason;
  final String startDate;
  final String endDate;
  final String suggestions;
  final String attachment;
  // Forward fields
  final String currentDate;
  final String expectedDate;
  // Retrain fields
  final List<String> recipientList;
  final String trainerName;
  final String fromDate;
  final String toDate;
  final String slotBatch;
  final String slotTime;

  const _SendReqData({
    required this.date,
    required this.recipientName,
    required this.roleCode,
    required this.roleFull,
    required this.requestType,
    required this.status,
    this.actionDate = '',
    this.courseTitle = '',
    this.courseStatus = '',
    this.businessSegment = '',
    this.department = '',
    this.client = '',
    this.program = '',
    this.feedbackType = '',
    this.comment = '',
    this.reworkReason = '',
    this.startDate = '',
    this.endDate = '',
    this.suggestions = '',
    this.attachment = '',
    this.currentDate = '',
    this.expectedDate = '',
    this.recipientList = const [],
    this.trainerName = '',
    this.fromDate = '',
    this.toDate = '',
    this.slotBatch = '',
    this.slotTime = '',
  });
}
