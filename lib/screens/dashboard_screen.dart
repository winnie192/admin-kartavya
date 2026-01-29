import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/exam_sidebar.dart';
import '../widgets/exam_card.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const Drawer(child: ExamSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Dashboard', style: TextStyle(fontSize: 16)),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings, size: 20)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications, size: 20)),
              ],
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const ExamSidebar(),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) _buildTopBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatsRow(context),
                        const SizedBox(height: 16),
                        _buildWelcomeAndCalendar(context),
                        const SizedBox(height: 16),
                        _buildOngoingExams(context),
                        const SizedBox(height: 16),
                        _buildSaveAsDraft(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: AppColors.textGrey, size: 18),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined,
                color: AppColors.textGrey, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final stats = [
      _StatItem('210', 'Total Courses', Icons.menu_book, AppColors.primaryBlue),
      _StatItem('502', 'Total Trainees', Icons.people, AppColors.orange),
      _StatItem('02', 'Ongoing Exams', Icons.assignment, AppColors.green),
      _StatItem('12', 'Upcoming Exams', Icons.upcoming, AppColors.primaryBlue),
      _StatItem('08', 'Uncheck Exams', Icons.warning_amber, AppColors.red),
    ];

    if (isMobile) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: stats
            .map((s) => SizedBox(
                width: (MediaQuery.of(context).size.width - 48) / 2,
                child: _buildStatCard(s)))
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

  Widget _buildStatCard(_StatItem stat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 4,
              offset: const Offset(0, 1)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(stat.icon, color: stat.color, size: 18),
              const SizedBox(width: 6),
              Text(
                stat.value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: stat.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeAndCalendar(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final welcome = _buildWelcomeCard(context);
    final todoAndCalendar = _buildTodoAndCalendar(context);

    if (isMobile) {
      return Column(
          children: [welcome, const SizedBox(height: 12), todoAndCalendar]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: welcome),
        const SizedBox(width: 12),
        Expanded(flex: 4, child: todoAndCalendar),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome To',
            style: TextStyle(fontSize: 11, color: AppColors.textGrey),
          ),
          const Text(
            'Exam Creation',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ready to assess and empower your learners?\nCreate, assign, and track exams all in one place.',
            style: TextStyle(fontSize: 10, color: AppColors.textGrey),
          ),
          const SizedBox(height: 4),
          const Text(
            'Choose a method that fits your style — both are just a click away!',
            style: TextStyle(fontSize: 9, color: AppColors.textGrey),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.auto_awesome, size: 14),
                label:
                    const Text('Generate Exam', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/exams/create');
                },
                icon: const Icon(Icons.add, size: 14),
                label:
                    const Text('Create Exam', style: TextStyle(fontSize: 11)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodoAndCalendar(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          _buildTodoList(),
          const SizedBox(height: 12),
          _buildCalendarAndSchedule(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildTodoList()),
        const SizedBox(width: 12),
        Expanded(child: _buildCalendarAndSchedule()),
      ],
    );
  }

  Widget _buildTodoList() {
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
              const Text(
                'To Do List',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Add',
                    style: TextStyle(
                        color: AppColors.primaryBlue, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Column(
              children: [
                Icon(Icons.checklist, size: 50, color: AppColors.lightGrey),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child:
                      const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarAndSchedule() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.chevron_left, color: AppColors.textGrey, size: 18),
              const Text(
                'December 2024',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  fontSize: 12,
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textGrey, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map((d) => Text(d,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textGrey)))
                .toList(),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [24, 25, 26, 27, 28, 29, 30].map((d) {
              final isSelected = d == 24;
              return Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$d',
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? Colors.white : AppColors.textDark,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          const Text(
            'Upcoming Schedule',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          ..._buildScheduleItems(),
        ],
      ),
    );
  }

  List<Widget> _buildScheduleItems() {
    final items = [
      'Feedback form open for Time Management Skills Test',
      'Meeting with Client',
      'Feedback form open for Time Management Skills Test',
      'Review Exam Submissions',
    ];
    return items
        .map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '11:00 - 12:00 Feb 2, 2019',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }

  Widget _buildOngoingExams(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Ongoing Exams',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('View All',
                  style:
                      TextStyle(color: AppColors.primaryBlue, fontSize: 11)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildOngoingExamsList(context),
      ],
    );
  }

  Widget _buildOngoingExamsList(BuildContext context) {
    final exams = [
      {
        'title': 'Data Structures & Algorithms – MCQ Round',
        'total': 109,
        'completed': 82
      },
      {
        'title': 'Healthcare Compliance Knowledge Check',
        'total': 32,
        'completed': 25
      },
      {
        'title': 'Sales Process Simulation Assessment',
        'total': 54,
        'completed': 53
      },
    ];

    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: isMobile
          ? Column(
              children: exams.map((e) => _buildOngoingCard(e)).toList())
          : Row(
              children: exams
                  .map((e) => Expanded(child: _buildOngoingCard(e)))
                  .toList()),
    );
  }

  Widget _buildOngoingCard(Map<String, dynamic> exam) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exam['title'] as String,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.people, size: 14, color: AppColors.textGrey),
              const SizedBox(width: 3),
              Text('${exam['total']}',
                  style: const TextStyle(fontSize: 10)),
              const SizedBox(width: 10),
              Icon(Icons.check_circle_outline,
                  size: 14, color: AppColors.green),
              const SizedBox(width: 3),
              Text('${exam['completed']}',
                  style: const TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaveAsDraft(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossCount =
        isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Save as Draft',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('View All',
                  style:
                      TextStyle(color: AppColors.primaryBlue, fontSize: 11)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: 3,
          itemBuilder: (_, i) => const ExamCard(),
        ),
      ],
    );
  }
}

class _StatItem {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  _StatItem(this.value, this.label, this.icon, this.color);
}
