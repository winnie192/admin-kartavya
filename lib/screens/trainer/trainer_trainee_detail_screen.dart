import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class TrainerTraineeDetailScreen extends StatefulWidget {
  const TrainerTraineeDetailScreen({super.key});

  @override
  State<TrainerTraineeDetailScreen> createState() => _TrainerTraineeDetailScreenState();
}

class _TrainerTraineeDetailScreenState extends State<TrainerTraineeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _stats = const [
    _StatItem('Enrolled Courses', '34', Color(0xFF2196F3), Icons.school),
    _StatItem('Completed Courses', '13', Color(0xFF4CAF50), Icons.check_circle_outline),
    _StatItem('Ongoing Courses', '21', Color(0xFFFF9800), Icons.autorenew),
    _StatItem('Not Started', '21', Color(0xFF9E9E9E), Icons.pause_circle_outline),
    _StatItem('Expired Courses', '21', Color(0xFFE53935), Icons.timer_off),
    _StatItem('Hours Completed', '21', Color(0xFF7E57C2), Icons.access_time),
    _StatItem('Certificates', '21', Color(0xFF00BCD4), Icons.card_membership),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                // Top bar with back + trainee info
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
                      // Avatar
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.orange.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(child: Text('AP', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ankit Dharmnath Pandey',
                                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                            Row(
                              children: [
                                Text('Trainee', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 10)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.orange.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text('Front Runner', style: TextStyle(color: AppColors.orange, fontSize: 9, fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Action icons
                      ...[Icons.chat_bubble_outline, Icons.share_outlined, Icons.groups_outlined, Icons.edit_outlined].map(
                        (icon) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(icon, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                // Stats row
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _stats.map((s) => _buildStatItem(s)).toList(),
                    ),
                  ),
                ),
                // Tab bar
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppColors.primaryBlue,
                    unselectedLabelColor: AppColors.textGrey,
                    indicatorColor: AppColors.primaryBlue,
                    labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(fontSize: 12),
                    tabs: const [
                      Tab(text: 'Profile'),
                      Tab(text: 'Courses'),
                      Tab(text: 'Task'),
                      Tab(text: 'Sessions'),
                      Tab(text: 'Exams'),
                      Tab(text: 'Schedule'),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.borderGrey),
                // Tab content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildProfileTab(),
                      _buildCoursesTab(),
                      _buildTaskTab(),
                      _buildSessionsTab(),
                      _buildExamsTab(),
                      _buildScheduleTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(_StatItem stat) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: stat.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: stat.color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(stat.icon, size: 16, color: stat.color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stat.label, style: TextStyle(fontSize: 9, color: stat.color)),
              Text(stat.value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: stat.color)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Personal Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 16),
            _buildFieldRow(['First Name', 'Last Name', 'Employee Code'], ['Ankit', 'Pandey', 'KH0201']),
            _buildFieldRow(['Email ID', 'Contact Number', 'User Type'], ['ankitpandey@gmail.com', '9876123569', 'Guest']),
            _buildFieldRow(['Business Segment', 'Department', 'Client'], ['Cipla_new', 'Operations', 'cipla_new_abc_222_345']),
            _buildFieldRow(['Program', 'Role Assign', 'Start Date'], ['cipla_new_abc_222_345', 'Trainee', '12 Aug 2025']),
            _buildFieldRow(['End Date', 'Hours Assign', ''], ['30 Dec 2025', '120hrs:34mins', '']),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {},
              child: const Text('View Access Details',
                  style: TextStyle(fontSize: 12, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldRow(List<String> labels, List<String> values) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: List.generate(3, (i) {
          if (labels[i].isEmpty) return const Expanded(child: SizedBox());
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labels[i], style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.borderGrey),
                  ),
                  child: Text(values[i], style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
                ),
              ],
            ),
          );
        }).expand((w) => [w, const SizedBox(width: 12)]).toList()..removeLast(),
      ),
    );
  }

  Widget _buildCoursesTab() {
    final gradients = [
      [Colors.purple.shade300, Colors.blue.shade300],
      [Colors.orange.shade300, Colors.red.shade300],
      [Colors.teal.shade300, Colors.green.shade300],
      [Colors.indigo.shade300, Colors.cyan.shade300],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(4, (i) => SizedBox(
          width: 200,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    gradient: LinearGradient(colors: gradients[i % gradients.length]),
                  ),
                  child: const Center(child: Icon(Icons.play_circle_outline, color: Colors.white, size: 32)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                        child: const Text('Completed', style: TextStyle(fontSize: 8, color: AppColors.green, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 6),
                      const Text("Beginner's Guide to Becoming & Professional Frontend Developer",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark),
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 10, color: AppColors.textGrey),
                          const SizedBox(width: 3),
                          const Text('04hrs:52m', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildTaskTab() {
    final tasks = [
      _TaskItem('Complete All Pending Assignments ...', '06 Dec 2023', '22 Feb 2025', 'Not Submit', 'Devesh Gupta'),
      _TaskItem('Attend 1:1 Meeting - EOD on the ...', '16 Mar 2024', '20 Aug 2025', 'Pending', 'Devesh Gupta'),
      _TaskItem('Take meeting of camps team ...', '17 Jun 2023', '16 Mar 2024', 'Submitted', 'Devesh Gupta'),
      _TaskItem('Report EOD to Neloy Sir - EOD of the ...', '17 Jun 2025', '09 Jan 2025', 'Resubmitted', 'Yashoda Anchan'),
      _TaskItem('Complete All Pending Assignments ...', '16 Mar 2024', '17 Jun 2025', 'Assign', 'Devesh Gupta'),
      _TaskItem('Add a Quiz for Students of 3CO - Report on the ...', '17 Jun 2025', '22 Feb 2025', 'Reassign', 'Devesh Gupta'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            // Date range
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('From', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                  const SizedBox(width: 6),
                  _buildDateChip('20-03-2025'),
                  const SizedBox(width: 10),
                  const Text('To', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                  const SizedBox(width: 6),
                  _buildDateChip('27-03-2025'),
                ],
              ),
            ),
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
              child: Row(
                children: [
                  _hCell('Task Name', flex: 4),
                  _hCell('Assign Date', flex: 2),
                  _hCell('Submission Date', flex: 2),
                  _hCell('Status', flex: 2),
                  _hCell('Assigned By', flex: 2),
                  _hCell('Action', flex: 1),
                ],
              ),
            ),
            ...tasks.map((t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: Text(t.name, style: const TextStyle(fontSize: 11, color: AppColors.textDark), maxLines: 1, overflow: TextOverflow.ellipsis)),
                      Expanded(flex: 2, child: Text(t.assignDate, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                      Expanded(flex: 2, child: Text(t.submissionDate, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                      Expanded(flex: 2, child: _taskStatusBadge(t.status)),
                      Expanded(flex: 2, child: Row(
                        children: [
                          const Icon(Icons.person_outline, size: 14, color: AppColors.textGrey),
                          const SizedBox(width: 4),
                          Flexible(child: Text(t.assignedBy, style: const TextStyle(fontSize: 10, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
                        ],
                      )),
                      Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.primaryBlue)),
                    ],
                  ),
                )),
            _buildPagination(tasks.length),
          ],
        ),
      ),
    );
  }

  Widget _taskStatusBadge(String status) {
    Color dotColor;
    switch (status) {
      case 'Not Submit':
        dotColor = AppColors.red;
        break;
      case 'Pending':
        dotColor = AppColors.orange;
        break;
      case 'Submitted':
        dotColor = AppColors.green;
        break;
      case 'Resubmitted':
        dotColor = const Color(0xFF9C27B0);
        break;
      case 'Assign':
        dotColor = AppColors.primaryBlue;
        break;
      case 'Reassign':
        dotColor = const Color(0xFF00BCD4);
        break;
      default:
        dotColor = AppColors.textGrey;
    }
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(status, style: TextStyle(fontSize: 10, color: dotColor, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildSessionsTab() {
    final filters = ['Session : 15', 'Meeting : 02', 'All', 'Completed : 2', 'Upcoming : 14', 'Ongoing : 1', 'Cancel : 2'];
    final sessions = [
      _SessionCard('15 April 2025 : Session', 'Ongoing', 'Morning  09:00 AM - 10:00 AM', 'Started 41 Mins ago', AppColors.orange),
      _SessionCard('15 April 2025 : Session', 'Ongoing', 'Afternoon  01:00 PM - 02:00 PM', 'Starting in 0 Days 04 Hrs 18 Mins', AppColors.orange),
      _SessionCard('16 April 2025 : Session', 'Upcoming', 'Afternoon  03:00 PM - 04:00 PM', 'Starting in 01 Days 24 Hrs 10 Mins', AppColors.primaryBlue),
      _SessionCard('17 April 2025 : Session', 'Upcoming', 'Evening  04:00 PM - 05:00 PM', 'Starting in 02 Days 21 Hrs 54 Mins', AppColors.primaryBlue),
      _SessionCard('18 April 2025 : Meeting', 'Upcoming', 'Morning  09:00 AM - 10:00 AM', 'Starting in 02 Days 21 Hrs 54 Mins', AppColors.primaryBlue),
      _SessionCard('20 April 2025 : Session', 'Upcoming', 'Afternoon  02:00 PM - 03:00 PM', 'Starting in 02 Days 21 Hrs 54 Mins', AppColors.primaryBlue),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filters.map((f) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderGrey),
                  ),
                  child: Text(f, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
                )).toList(),
          ),
          const SizedBox(height: 16),
          // Grid
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: sessions.map((s) => SizedBox(
                  width: 260,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 12, color: s.color),
                            const SizedBox(width: 6),
                            Expanded(child: Text(s.title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textDark))),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: s.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                              child: Text(s.status, style: TextStyle(fontSize: 9, color: s.color, fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.schedule, size: 12, color: AppColors.textGrey),
                            const SizedBox(width: 4),
                            Text(s.timeSlot, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('Status : ${s.countdown}',
                            style: TextStyle(fontSize: 9, color: s.color)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.textDark,
                                  side: const BorderSide(color: AppColors.borderGrey),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                ),
                                child: const Text('View Details', style: TextStyle(fontSize: 10)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                ),
                                child: const Text('Join Now', style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExamsTab() {
    final exams = [
      _ExamCard('06 Dec 2023-12 Dec 2023', 'Ongoing', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamCard('11 Apr 2025', 'Upcoming', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamCard('26 Aug 2023 - 30 Aug 2023', 'Complete', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamCard('20 Oct 2025 - 29 Oct 2025', 'Cancel', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamCard('06 Dec 2023-12 Dec 2023', 'Upcoming', '45 min', 'Assess your skills in writing complex SQL queries...'),
      _ExamCard('21 Nov 2024', 'Upcoming', '45 min', 'Assess your skills in writing complex SQL queries...'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats
          Wrap(
            spacing: 12,
            children: [
              _examStatChip('Total Exams : 24', AppColors.textDark),
              _examStatChip('Upcoming 05', AppColors.primaryBlue),
              _examStatChip('Completed 10', AppColors.green),
              _examStatChip('Ongoing 01', AppColors.orange),
              _examStatChip('Cancel 03', AppColors.red),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: exams.map((e) => SizedBox(
                  width: 220,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 11, color: AppColors.textGrey),
                            const SizedBox(width: 4),
                            Expanded(child: Text(e.dateRange, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                            _examStatusBadge(e.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(children: [
                          const Icon(Icons.schedule, size: 11, color: AppColors.textGrey),
                          const SizedBox(width: 4),
                          Text('Duration - ${e.duration}', style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
                        ]),
                        const SizedBox(height: 6),
                        Text(e.description, style: const TextStyle(fontSize: 10, color: AppColors.textGrey), maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.visibility, size: 12, color: AppColors.primaryBlue),
                            const SizedBox(width: 4),
                            const Text('Preview Exam', style: TextStyle(fontSize: 10, color: AppColors.primaryBlue)),
                            const Spacer(),
                            if (e.status == 'Complete')
                              Row(children: [
                                const Icon(Icons.analytics, size: 12, color: AppColors.green),
                                const SizedBox(width: 3),
                                const Text('Result', style: TextStyle(fontSize: 10, color: AppColors.green)),
                              ])
                            else if (e.status != 'Cancel')
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
                                child: const Text('Take Test', style: TextStyle(fontSize: 9, color: Colors.white)),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _examStatChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _examStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Ongoing': color = AppColors.orange; break;
      case 'Upcoming': color = AppColors.primaryBlue; break;
      case 'Complete': color = AppColors.green; break;
      case 'Cancel': color = AppColors.red; break;
      default: color = AppColors.textGrey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(status, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: const Center(
          child: Text('Schedule Calendar View', style: TextStyle(fontSize: 14, color: AppColors.textGrey)),
        ),
      ),
    );
  }

  Widget _hCell(String label, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.orange)),
    );
  }

  Widget _buildDateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 11, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(date, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildPagination(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Text('1-$count of 1', style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
          const Spacer(),
          Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.chevron_left, color: Colors.white, size: 18)),
          const SizedBox(width: 4),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)), child: const Text('1/1', style: TextStyle(color: Colors.white, fontSize: 10))),
          const SizedBox(width: 4),
          Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.chevron_right, color: Colors.white, size: 18)),
        ],
      ),
    );
  }
}

class _StatItem {
  final String label, value;
  final Color color;
  final IconData icon;
  const _StatItem(this.label, this.value, this.color, this.icon);
}

class _TaskItem {
  final String name, assignDate, submissionDate, status, assignedBy;
  const _TaskItem(this.name, this.assignDate, this.submissionDate, this.status, this.assignedBy);
}

class _SessionCard {
  final String title, status, timeSlot, countdown;
  final Color color;
  const _SessionCard(this.title, this.status, this.timeSlot, this.countdown, this.color);
}

class _ExamCard {
  final String dateRange, status, duration, description;
  const _ExamCard(this.dateRange, this.status, this.duration, this.description);
}
