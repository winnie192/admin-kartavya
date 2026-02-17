import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class TrainerCourseDetailScreen extends StatefulWidget {
  const TrainerCourseDetailScreen({super.key});

  @override
  State<TrainerCourseDetailScreen> createState() =>
      _TrainerCourseDetailScreenState();
}

class _TrainerCourseDetailScreenState extends State<TrainerCourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  // Learners tab state
  final TextEditingController _learnerSearchController =
      TextEditingController();
  int _learnerPage = 1;
  final List<bool> _learnerChecked = List.generate(6, (_) => false);
  bool _learnerCheckAll = false;

  // Tasks tab state
  final TextEditingController _taskSearchController = TextEditingController();
  DateTime? _taskFromDate;
  DateTime? _taskToDate;

  // Sessions tab state
  int _sessionFilterIndex = 0;
  DateTime? _sessionFromDate;
  DateTime? _sessionToDate;
  int _sessionPage = 1;

  // Exams tab state
  DateTime? _examFromDate;
  DateTime? _examToDate;
  int _examPage = 1;

  // Schedule tab state
  int _scheduleViewIndex = 2; // 0=Day, 1=Week, 2=Month
  DateTime _scheduleMonth = DateTime(2025, 4);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _currentTabIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _learnerSearchController.dispose();
    _taskSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Course Detail',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 24,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseBanner(isMobile),
            const SizedBox(height: 12),
            _buildActionIconsRow(),
            const SizedBox(height: 20),
            _buildStatsRow(isMobile, isTablet),
            const SizedBox(height: 20),
            _buildTabBar(),
            const SizedBox(height: 16),
            _buildTabContent(isMobile, isTablet),
          ],
        ),
      ),
    );
  }

  // TOP SECTION

  Widget _buildCourseBanner(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 80 : 120,
            height: isMobile ? 60 : 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.image_outlined, color: Colors.white54, size: 32),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Time Management and Productivity Optimization for Busy Professionals',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIconsRow() {
    return Row(
      children: [
        _actionIcon(Icons.chat_bubble_outline, 'Chat'),
        const SizedBox(width: 16),
        _actionIcon(Icons.share_outlined, 'Share'),
        const SizedBox(width: 16),
        _actionIcon(Icons.group_outlined, 'Group'),
        const SizedBox(width: 16),
        _actionIcon(Icons.edit_outlined, 'Edit'),
      ],
    );
  }

  Widget _actionIcon(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: AppColors.textGrey),
        ),
      ),
    );
  }

  // STATS ROW

  Widget _buildStatsRow(bool isMobile, bool isTablet) {
    final stats = [
      _StatItem('Total Learners', '267', Icons.people_outline, AppColors.primaryBlue),
      _StatItem('Duration', '23h 30m', Icons.access_time, AppColors.green),
      _StatItem('Expiry Date', '09 Jan 2025', Icons.calendar_today, AppColors.orange),
      _StatItem('Program Manager', 'Clement Pinto', Icons.person_outline, const Color(0xFF9C27B0)),
    ];

    if (isMobile) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: stats
            .map((s) => SizedBox(
                  width: (MediaQuery.of(context).size.width - 34) / 2,
                  child: _buildStatCard(s),
                ))
            .toList(),
      );
    }

    return Row(
      children: stats
          .map((s) => Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildStatCard(s),
              )))
          .toList(),
    );
  }

  Widget _buildStatCard(_StatItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAB BAR

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 1)),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppColors.primaryBlue,
        unselectedLabelColor: AppColors.textGrey,
        indicatorColor: AppColors.primaryBlue,
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        tabAlignment: TabAlignment.start,
        tabs: const [
          Tab(text: 'Learners'),
          Tab(text: 'Tasks'),
          Tab(text: 'Sessions'),
          Tab(text: 'Exams'),
          Tab(text: 'Schedule'),
        ],
      ),
    );
  }

  Widget _buildTabContent(bool isMobile, bool isTablet) {
    switch (_currentTabIndex) {
      case 0:
        return _buildLearnersTab(isMobile);
      case 1:
        return _buildTasksTab(isMobile);
      case 2:
        return _buildSessionsTab(isMobile, isTablet);
      case 3:
        return _buildExamsTab(isMobile, isTablet);
      case 4:
        return _buildScheduleTab(isMobile);
      default:
        return const SizedBox.shrink();
    }
  }

  // LEARNERS TAB

  Widget _buildLearnersTab(bool isMobile) {
    final learners = [
      _LearnerRow('Aarti', 'Kudia', 'Pending', '', 3, 2, 1),
      _LearnerRow('Rahul', 'Shinde', 'Completed', 'Achiever', 5, 4, 3),
      _LearnerRow('Sneha', 'Padalkar', 'Completed', 'Performer', 4, 3, 2),
      _LearnerRow('Priya', 'Auti', 'Completed', 'Aspirant', 6, 5, 4),
      _LearnerRow('Amit', 'Pandey', 'Completed', 'Front Runner', 7, 6, 3),
      _LearnerRow('Neha', 'Pawar', 'Incomplete', '', 2, 1, 1),
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 42,
                child: TextField(
                  controller: _learnerSearchController,
                  decoration: InputDecoration(
                    hintText: 'Search learners...',
                    hintStyle: const TextStyle(fontSize: 13, color: AppColors.grey),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.grey),
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryBlue),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isMobile ? _buildLearnerCards(learners) : _buildLearnerTable(learners),
        ),
        const SizedBox(height: 14),
        _buildPagination(_learnerPage, 5, (p) => setState(() => _learnerPage = p)),
      ],
    );
  }

  Widget _buildLearnerTable(List<_LearnerRow> learners) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.background),
        headingTextStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textDark),
        dataTextStyle: const TextStyle(fontSize: 13, color: AppColors.textDark),
        columnSpacing: 18,
        horizontalMargin: 12,
        columns: [
          DataColumn(
            label: Checkbox(
              value: _learnerCheckAll,
              onChanged: (v) => setState(() {
                _learnerCheckAll = v ?? false;
                for (int i = 0; i < _learnerChecked.length; i++) {
                  _learnerChecked[i] = _learnerCheckAll;
                }
              }),
              activeColor: AppColors.primaryBlue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const DataColumn(label: Text('First Name')),
          const DataColumn(label: Text('Last Name')),
          const DataColumn(label: Text('Course Status')),
          const DataColumn(label: Text('Outcome')),
          const DataColumn(label: Text('Task'), numeric: true),
          const DataColumn(label: Text('Session'), numeric: true),
          const DataColumn(label: Text('Exam'), numeric: true),
          const DataColumn(label: Text('Action')),
        ],
        rows: List.generate(learners.length, (i) {
          final l = learners[i];
          return DataRow(
            cells: [
              DataCell(Checkbox(
                value: _learnerChecked[i],
                onChanged: (v) => setState(() => _learnerChecked[i] = v ?? false),
                activeColor: AppColors.primaryBlue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              )),
              DataCell(Text(l.firstName)),
              DataCell(Text(l.lastName)),
              DataCell(_courseStatusBadge(l.status)),
              DataCell(l.outcome.isNotEmpty
                  ? _outcomeBadge(l.outcome)
                  : const Text('-', style: TextStyle(color: AppColors.grey))),
              DataCell(Text('${l.taskCount}')),
              DataCell(Text('${l.sessionCount}')),
              DataCell(Text('${l.examCount}')),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 18),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLearnerCards(List<_LearnerRow> learners) {
    return Column(
      children: learners.map((l) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${l.firstName} ${l.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  IconButton(
                    icon: const Icon(Icons.more_vert, size: 18),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _courseStatusBadge(l.status),
                  const SizedBox(width: 8),
                  if (l.outcome.isNotEmpty) _outcomeBadge(l.outcome),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Tasks: ${l.taskCount}  |  Sessions: ${l.sessionCount}  |  Exams: ${l.examCount}',
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _courseStatusBadge(String status) {
    Color bg;
    Color fg;
    switch (status) {
      case 'Pending':
        bg = AppColors.amber.withValues(alpha: 0.15);
        fg = AppColors.amber;
        break;
      case 'Completed':
        bg = AppColors.green.withValues(alpha: 0.15);
        fg = AppColors.green;
        break;
      case 'Incomplete':
        bg = AppColors.red.withValues(alpha: 0.15);
        fg = AppColors.red;
        break;
      default:
        bg = AppColors.grey.withValues(alpha: 0.15);
        fg = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget _outcomeBadge(String outcome) {
    Color bg;
    Color fg;
    switch (outcome) {
      case 'Achiever':
        bg = AppColors.primaryBlue.withValues(alpha: 0.12);
        fg = AppColors.primaryBlue;
        break;
      case 'Performer':
        bg = AppColors.green.withValues(alpha: 0.12);
        fg = AppColors.green;
        break;
      case 'Aspirant':
        bg = AppColors.orange.withValues(alpha: 0.12);
        fg = AppColors.orange;
        break;
      case 'Front Runner':
        bg = const Color(0xFF9C27B0).withValues(alpha: 0.12);
        fg = const Color(0xFF9C27B0);
        break;
      default:
        bg = AppColors.grey.withValues(alpha: 0.12);
        fg = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(outcome, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  // TASKS TAB

  Widget _buildTasksTab(bool isMobile) {
    final tasks = [
      _TaskRow('Complete All Pending Assignments Before Deadline', '10 Jan 2025', '15 Jan 2025', 'Completed', 'Devesh Gupta'),
      _TaskRow('Complete All Pending Assignments Before Deadline', '12 Jan 2025', '18 Jan 2025', 'Ongoing', 'Devesh Gupta'),
      _TaskRow('Complete All Pending Assignments Before Deadline', '14 Jan 2025', '20 Jan 2025', 'Upcoming', 'Devesh Gupta'),
      _TaskRow('Complete All Pending Assignments Before Deadline', '08 Jan 2025', '12 Jan 2025', 'Not Submit', 'Devesh Gupta'),
      _TaskRow('Complete All Pending Assignments Before Deadline', '16 Jan 2025', '22 Jan 2025', 'Submitted', 'Devesh Gupta'),
      _TaskRow('Complete All Pending Assignments Before Deadline', '18 Jan 2025', '24 Jan 2025', 'Resubmitted', 'Devesh Gupta'),
      _TaskRow('Complete All Pending Assignments Before Deadline', '20 Jan 2025', '26 Jan 2025', 'Assign', 'Devesh Gupta'),
      _TaskRow('Complete All Pending Assignments Before Deadline', '22 Jan 2025', '28 Jan 2025', 'Reassign', 'Devesh Gupta'),
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _dateField('From', _taskFromDate, (d) => setState(() => _taskFromDate = d))),
            const SizedBox(width: 10),
            Expanded(child: _dateField('To', _taskToDate, (d) => setState(() => _taskToDate = d))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 42,
                child: TextField(
                  controller: _taskSearchController,
                  decoration: InputDecoration(
                    hintText: 'Search tasks...',
                    hintStyle: const TextStyle(fontSize: 13, color: AppColors.grey),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.grey),
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.borderGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryBlue),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isMobile ? _buildTaskCards(tasks) : _buildTaskTable(tasks),
        ),
      ],
    );
  }

  Widget _buildTaskTable(List<_TaskRow> tasks) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.background),
        headingTextStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textDark),
        dataTextStyle: const TextStyle(fontSize: 13, color: AppColors.textDark),
        columnSpacing: 20,
        horizontalMargin: 12,
        columns: const [
          DataColumn(label: Text('Task Name')),
          DataColumn(label: Text('Assign Date')),
          DataColumn(label: Text('Submission Date')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Assigned By')),
          DataColumn(label: Text('Action')),
        ],
        rows: tasks.map((t) {
          return DataRow(cells: [
            DataCell(SizedBox(
              width: 220,
              child: Text(t.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            )),
            DataCell(Text(t.assignDate)),
            DataCell(Text(t.submissionDate)),
            DataCell(_taskStatusBadge(t.status)),
            DataCell(Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_outline, size: 16, color: AppColors.textGrey),
                const SizedBox(width: 4),
                Text(t.assignedBy, style: const TextStyle(fontSize: 12)),
              ],
            )),
            DataCell(IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 14),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildTaskCards(List<_TaskRow> tasks) {
    return Column(
      children: tasks.map((t) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(t.name,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _taskStatusBadge(t.status),
                  const Spacer(),
                  const Icon(Icons.person_outline, size: 14, color: AppColors.textGrey),
                  const SizedBox(width: 3),
                  Text(t.assignedBy, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Assign: ${t.assignDate}  |  Due: ${t.submissionDate}',
                style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _taskStatusBadge(String status) {
    Color dotColor;
    switch (status) {
      case 'Completed':
        dotColor = AppColors.green;
        break;
      case 'Ongoing':
        dotColor = AppColors.amber;
        break;
      case 'Upcoming':
        dotColor = AppColors.primaryBlue;
        break;
      case 'Not Submit':
        dotColor = AppColors.red;
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
        dotColor = const Color(0xFF009688);
        break;
      default:
        dotColor = AppColors.grey;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: dotColor)),
      ],
    );
  }

  // SESSIONS TAB

  Widget _buildSessionsTab(bool isMobile, bool isTablet) {
    final filterLabels = [
      'Session:15',
      'Meeting:02',
      'All',
      'Completed:2',
      'Upcoming:14',
      'Ongoing:1',
      'Cancel:2',
    ];

    final sessions = [
      _SessionCard('15 April 2025', 'Session', 'Ongoing', 'Morning', '09:00 AM', '10:00 AM', 'Starting in 02 Days 21 Hrs 54 Mins'),
      _SessionCard('16 April 2025', 'Session', 'Upcoming', 'Afternoon', '01:00 PM', '02:00 PM', 'Starting in 03 Days 10 Hrs 22 Mins'),
      _SessionCard('17 April 2025', 'Session', 'Completed', 'Morning', '09:00 AM', '10:00 AM', 'Completed'),
      _SessionCard('18 April 2025', 'Session', 'Cancel', 'Afternoon', '01:00 PM', '02:00 PM', 'Cancelled'),
      _SessionCard('19 April 2025', 'Session', 'Upcoming', 'Morning', '09:00 AM', '10:00 AM', 'Starting in 06 Days 08 Hrs 15 Mins'),
      _SessionCard('20 April 2025', 'Session', 'Ongoing', 'Afternoon', '01:00 PM', '02:00 PM', 'Starting in 00 Days 02 Hrs 10 Mins'),
    ];

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(filterLabels.length, (i) {
            final selected = _sessionFilterIndex == i;
            return ChoiceChip(
              label: Text(filterLabels[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: selected ? AppColors.white : AppColors.textDark,
                  )),
              selected: selected,
              onSelected: (_) => setState(() => _sessionFilterIndex = i),
              selectedColor: AppColors.primaryBlue,
              backgroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: selected ? AppColors.primaryBlue : AppColors.borderGrey)),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _dateField('From', _sessionFromDate, (d) => setState(() => _sessionFromDate = d))),
            const SizedBox(width: 10),
            Expanded(child: _dateField('To', _sessionToDate, (d) => setState(() => _sessionToDate = d))),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: isMobile ? 1.6 : 1.4,
          ),
          itemCount: sessions.length,
          itemBuilder: (_, i) => _buildSessionCard(sessions[i]),
        ),
        const SizedBox(height: 14),
        _buildPagination(_sessionPage, 3, (p) => setState(() => _sessionPage = p)),
      ],
    );
  }

  Widget _buildSessionCard(_SessionCard s) {
    Color statusColor;
    switch (s.status) {
      case 'Ongoing':
        statusColor = AppColors.amber;
        break;
      case 'Upcoming':
        statusColor = AppColors.primaryBlue;
        break;
      case 'Completed':
        statusColor = AppColors.green;
        break;
      case 'Cancel':
        statusColor = AppColors.red;
        break;
      default:
        statusColor = AppColors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${s.date} : ${s.type}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(s.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: statusColor)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${s.slot} ${s.startTime} - ${s.endTime}',
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
          const SizedBox(height: 6),
          Text(
            s.countdown,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: statusColor),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: (s.status == 'Ongoing' || s.status == 'Upcoming') ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.lightGrey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    elevation: 0,
                  ),
                  child: const Text('Join Now'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // EXAMS TAB

  Widget _buildExamsTab(bool isMobile, bool isTablet) {
    final examStats = [
      _ExamStat('Total Exams', '24', AppColors.textDark),
      _ExamStat('Upcoming', '05', AppColors.primaryBlue),
      _ExamStat('Completed', '10', AppColors.green),
      _ExamStat('Ongoing', '01', AppColors.amber),
      _ExamStat('Cancel', '03', AppColors.red),
    ];

    final exams = [
      _ExamCard('06 Dec 2023', '12 Dec 2023', 'Ongoing', '45 min', 'Comprehensive assessment covering modules 1-5 of the course curriculum.'),
      _ExamCard('15 Dec 2023', '20 Dec 2023', 'Upcoming', '45 min', 'Mid-term evaluation on time management techniques and strategies.'),
      _ExamCard('01 Nov 2023', '05 Nov 2023', 'Complete', '45 min', 'Final exam covering all modules and practical applications.'),
      _ExamCard('10 Oct 2023', '12 Oct 2023', 'Cancel', '45 min', 'Supplementary exam for productivity tools and frameworks.'),
      _ExamCard('20 Dec 2023', '25 Dec 2023', 'Upcoming', '45 min', 'Assessment on leadership and team productivity optimization.'),
      _ExamCard('28 Nov 2023', '02 Dec 2023', 'Complete', '45 min', 'Practical assessment on workflow automation and delegation skills.'),
    ];

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: examStats.map((s) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: s.color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: s.color.withValues(alpha: 0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(s.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: s.color)),
                  const SizedBox(width: 6),
                  Text(s.value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: s.color)),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _dateField('From', _examFromDate, (d) => setState(() => _examFromDate = d))),
            const SizedBox(width: 10),
            Expanded(child: _dateField('To', _examToDate, (d) => setState(() => _examToDate = d))),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: isMobile ? 1.7 : 1.35,
          ),
          itemCount: exams.length,
          itemBuilder: (_, i) => _buildExamCard(exams[i]),
        ),
        const SizedBox(height: 14),
        _buildPagination(_examPage, 4, (p) => setState(() => _examPage = p)),
      ],
    );
  }

  Widget _buildExamCard(_ExamCard e) {
    Color statusColor;
    switch (e.status) {
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('${e.startDate}-${e.endDate}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(e.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: statusColor)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.textGrey),
              const SizedBox(width: 4),
              Text('Duration: ${e.duration}', style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              e.description,
              style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: const Text('Preview Exam',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryBlue)),
              ),
              if (e.status == 'Ongoing' || e.status == 'Upcoming')
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    elevation: 0,
                  ),
                  child: const Text('Take Test'),
                )
              else if (e.status == 'Complete')
                const Text('Result',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.green)),
            ],
          ),
        ],
      ),
    );
  }

  // SCHEDULE TAB

  Widget _buildScheduleTab(bool isMobile) {
    final viewLabels = ['Day', 'Week', 'Month'];
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final firstDay = DateTime(_scheduleMonth.year, _scheduleMonth.month, 1);
    final lastDay = DateTime(_scheduleMonth.year, _scheduleMonth.month + 1, 0);
    int startWeekday = firstDay.weekday;

    final events = <int, List<_ScheduleEvent>>{
      3: [_ScheduleEvent('09:00 AM', AppColors.primaryBlue)],
      7: [
        _ScheduleEvent('10:00 AM', AppColors.green),
        _ScheduleEvent('02:00 PM', AppColors.amber),
      ],
      10: [_ScheduleEvent('11:00 AM', AppColors.red)],
      14: [_ScheduleEvent('09:30 AM', AppColors.primaryBlue)],
      15: [
        _ScheduleEvent('09:00 AM', AppColors.amber),
        _ScheduleEvent('01:00 PM', AppColors.green),
      ],
      18: [_ScheduleEvent('03:00 PM', const Color(0xFF9C27B0))],
      22: [_ScheduleEvent('10:00 AM', AppColors.primaryBlue)],
      25: [
        _ScheduleEvent('09:00 AM', AppColors.green),
        _ScheduleEvent('11:00 AM', AppColors.amber),
      ],
      28: [_ScheduleEvent('02:00 PM', AppColors.red)],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderGrey),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(viewLabels.length, (i) {
                  final selected = _scheduleViewIndex == i;
                  return InkWell(
                    onTap: () => setState(() => _scheduleViewIndex = i),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primaryBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        viewLabels[i],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: selected ? AppColors.white : AppColors.textGrey,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.chevron_left, size: 20),
              onPressed: () => setState(() {
                _scheduleMonth = DateTime(_scheduleMonth.year, _scheduleMonth.month - 1);
              }),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 4),
            Text(
              '${monthNames[_scheduleMonth.month - 1]} ${_scheduleMonth.year}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.chevron_right, size: 20),
              onPressed: () => setState(() {
                _scheduleMonth = DateTime(_scheduleMonth.year, _scheduleMonth.month + 1);
              }),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _scheduleMonth,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() {
                    _scheduleMonth = DateTime(picked.year, picked.month);
                  });
                }
              },
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.calendar_today, size: 16, color: AppColors.textGrey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: dayNames
                      .map((d) => Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(d,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const Divider(height: 1, color: AppColors.borderGrey),
              ...List.generate(_getWeekCount(startWeekday, lastDay.day), (week) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(7, (dayOfWeek) {
                    final dayIndex = week * 7 + dayOfWeek - (startWeekday - 1) + 1;
                    final isValidDay = dayIndex >= 1 && dayIndex <= lastDay.day;
                    final dayEvents = events[dayIndex] ?? [];

                    return Expanded(
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 70),
                        decoration: BoxDecoration(
                          border: Border(
                            right: dayOfWeek < 6
                                ? const BorderSide(color: AppColors.borderGrey, width: 0.5)
                                : BorderSide.none,
                            bottom: const BorderSide(color: AppColors.borderGrey, width: 0.5),
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isValidDay ? '$dayIndex' : '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isValidDay ? AppColors.textDark : Colors.transparent,
                              ),
                            ),
                            if (isValidDay)
                              ...dayEvents.map((ev) => Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: ev.color.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      ev.time,
                                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: ev.color),
                                    ),
                                  )),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  int _getWeekCount(int startWeekday, int totalDays) {
    return ((startWeekday - 1 + totalDays) / 7).ceil();
  }

  // SHARED WIDGETS

  Widget _dateField(String label, DateTime? value, ValueChanged<DateTime> onPicked) {
    final display = value != null
        ? '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}'
        : 'dd/mm/yyyy';

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) onPicked(picked);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textGrey, fontWeight: FontWeight.w500)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(display,
                  style: TextStyle(fontSize: 13, color: value != null ? AppColors.textDark : AppColors.grey)),
            ),
            const Icon(Icons.calendar_today, size: 16, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(int currentPage, int totalPages, ValueChanged<int> onPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: currentPage > 1 ? () => onPage(currentPage - 1) : null,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGrey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.chevron_left, size: 18, color: currentPage > 1 ? AppColors.textDark : AppColors.lightGrey),
          ),
        ),
        const SizedBox(width: 4),
        ...List.generate(totalPages, (i) {
          final page = i + 1;
          final isActive = page == currentPage;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: InkWell(
              onTap: () => onPage(page),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primaryBlue : Colors.transparent,
                  border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$page',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isActive ? AppColors.white : AppColors.textDark,
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(width: 4),
        InkWell(
          onTap: currentPage < totalPages ? () => onPage(currentPage + 1) : null,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGrey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.chevron_right, size: 18, color: currentPage < totalPages ? AppColors.textDark : AppColors.lightGrey),
          ),
        ),
      ],
    );
  }
}

