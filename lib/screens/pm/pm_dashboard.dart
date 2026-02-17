import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import 'pm_schedule_calendar.dart';

class PmDashboard extends StatefulWidget {
  const PmDashboard({super.key});

  @override
  State<PmDashboard> createState() => _PmDashboardState();
}

class _PmDashboardState extends State<PmDashboard> {
  final List<_TodoItem> _todos = [
    _TodoItem('Review course submission from Niloy', 'Today, 10:00 AM'),
    _TodoItem('Schedule meeting with trainers', 'Today, 02:00 PM'),
    _TodoItem('Approve pending requests', 'Tomorrow, 09:00 AM'),
    _TodoItem('Review trainee progress reports', 'This Week'),
    _TodoItem('Update curriculum guidelines', ''),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title bar ──
          Row(
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Create Schedule',
                    style: TextStyle(fontSize: 10)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Summary cards row ──
          isMobile
              ? Column(
                  children: [
                    _buildCourseSummaryCard(),
                    const SizedBox(height: 12),
                    _buildUserSummaryCard(),
                    const SizedBox(height: 12),
                    _buildExamsSummaryCard(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildCourseSummaryCard()),
                    const SizedBox(width: 12),
                    Expanded(child: _buildUserSummaryCard()),
                    const SizedBox(width: 12),
                    Expanded(child: _buildExamsSummaryCard()),
                  ],
                ),
          const SizedBox(height: 16),

          // ── Main content area ──
          isMobile
              ? Column(
                  children: [
                    const PmScheduleCalendar(),
                    const SizedBox(height: 16),
                    _buildRecentViewCourses(),
                    const SizedBox(height: 16),
                    _buildStatisticsWidget(),
                    const SizedBox(height: 16),
                    _buildIconTilesRow(),
                    const SizedBox(height: 16),
                    _buildTaskProgressSection(),
                    const SizedBox(height: 16),
                    _buildTodoList(),
                    const SizedBox(height: 16),
                    _buildUpcomingScheduleMiniCalendar(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Left side (flex: 3) ──
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const PmScheduleCalendar(),
                          const SizedBox(height: 16),
                          _buildRecentViewCourses(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // ── Right side (flex: 2) ──
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildStatisticsWidget(),
                          const SizedBox(height: 16),
                          _buildIconTilesRow(),
                          const SizedBox(height: 16),
                          _buildTaskProgressSection(),
                          const SizedBox(height: 16),
                          _buildTodoList(),
                          const SizedBox(height: 16),
                          _buildUpcomingScheduleMiniCalendar(),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY CARDS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildCourseSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              const Text(
                'Course Summary',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Total Courses 67',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildCourseStat('Published', '52', AppColors.green),
              _buildCourseStat('Under Review', '07', AppColors.amber),
              _buildCourseStat('Rejected', '09', AppColors.red),
              _buildCourseStat('Inactive', '02', AppColors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseStat(String label, String count, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people_alt_rounded, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              const Text(
                'User Summary',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Text('Active',
                      style: TextStyle(fontSize: 8, color: AppColors.textGrey)),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Text('Inactive',
                      style: TextStyle(fontSize: 8, color: AppColors.textGrey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildUserBar('Trainee', 480, 590),
          const SizedBox(height: 8),
          _buildUserBar('Trainer', 480, 590),
          const SizedBox(height: 8),
          _buildUserBar('Author', 480, 590),
          const SizedBox(height: 8),
          _buildUserBar('Guest', 480, 590),
        ],
      ),
    );
  }

  Widget _buildUserBar(String role, int active, int total) {
    final fraction = active / total;
    return Row(
      children: [
        SizedBox(
          width: 46,
          child: Text(
            role,
            style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = constraints.maxWidth;
              return Stack(
                children: [
                  Container(
                    height: 12,
                    width: maxW,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Container(
                    height: 12,
                    width: maxW * fraction,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$active/$total',
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildExamsSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.assignment_rounded, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              const Text(
                'Exams Summary',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Total Exams 143',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildExamStat('Ongoing', '09', AppColors.primaryBlue, Icons.play_circle_outline),
              _buildExamStat('Completed', '143', AppColors.green, Icons.check_circle_outline),
              _buildExamStat('Upcoming', '09', AppColors.amber, Icons.schedule),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExamStat(String label, String count, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // RECENT VIEW COURSES
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildRecentViewCourses() {
    final courses = [
      _RecentCourse(
        date: '18 Jan 2025',
        title: 'JavaScript the advance level for pro coders by kartavya Healtheon',
        author: 'Rahul Verma',
        trainer: 'Ganesh Anandraj',
        duration: '04hrs:52m',
        sections: '3 Sections',
        learners: '123',
        color: AppColors.primaryBlue,
      ),
      _RecentCourse(
        date: '18 Jan 2025',
        title: 'JavaScript the advance level for pro coders by kartavya Healtheon',
        author: 'Rahul Verma',
        trainer: 'Ganesh Anandraj',
        duration: '04hrs:52m',
        sections: '3 Sections',
        learners: '123',
        color: AppColors.orange,
      ),
      _RecentCourse(
        date: '18 Jan 2025',
        title: 'JavaScript the advance level for pro coders by kartavya Healtheon',
        author: 'Rahul Verma',
        trainer: 'Ganesh Anandraj',
        duration: '04hrs:52m',
        sections: '3 Sections',
        learners: '123',
        color: AppColors.green,
      ),
      _RecentCourse(
        date: '18 Jan 2025',
        title: 'JavaScript the advance level for pro coders by kartavya Healtheon',
        author: 'Rahul Verma',
        trainer: 'Ganesh Anandraj',
        duration: '04hrs:52m',
        sections: '3 Sections',
        learners: '123',
        color: AppColors.red,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Recent view courses',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(fontSize: 10, color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) =>
                _buildRecentCourseCard(courses[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCourseCard(_RecentCourse course) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colored top accent bar
          Container(
            height: 3,
            width: 40,
            decoration: BoxDecoration(
              color: course.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            course.date,
            style: const TextStyle(fontSize: 8, color: AppColors.textGrey),
          ),
          const SizedBox(height: 3),
          Text(
            course.title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 10, color: AppColors.textGrey),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  'Author: ${course.author}',
                  style: const TextStyle(fontSize: 8, color: AppColors.textGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.school_outlined, size: 10, color: AppColors.textGrey),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  'Trainer: ${course.trainer}',
                  style: const TextStyle(fontSize: 8, color: AppColors.textGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildCourseChip(Icons.access_time, course.duration),
              const SizedBox(width: 6),
              _buildCourseChip(Icons.layers_outlined, course.sections),
              const SizedBox(width: 6),
              _buildCourseChip(Icons.people_outline, course.learners),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8, color: AppColors.textGrey),
          const SizedBox(width: 3),
          Text(text,
              style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STATISTICS WIDGET (circular progress indicators)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildStatisticsWidget() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularStat('Absence', 0.90, AppColors.red),
              _buildCircularStat('Tasks &\nExam', 0.70, AppColors.primaryBlue),
              _buildCircularStat('Quiz', 0.85, AppColors.amber),
              _buildCircularStat('Statistics', 0.75, AppColors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularStat(String label, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: CustomPaint(
            painter: _CircularProgressPainter(
              progress: value,
              color: color,
              trackColor: color.withValues(alpha: 0.15),
              strokeWidth: 4.0,
            ),
            child: Center(
              child: Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 8, color: AppColors.textGrey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ICON TILES ROW
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildIconTilesRow() {
    final tiles = [
      _IconTile('Web\nProgramming', Icons.language, AppColors.primaryBlue),
      _IconTile('Data and\nStructures', Icons.storage_rounded, AppColors.orange),
      _IconTile('Artificial\nIntelligence', Icons.psychology_rounded, AppColors.green),
    ];

    return Row(
      children: tiles
          .map(
            (tile) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                decoration: BoxDecoration(
                  color: tile.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: tile.color.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: tile.color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(tile.icon, size: 18, color: tile.color),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tile.label,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: tile.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TASK PROGRESS SECTION
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildTaskProgressSection() {
    final notifications = [
      _TaskNotification(
        message: 'Selena comments on your posts about Algorithm tasks',
        icon: Icons.comment_outlined,
        color: AppColors.primaryBlue,
        time: '2 min ago',
      ),
      _TaskNotification(
        message: 'Well done! You have submitted your tasks of Javascript 1',
        icon: Icons.check_circle_outline,
        color: AppColors.green,
        time: '10 min ago',
      ),
      _TaskNotification(
        message: 'Your task is overdue for 13 hours and 25 minutes',
        icon: Icons.warning_amber_rounded,
        color: AppColors.red,
        time: '1 hr ago',
      ),
      _TaskNotification(
        message: 'Mr. Dika add new quiz and some tasks on PHP course',
        icon: Icons.add_task,
        color: AppColors.orange,
        time: '3 hrs ago',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Task Progress',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(fontSize: 10, color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...notifications.map((n) => _buildTaskNotificationItem(n)),
        ],
      ),
    );
  }

  Widget _buildTaskNotificationItem(_TaskNotification notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: notification.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(notification.icon, size: 14, color: notification.color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.message,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textDark,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  notification.time,
                  style: TextStyle(
                    fontSize: 8,
                    color: AppColors.textGrey.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TO-DO LIST (preserved from original)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildTodoList() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'To-Do List',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 28,
                height: 28,
                child: FloatingActionButton(
                  onPressed: () => _showAddTodoDialog(),
                  mini: true,
                  backgroundColor: AppColors.primaryBlue,
                  elevation: 0,
                  child:
                      const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // TODAY group
          if (_todos.any((t) => t.time.startsWith('Today'))) ...[
            _buildGroupLabel('TODAY'),
            ..._todos
                .where((t) => t.time.startsWith('Today'))
                .map((t) => _buildTodoItem(t)),
          ],
          // TOMORROW group
          if (_todos.any((t) => t.time.startsWith('Tomorrow'))) ...[
            _buildGroupLabel('TOMORROW'),
            ..._todos
                .where((t) => t.time.startsWith('Tomorrow'))
                .map((t) => _buildTodoItem(t)),
          ],
          // THIS WEEK group
          if (_todos.any((t) => t.time.startsWith('This Week'))) ...[
            _buildGroupLabel('THIS WEEK'),
            ..._todos
                .where((t) => t.time.startsWith('This Week'))
                .map((t) => _buildTodoItem(t)),
          ],
          // UNDATED group
          if (_todos.any((t) => t.time.isEmpty)) ...[
            _buildGroupLabel('UNDATED'),
            ..._todos
                .where((t) => t.time.isEmpty)
                .map((t) => _buildTodoItem(t)),
          ],
        ],
      ),
    );
  }

  Widget _buildGroupLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w700,
          color: AppColors.textGrey,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTodoItem(_TodoItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGrey),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: const TextStyle(
                      fontSize: 10, color: AppColors.textDark),
                ),
                if (item.time.isNotEmpty)
                  Text(
                    item.time,
                    style: TextStyle(
                      fontSize: 8,
                      color: AppColors.textGrey.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UPCOMING SCHEDULE MINI CALENDAR
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildUpcomingScheduleMiniCalendar() {
    final events = [
      _UpcomingEvent(
        title: 'Feedback form open for Time Management Skills Test',
        date: 'Jan 20, 2025',
        color: AppColors.primaryBlue,
      ),
      _UpcomingEvent(
        title: 'Meeting with Client',
        date: 'Jan 22, 2025',
        color: AppColors.orange,
      ),
      _UpcomingEvent(
        title: 'Review Exam Submissions',
        date: 'Jan 25, 2025',
        color: AppColors.green,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Schedule',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          // Mini month view header
          _buildMiniMonth(),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.borderGrey),
          const SizedBox(height: 10),
          // Event list
          ...events.map((e) => _buildUpcomingEventItem(e)),
        ],
      ),
    );
  }

  Widget _buildMiniMonth() {
    const dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    // January 2025 starts on Wednesday (index 2)
    const startOffset = 2;
    const daysInMonth = 31;
    // Highlighted event days
    const highlightDays = {20, 22, 25};

    return Column(
      children: [
        // Month label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'January 2025',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.chevron_left,
                      size: 16, color: AppColors.textGrey),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.chevron_right,
                      size: 16, color: AppColors.textGrey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Day name headers
        Row(
          children: dayNames
              .map(
                (d) => Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 4),
        // Day grid
        ...List.generate(5, (week) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              children: List.generate(7, (col) {
                final dayIndex = week * 7 + col - startOffset + 1;
                if (dayIndex < 1 || dayIndex > daysInMonth) {
                  return const Expanded(child: SizedBox(height: 22));
                }
                final isHighlighted = highlightDays.contains(dayIndex);
                final isToday = dayIndex == 18;
                return Expanded(
                  child: Container(
                    height: 22,
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppColors.primaryBlue
                          : isHighlighted
                              ? AppColors.primaryBlue.withValues(alpha: 0.1)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '$dayIndex',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: isToday || isHighlighted
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isToday
                              ? Colors.white
                              : isHighlighted
                                  ? AppColors.primaryBlue
                                  : AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildUpcomingEventItem(_UpcomingEvent event) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 32,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  event.date,
                  style: TextStyle(
                    fontSize: 8,
                    color: AppColors.textGrey.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ADD TODO DIALOG (preserved from original)
  // ═══════════════════════════════════════════════════════════════════════════

  void _showAddTodoDialog() {
    final descController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add To-Do',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              const Text('Description',
                  style:
                      TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(height: 4),
              TextField(
                controller: descController,
                style: const TextStyle(fontSize: 11),
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Enter task description',
                  hintStyle:
                      const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.all(8),
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
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Date',
                            style: TextStyle(
                                fontSize: 10, color: AppColors.textGrey)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderGrey),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Text('Select date',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.grey)),
                              Spacer(),
                              Icon(Icons.calendar_today,
                                  size: 12, color: AppColors.textGrey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Time',
                            style: TextStyle(
                                fontSize: 10, color: AppColors.textGrey)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderGrey),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Text('Select time',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.grey)),
                              Spacer(),
                              Icon(Icons.access_time,
                                  size: 12, color: AppColors.textGrey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.textGrey)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (descController.text.trim().isNotEmpty) {
                        setState(() {
                          _todos.add(
                              _TodoItem(descController.text.trim(), ''));
                        });
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 0,
                    ),
                    child: const Text('Save',
                        style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER for circular progress
// ═════════════════════════════════════════════════════════════════════════════

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  const _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

// ═════════════════════════════════════════════════════════════════════════════
// DATA MODELS
// ═════════════════════════════════════════════════════════════════════════════

class _TodoItem {
  final String description;
  final String time;
  _TodoItem(this.description, this.time);
}

class _RecentCourse {
  final String date;
  final String title;
  final String author;
  final String trainer;
  final String duration;
  final String sections;
  final String learners;
  final Color color;

  const _RecentCourse({
    required this.date,
    required this.title,
    required this.author,
    required this.trainer,
    required this.duration,
    required this.sections,
    required this.learners,
    required this.color,
  });
}

class _TaskNotification {
  final String message;
  final IconData icon;
  final Color color;
  final String time;

  const _TaskNotification({
    required this.message,
    required this.icon,
    required this.color,
    required this.time,
  });
}

class _IconTile {
  final String label;
  final IconData icon;
  final Color color;

  const _IconTile(this.label, this.icon, this.color);
}

class _UpcomingEvent {
  final String title;
  final String date;
  final Color color;

  const _UpcomingEvent({
    required this.title,
    required this.date,
    required this.color,
  });
}
