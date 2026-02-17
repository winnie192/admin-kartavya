import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/edit_access_dialog.dart';
import '../../widgets/retrain_dialog.dart';
import '../../widgets/feedback_dialog.dart';
import '../../widgets/meeting_dialog.dart';
import 'pm_send_invites_dialog.dart';

class PmUserDetailScreen extends StatefulWidget {
  final String userName;
  final VoidCallback onBack;

  const PmUserDetailScreen({super.key, required this.userName, required this.onBack});

  @override
  State<PmUserDetailScreen> createState() => _PmUserDetailScreenState();
}

class _PmUserDetailScreenState extends State<PmUserDetailScreen> {
  int _selectedTab = 0;
  final _tabs = ['Profile', 'Courses', 'Task', 'Sessions', 'Exams', 'Schedule'];
  bool _showAccessDetails = false;
  bool _showCourseCards = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: widget.onBack,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, size: 16, color: AppColors.primaryBlue),
                SizedBox(width: 4),
                Text('Back to Users', style: TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildProfileHeader(),
          const SizedBox(height: 12),
          _buildStatsRow(),
          const SizedBox(height: 12),
          _buildActionButtons(),
          const SizedBox(height: 12),
          _buildTabBar(),
          const SizedBox(height: 12),
          _buildTabContent(),
        ],
      ),
    );
  }

  // ─── Profile Header ───────────────────────────────────────────────────

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.amber,
          child: Text(
            widget.userName.isNotEmpty ? widget.userName[0] : 'A',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ankit Dharmnath Pandey',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _roleBadge('Trainee', AppColors.green),
                  const SizedBox(width: 6),
                  _outcomeBadgeSmall('Front Runner', const Color(0xFF9C27B0)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _roleBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _outcomeBadgeSmall(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500)),
    );
  }

  // ─── Stats Row (7 stats) ──────────────────────────────────────────────

  Widget _buildStatsRow() {
    final stats = [
      _Stat('34', 'Enrolled Courses', AppColors.primaryBlue),
      _Stat('12', 'Completed Courses', AppColors.green),
      _Stat('21', 'Ongoing Courses', AppColors.amber),
      _Stat('21', 'Not Started', AppColors.orange),
      _Stat('21', 'Expired Courses', AppColors.red),
      _Stat('21', 'Hours Completed', AppColors.primaryBlue),
      _Stat('21', 'Certificates', AppColors.green),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stats
            .map((s) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: s.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: s.color.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Text(s.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: s.color)),
                      const SizedBox(height: 2),
                      Text(s.label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ─── Action Buttons ───────────────────────────────────────────────────

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _actionButton('Edit Access', AppColors.primaryBlue, () => showEditAccessDialog(context, widget.userName)),
        _actionButton('Pause', AppColors.orange, () {}),
        _actionButton('Delete', AppColors.red, () {}),
        _actionButton('Send Invites', AppColors.green, () => showPmSendInvitesDialog(context)),
        _actionButton('Retrain', AppColors.amber, () => showRetrainDialog(context)),
        _actionButton('Meeting', AppColors.primaryBlue, () => showMeetingDialog(context)),
        _actionButton('Feedback', AppColors.green, () => showFeedbackDialog(context)),
      ],
    );
  }

  Widget _actionButton(String label, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color)),
    );
  }

  // ─── Tab Bar ──────────────────────────────────────────────────────────

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _tabs.asMap().entries.map((e) {
          final isActive = e.key == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = e.key),
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
              ),
              child: Text(
                e.value,
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? Colors.white : AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ─── Tab Content Router ───────────────────────────────────────────────

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildProfileTab();
      case 1:
        return _buildCoursesTab();
      case 2:
        return _buildTaskTab();
      case 3:
        return _buildSessionsTab();
      case 4:
        return _buildExamsTab();
      case 5:
        return _buildScheduleTab();
      default:
        return const SizedBox();
    }
  }

  // =====================================================================
  // TAB 0 : Profile
  // =====================================================================

  Widget _buildProfileTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPersonalDetailsSection(),
        const SizedBox(height: 16),
        _buildViewAccessDetailsSection(),
      ],
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personal Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          _detailRow(['First Name', 'Last Name', 'Employee Code'], ['Ankit', 'Pandey', 'KH3201']),
          const SizedBox(height: 10),
          _detailRow(['Email ID', 'Contact Number', 'User Type'], ['ankitpandey@gmail.com', '987123569', 'Guest']),
          const SizedBox(height: 10),
          _detailRow(['Business Segment', 'Department', 'Client'], ['Cipla_new', 'Operations', 'cipla_new_abc_222_345']),
          const SizedBox(height: 10),
          _detailRow(['Program', 'Role Assign', ''], ['cipla_new_abc_222_345', 'Trainee', '']),
        ],
      ),
    );
  }

  Widget _detailRow(List<String> labels, List<String> values) {
    return Row(
      children: List.generate(labels.length, (i) {
        if (labels[i].isEmpty) return const Expanded(child: SizedBox());
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(labels[i], style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
              const SizedBox(height: 2),
              Text(values[i], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildViewAccessDetailsSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _showAccessDetails = !_showAccessDetails),
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  const Text('View Access Details', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
                  const Spacer(),
                  Icon(
                    _showAccessDetails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 18,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
          ),
          if (_showAccessDetails) ...[
            const Divider(height: 1, color: AppColors.borderGrey),
            _buildAccessDetailsTable(),
          ],
        ],
      ),
    );
  }

  Widget _buildAccessDetailsTable() {
    final rows = [
      ['Cipla', 'Camps', 'Cipla_ABC', 'Cipla_new_comers', 'T,T,A'],
      ['Mankind', 'HR', 'KindMan@123', 'Man999', 'T,A'],
      ['Denon', 'Finance', 'Denon_123', 'Denon@new_comer', 'T'],
    ];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            ),
            child: Row(
              children: [
                _hdr('Business Segment', 2),
                _hdr('Department', 2),
                _hdr('Client', 2),
                _hdr('Program', 2),
                _hdr('Access Type', 1),
              ],
            ),
          ),
          // Rows
          ...rows.map((r) => Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(r[0], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r[1], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r[2], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r[3], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(flex: 1, child: Text(r[4], style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // =====================================================================
  // TAB 1 : Courses
  // =====================================================================

  Widget _buildCoursesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCourseSummaryRow(),
        const SizedBox(height: 12),
        // Toggle between table and card view
        Row(
          children: [
            const Text('All Courses', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const Spacer(),
            GestureDetector(
              onTap: () => setState(() => _showCourseCards = false),
              child: Icon(Icons.table_rows_outlined, size: 16, color: _showCourseCards ? AppColors.textGrey : AppColors.primaryBlue),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => _showCourseCards = true),
              child: Icon(Icons.grid_view, size: 16, color: _showCourseCards ? AppColors.primaryBlue : AppColors.textGrey),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _showCourseCards ? _buildCourseCardsGrid() : _buildCourseTable(),
      ],
    );
  }

  Widget _buildCourseSummaryRow() {
    final items = [
      _SummaryItem('Total Courses', '24', AppColors.primaryBlue),
      _SummaryItem('Not Started', '120', AppColors.orange),
      _SummaryItem('Expired', '120', AppColors.red),
      _SummaryItem('Ongoing', '125', AppColors.amber),
      _SummaryItem('Completed', '25', AppColors.green),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: item.color.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Text(item.value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: item.color)),
                      const SizedBox(height: 2),
                      Text(item.label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCourseTable() {
    final courses = [
      _CourseRow('UI/UX for beginner', '12hrs:32m', 'Enrolled', 'Pending', 'Not Available', 'ongoing'),
      _CourseRow('UI/UX for beginner with Gen AI', '02hrs:07m', '-', 'Aspirant', 'Not Available', '-'),
      _CourseRow('Fundamentals of ReactJS with Gen AI', '04hrs:23m', 'Completed', 'Performer', 'View', 'pending'),
      _CourseRow('Advanced Data Structures', '08hrs:15m', 'Enrolled', 'Pending', 'Not Available', 'ongoing'),
      _CourseRow('Machine Learning Basics', '06hrs:45m', 'Completed', 'Achiever', 'View', '-'),
      _CourseRow('Cloud Computing Essentials', '03hrs:30m', '-', 'Aspirant', 'Not Available', '-'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Row(
              children: [
                _hdr('Course Name', 3),
                _hdr('Duration', 1),
                _hdr('Status', 1),
                _hdr('Outcome', 1),
                _hdr('Certificate', 1),
                _hdr('Action', 1),
              ],
            ),
          ),
          // Rows
          ...courses.map((c) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(c.name, style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
                    Expanded(flex: 1, child: Text(c.duration, style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
                    Expanded(flex: 1, child: c.status == '-' ? const Text('-', style: TextStyle(fontSize: 9, color: AppColors.textGrey)) : _courseStatusBadge(c.status)),
                    Expanded(flex: 1, child: c.outcome == '-' ? const Text('-', style: TextStyle(fontSize: 9, color: AppColors.textGrey)) : _outcomeBadge(c.outcome)),
                    Expanded(
                      flex: 1,
                      child: c.certificate == 'View'
                          ? GestureDetector(
                              onTap: () {},
                              child: const Text('View', style: TextStyle(fontSize: 9, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
                            )
                          : Text(c.certificate, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
                    ),
                    Expanded(flex: 1, child: _courseActionIcon(c.action)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _courseActionIcon(String type) {
    switch (type) {
      case 'ongoing':
        return const Icon(Icons.play_circle_outline, size: 14, color: AppColors.amber);
      case 'pending':
        return const Icon(Icons.hourglass_bottom, size: 14, color: AppColors.orange);
      default:
        return const Text('-', style: TextStyle(fontSize: 9, color: AppColors.textGrey));
    }
  }

  Widget _buildCourseCardsGrid() {
    final cards = [
      _CourseCard('Completed', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m', 'Performer', true),
      _CourseCard('Ongoing', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m', 'Aspirant', false),
      _CourseCard('Not Started', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m', 'Pending', false),
      _CourseCard('Completed', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m', 'Achiever', true),
      _CourseCard('Ongoing', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m', 'Front Runner', false),
      _CourseCard('Not Started', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m', 'Pending', false),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: cards.map((c) => _buildCourseCard(c)).toList(),
    );
  }

  Widget _buildCourseCard(_CourseCard card) {
    Color statusColor;
    switch (card.status) {
      case 'Completed':
        statusColor = AppColors.green;
        break;
      case 'Ongoing':
        statusColor = AppColors.amber;
        break;
      default:
        statusColor = AppColors.orange;
    }

    Color outcomeColor;
    switch (card.outcome) {
      case 'Performer':
        outcomeColor = AppColors.green;
        break;
      case 'Achiever':
        outcomeColor = AppColors.primaryBlue;
        break;
      case 'Front Runner':
        outcomeColor = const Color(0xFF9C27B0);
        break;
      case 'Aspirant':
        outcomeColor = AppColors.orange;
        break;
      default:
        outcomeColor = AppColors.grey;
    }

    return Container(
      width: 200,
      padding: const EdgeInsets.all(10),
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
              _statusBadge(card.status, statusColor),
              const SizedBox(width: 6),
              _statusBadge(card.outcome, outcomeColor),
            ],
          ),
          const SizedBox(height: 8),
          Text(card.title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, size: 10, color: AppColors.textGrey),
              const SizedBox(width: 4),
              Text(card.duration, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
            ],
          ),
          const SizedBox(height: 6),
          if (card.hasCertificate)
            GestureDetector(
              onTap: () {},
              child: const Text('View Certificate', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 26,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.zero,
                elevation: 0,
              ),
              child: const Text('View Course', style: TextStyle(fontSize: 9)),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // TAB 2 : Task
  // =====================================================================

  Widget _buildTaskTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTaskDateRange(),
        const SizedBox(height: 12),
        _buildTaskTable(),
      ],
    );
  }

  Widget _buildTaskDateRange() {
    return Row(
      children: [
        _datePickerField('From', '20-03-2025'),
        const SizedBox(width: 10),
        _datePickerField('To', '27-03-2025'),
      ],
    );
  }

  Widget _datePickerField(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Row(
          children: [
            Text('$label  ', style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
            Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            const Spacer(),
            const Icon(Icons.calendar_today, size: 12, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTable() {
    final tasks = [
      _TaskRow('Complete All Pending Assignments...', '06 Dec 2023', '16 Mar 2024', 'Not Submit', 'Devesh Gupta', '-'),
      _TaskRow('Attend 1-1 Meeting - EOD on the...', '20 Aug 2025', '16 Mar 2024', 'Pending', 'Devesh Gupta', '-'),
      _TaskRow('Take meeting of camps team...', '-', '17 Jun 2023', 'Submitted', 'Devesh Gupta', '-'),
      _TaskRow('Complete All Pending Assignments...', '17 Jun 2025', '16 Mar 2024', 'Assign', 'Devesh Gupta', '-'),
      _TaskRow('Add a Quiz for Students of 3CO...', '22 Feb 2025', '17 Jun 2025', 'Resubmitted', 'Devesh Gupta', 'Reassign'),
      _TaskRow('Report EOD to Neloy Sir...', '09 Jan 2025', '22 Feb 2025', '-', 'Yashoda Anchan', '-'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Row(
              children: [
                _hdr('Task Name', 3),
                _hdr('Assign Date', 1),
                _hdr('Submission Date', 1),
                _hdr('Status', 1),
                _hdr('Assigned By', 1),
                _hdr('Action', 1),
              ],
            ),
          ),
          ...tasks.map((t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(t.name, style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
                    Expanded(flex: 1, child: Text(t.assignDate, style: const TextStyle(fontSize: 8, color: AppColors.textGrey))),
                    Expanded(flex: 1, child: Text(t.submissionDate, style: const TextStyle(fontSize: 8, color: AppColors.textGrey))),
                    Expanded(flex: 1, child: t.status == '-' ? const Text('-', style: TextStyle(fontSize: 9, color: AppColors.textGrey)) : _taskStatusBadge(t.status)),
                    Expanded(flex: 1, child: Text(t.assignedBy, style: const TextStyle(fontSize: 8, color: AppColors.textGrey), overflow: TextOverflow.ellipsis)),
                    Expanded(
                      flex: 1,
                      child: t.action == 'Reassign'
                          ? GestureDetector(
                              onTap: () {},
                              child: const Text('Reassign', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
                            )
                          : const Text('-', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _taskStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Not Submit':
        color = AppColors.red;
        break;
      case 'Pending':
        color = AppColors.amber;
        break;
      case 'Submitted':
        color = AppColors.green;
        break;
      case 'Assign':
        color = AppColors.primaryBlue;
        break;
      case 'Resubmitted':
        color = AppColors.orange;
        break;
      case 'Completed':
        color = AppColors.green;
        break;
      case 'Ongoing':
        color = AppColors.amber;
        break;
      case 'Upcoming':
        color = AppColors.primaryBlue;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.w500)),
    );
  }

  // =====================================================================
  // TAB 3 : Sessions
  // =====================================================================

  Widget _buildSessionsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSessionSummaryRow(),
        const SizedBox(height: 12),
        _buildSessionDateRange(),
        const SizedBox(height: 12),
        _buildSessionCardsList(),
      ],
    );
  }

  Widget _buildSessionSummaryRow() {
    final items = [
      _SummaryItem('Session', '15', AppColors.primaryBlue),
      _SummaryItem('Meeting', '02', AppColors.primaryBlue),
      _SummaryItem('All', '', AppColors.textGrey),
      _SummaryItem('Completed', '2', AppColors.green),
      _SummaryItem('Upcoming', '14', AppColors.amber),
      _SummaryItem('Ongoing', '1', AppColors.orange),
      _SummaryItem('Cancel', '2', AppColors.red),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: item.color.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Text(item.label, style: TextStyle(fontSize: 9, color: item.color, fontWeight: FontWeight.w500)),
                      if (item.value.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(item.value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: item.color)),
                      ],
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSessionDateRange() {
    return Row(
      children: [
        _datePickerField('From', '27-03-2025'),
        const SizedBox(width: 10),
        _datePickerField('To', '27-03-2025'),
      ],
    );
  }

  Widget _buildSessionCardsList() {
    final sessions = [
      _SessionData(
        status: 'Ongoing',
        date: '15 April 2025',
        type: 'Session',
        time: 'Morning 09:00 AM - 10:00 AM',
        host: 'Divya Shetty',
        statusDetail: 'Started 41 Mins ago',
        hasJoinNow: true,
      ),
      _SessionData(
        status: 'Upcoming',
        date: '16 April 2025',
        type: 'Session',
        time: 'Afternoon 03:00 PM - 04:00 PM',
        host: 'Ganesh Anandraj',
        statusDetail: 'Starting in 01 Days 24 Hrs 10 Mins',
        hasJoinNow: false,
      ),
      _SessionData(
        status: 'Upcoming',
        date: '16 April 2025',
        type: 'Session',
        time: 'Afternoon 03:00 PM - 04:00 PM',
        host: 'Shital Patil',
        statusDetail: '',
        hasJoinNow: false,
      ),
      _SessionData(
        status: 'Ongoing',
        date: '15 April 2025',
        type: 'Session',
        time: 'Morning 09:00 AM - 10:00 AM',
        host: 'Rachana Dharmnand Singh',
        statusDetail: '',
        hasJoinNow: false,
      ),
      _SessionData(
        status: 'Completed',
        date: '21 April 2025',
        type: 'Meeting',
        time: 'Evening 05:00 PM - 06:00 PM',
        host: 'Anki Pandey',
        statusDetail: 'Completed',
        hasJoinNow: false,
      ),
      _SessionData(
        status: 'Cancel',
        date: '03 Jan 2025',
        type: 'Session',
        time: 'Morning 09:00 AM - 10:00 AM',
        host: 'Balvijay Gunaraj',
        statusDetail: 'Cancel on 02 Jan 2025',
        hasJoinNow: false,
      ),
    ];

    return Column(
      children: sessions.map((s) => _buildSessionCard(s)).toList(),
    );
  }

  Widget _buildSessionCard(_SessionData session) {
    Color borderColor;
    switch (session.status) {
      case 'Ongoing':
        borderColor = AppColors.amber;
        break;
      case 'Upcoming':
        borderColor = AppColors.primaryBlue;
        break;
      case 'Completed':
        borderColor = AppColors.green;
        break;
      case 'Cancel':
        borderColor = AppColors.red;
        break;
      default:
        borderColor = AppColors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colored left border
          Container(
            width: 3,
            height: 100,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
          ),
          // Card content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _statusBadge(session.status, borderColor),
                      const Spacer(),
                      if (session.hasJoinNow)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(4)),
                            child: const Text('Join Now', style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      if (session.hasJoinNow) const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {},
                        child: const Text('View Details', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${session.date} ${session.type}',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 4),
                  Text(session.time, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
                  const SizedBox(height: 4),
                  Text('Host: ${session.host}', style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
                  if (session.statusDetail.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Status: ${session.statusDetail}',
                      style: TextStyle(fontSize: 8, color: borderColor, fontWeight: FontWeight.w500),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // TAB 4 : Exams
  // =====================================================================

  Widget _buildExamsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExamSummaryRow(),
        const SizedBox(height: 12),
        _buildExamDateRange(),
        const SizedBox(height: 12),
        _buildExamCardsList(),
      ],
    );
  }

  Widget _buildExamSummaryRow() {
    final items = [
      _SummaryItem('Total Exams', '24', AppColors.primaryBlue),
      _SummaryItem('Upcoming', '05', AppColors.primaryBlue),
      _SummaryItem('Completed', '10', AppColors.green),
      _SummaryItem('Ongoing', '01', AppColors.amber),
      _SummaryItem('Cancel', '03', AppColors.red),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: item.color.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Text(item.value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: item.color)),
                      const SizedBox(height: 2),
                      Text(item.label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildExamDateRange() {
    return Row(
      children: [
        _datePickerField('From', '20-03-2025'),
        const SizedBox(width: 10),
        _datePickerField('To', '27-03-2025'),
      ],
    );
  }

  Widget _buildExamCardsList() {
    final exams = [
      _ExamData('06 Dec 2023 - 12 Dec 2023', 'Ongoing', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamData('11 Apr 2025', 'Upcoming', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamData('26 Aug 2023 - 30 Aug 2023', 'Complete', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamData('20 Oct 2025 - 29 Oct 2025', 'Cancel', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamData('15 Jan 2024', 'Upcoming', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamData('01 Mar 2024 - 05 Mar 2024', 'Ongoing', '45 min', 'Assess your skills in writing complex SQL queries...'),
    ];

    return Column(
      children: exams.map((e) => _buildExamCard(e)).toList(),
    );
  }

  Widget _buildExamCard(_ExamData exam) {
    Color statusColor;
    switch (exam.status) {
      case 'Ongoing':
        statusColor = AppColors.amber;
        break;
      case 'Upcoming':
        statusColor = AppColors.primaryBlue;
        break;
      case 'Complete':
        statusColor = AppColors.green;
        break;
      case 'Cancel':
        statusColor = AppColors.red;
        break;
      default:
        statusColor = AppColors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
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
              Text(exam.dateRange, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
              const Spacer(),
              _statusBadge(exam.status, statusColor),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: 12, color: AppColors.textGrey),
              const SizedBox(width: 4),
              Text('Duration ${exam.duration}', style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
            ],
          ),
          const SizedBox(height: 6),
          Text(exam.description, style: const TextStyle(fontSize: 10, color: AppColors.textDark), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          Row(
            children: [
              _examActionBtn('Preview', AppColors.primaryBlue),
              const SizedBox(width: 8),
              if (exam.status == 'Complete') ...[
                _examActionBtn('Result', AppColors.green),
                const SizedBox(width: 8),
              ],
              if (exam.status != 'Cancel') _examActionBtn('Take Test', AppColors.primaryBlue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _examActionBtn(String label, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500)),
      ),
    );
  }

  // =====================================================================
  // TAB 5 : Schedule
  // =====================================================================

  Widget _buildScheduleTab() {
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
              const Text('March 2025', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              _buildScheduleViewBtn('Day', false),
              _buildScheduleViewBtn('Week', false),
              _buildScheduleViewBtn('Month', true),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((d) => Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
                        child: Text(d, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500, color: AppColors.textGrey)),
                      ),
                    ))
                .toList(),
          ),
          ...List.generate(
            4,
            (week) => Row(
              children: List.generate(7, (day) {
                final num = week * 7 + day + 1;
                if (num > 28) return const Expanded(child: SizedBox(height: 50));
                return Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey, width: 0.5)),
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$num', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500)),
                        if (num % 5 == 0)
                          Text('01:00PM', style: TextStyle(fontSize: 6, color: AppColors.primaryBlue)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleViewBtn(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
      ),
      child: Text(label, style: TextStyle(fontSize: 8, color: isActive ? Colors.white : AppColors.textGrey)),
    );
  }

  // ─── Shared Helpers ───────────────────────────────────────────────────

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _courseStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Completed':
        color = AppColors.green;
        break;
      case 'Enrolled':
        color = AppColors.primaryBlue;
        break;
      case 'Incomplete':
        color = AppColors.orange;
        break;
      case 'Pending':
        color = AppColors.amber;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
      child: Text(status, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _outcomeBadge(String outcome) {
    Color color;
    switch (outcome) {
      case 'Achiever':
        color = AppColors.primaryBlue;
        break;
      case 'Performer':
        color = AppColors.green;
        break;
      case 'Aspirant':
        color = AppColors.orange;
        break;
      case 'Front Runner':
        color = const Color(0xFF9C27B0);
        break;
      case 'Pending':
        color = AppColors.amber;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
      child: Text(outcome, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _hdr(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(text, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Data models
// ═══════════════════════════════════════════════════════════════════════════

class _Stat {
  final String value, label;
  final Color color;
  _Stat(this.value, this.label, this.color);
}

class _SummaryItem {
  final String label, value;
  final Color color;
  _SummaryItem(this.label, this.value, this.color);
}

class _CourseRow {
  final String name, duration, status, outcome, certificate, action;
  _CourseRow(this.name, this.duration, this.status, this.outcome, this.certificate, this.action);
}

class _CourseCard {
  final String status, title, duration, outcome;
  final bool hasCertificate;
  _CourseCard(this.status, this.title, this.duration, this.outcome, this.hasCertificate);
}

class _TaskRow {
  final String name, assignDate, submissionDate, status, assignedBy, action;
  _TaskRow(this.name, this.assignDate, this.submissionDate, this.status, this.assignedBy, this.action);
}

class _SessionData {
  final String status, date, type, time, host, statusDetail;
  final bool hasJoinNow;
  _SessionData({
    required this.status,
    required this.date,
    required this.type,
    required this.time,
    required this.host,
    required this.statusDetail,
    required this.hasJoinNow,
  });
}

class _ExamData {
  final String dateRange, status, duration, description;
  _ExamData(this.dateRange, this.status, this.duration, this.description);
}