// DATA MODELS

class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  _StatItem(this.label, this.value, this.icon, this.color);
}

class _LearnerRow {
  final String firstName;
  final String lastName;
  final String status;
  final String outcome;
  final int taskCount;
  final int sessionCount;
  final int examCount;

  _LearnerRow(this.firstName, this.lastName, this.status, this.outcome,
      this.taskCount, this.sessionCount, this.examCount);
}

class _TaskRow {
  final String name;
  final String assignDate;
  final String submissionDate;
  final String status;
  final String assignedBy;

  _TaskRow(this.name, this.assignDate, this.submissionDate, this.status, this.assignedBy);
}

class _SessionCard {
  final String date;
  final String type;
  final String status;
  final String slot;
  final String startTime;
  final String endTime;
  final String countdown;

  _SessionCard(this.date, this.type, this.status, this.slot, this.startTime, this.endTime, this.countdown);
}

class _ExamCard {
  final String startDate;
  final String endDate;
  final String status;
  final String duration;
  final String description;

  _ExamCard(this.startDate, this.endDate, this.status, this.duration, this.description);
}

class _ExamStat {
  final String label;
  final String value;
  final Color color;

  _ExamStat(this.label, this.value, this.color);
}

class _ScheduleEvent {
  final String time;
  final Color color;

  _ScheduleEvent(this.time, this.color);
}
