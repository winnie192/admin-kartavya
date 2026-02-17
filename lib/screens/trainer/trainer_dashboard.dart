import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class TrainerDashboard extends StatefulWidget {
  const TrainerDashboard({super.key});

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  final List<_TodoItem> _todoItems = [
    _TodoItem('Review exam submissions', '10:00 AM', 'TODAY'),
    _TodoItem('Prepare session materials', '02:00 PM', 'TODAY'),
    _TodoItem('Grade JavaScript quiz', '09:00 AM', 'TOMORROW'),
    _TodoItem('Update course syllabus', '11:00 AM', 'THIS WEEK'),
    _TodoItem('Schedule parent-teacher meeting', '', 'THIS WEEK'),
    _TodoItem('Create new assessment', '', 'UNDATED'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsRow(isMobile),
          const SizedBox(height: 24),
          isMobile
              ? Column(children: [
                  _buildRecentCourses(),
                  const SizedBox(height: 20),
                  _buildUpcomingSchedule(),
                  const SizedBox(height: 20),
                  _buildExamsSummary(),
                  const SizedBox(height: 20),
                  _buildTodoList(),
                ])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          _buildRecentCourses(),
                          const SizedBox(height: 20),
                          _buildUpcomingSchedule(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildExamsSummary(),
                          const SizedBox(height: 20),
                          _buildTodoList(),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(bool isMobile) {
    final stats = [
      _StatData('Total Courses', '67', const Color(0xFF2196F3), Icons.menu_book_outlined),
      _StatData('Total Trainees', '632', const Color(0xFF4CAF50), Icons.people_outlined),
      _StatData('Upcoming Session', '03', const Color(0xFFFF9800), Icons.video_camera_front_outlined),
      _StatData('Upcoming Exams', '06', const Color(0xFFE53935), Icons.quiz_outlined),
    ];

    if (isMobile) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: stats
              .map((s) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildStatCard(s),
                  ))
              .toList(),
        ),
      );
    }

    return Row(
      children: stats
          .map((s) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildStatCard(s),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildStatCard(_StatData stat) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: stat.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(stat.icon, color: stat.color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stat.label,
                  style: TextStyle(fontSize: 11, color: stat.color, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(stat.value,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentCourses() {
    final courses = [
      'JavaScript for pro coders by kartavya healtheon',
      'JavaScript for pro coders by kartavya healtheon',
      'JavaScript for pro coders by kartavya healtheon',
      'JavaScript for pro coders by kartavya healtheon',
    ];
    final gradients = [
      [Colors.orange.shade300, Colors.red.shade300],
      [Colors.blue.shade300, Colors.purple.shade300],
      [Colors.green.shade300, Colors.teal.shade300],
      [Colors.amber.shade300, Colors.orange.shade300],
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent view courses',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return Container(
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          gradient: LinearGradient(colors: gradients[index % gradients.length]),
                        ),
                        child: const Center(child: Icon(Icons.play_circle_outline, color: Colors.white, size: 32)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(courses[index],
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark),
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.schedule, size: 10, color: AppColors.textGrey),
                                const SizedBox(width: 3),
                                const Text('04hrs:52m', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text('3 Sections', style: TextStyle(fontSize: 8, color: AppColors.green)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSchedule() {
    final scheduleItems = [
      _ScheduleItem('11:00 - 12:00 Feb 2, 2019', 'Feedback form open for Time Management Skills Test', true),
      _ScheduleItem('11:00 - 12:00 Feb 2, 2019', 'Review Exam Submissions', false),
      _ScheduleItem('11:00 - 12:00 Feb 2, 2019', 'Review Exam Submissions', false),
      _ScheduleItem('11:00 - 12:00 Feb 2, 2019', 'Feedback form open for Time Management Skills Test', true),
      _ScheduleItem('11:00 - 12:00 Feb 2, 2019', 'Feedback form open for Time Management Skills Test', true),
      _ScheduleItem('11:00 - 12:00 Feb 2, 2019', 'Review Exam Submissions', false),
      _ScheduleItem('11:00 - 12:00 Feb 2, 2019', 'Review Exam Submissions', false),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
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
              const Text('Upcoming Schedule',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const Spacer(),
              const Text('From', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(width: 6),
              _buildDateChip('20-03-2025'),
              const SizedBox(width: 10),
              const Text('To', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(width: 6),
              _buildDateChip('27-03-2025'),
            ],
          ),
          const SizedBox(height: 12),
          ...scheduleItems.map((item) => _buildScheduleRow(item)),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
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

  Widget _buildScheduleRow(_ScheduleItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: (item.hasJoin ? AppColors.green : AppColors.primaryBlue).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.schedule, size: 14,
                color: item.hasJoin ? AppColors.green : AppColors.primaryBlue),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.timeRange,
                    style: const TextStyle(fontSize: 10, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(item.description,
                    style: const TextStyle(fontSize: 11, color: AppColors.textDark),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (item.hasJoin)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('Join', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500)),
            ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGrey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('View Details', style: TextStyle(color: AppColors.textDark, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _buildExamsSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Exams Summary',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 16),
          _buildExamSummaryRow('Ongoing', '03', AppColors.orange),
          const SizedBox(height: 10),
          _buildExamSummaryRow('Completed', '12', AppColors.green),
          const SizedBox(height: 10),
          _buildExamSummaryRow('Upcoming', '06', AppColors.primaryBlue),
          const SizedBox(height: 10),
          _buildExamSummaryRow('Total Exams', '21', AppColors.textDark),
        ],
      ),
    );
  }

  Widget _buildExamSummaryRow(String label, String count, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(count, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildTodoList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('To Do List',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          if (_todoItems.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Icon(Icons.help_outline, size: 64, color: AppColors.orange.withValues(alpha: 0.5)),
                  const SizedBox(height: 12),
                  const Text('No tasks yet', style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
                  const SizedBox(height: 20),
                ],
              ),
            )
          else
            ..._buildGroupedTodos(),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: _showAddTodoDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              ),
              child: const Text('Add', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGroupedTodos() {
    final groups = <String, List<_TodoItem>>{};
    for (final item in _todoItems) {
      groups.putIfAbsent(item.group, () => []).add(item);
    }

    final widgets = <Widget>[];
    for (final entry in groups.entries) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: Text(entry.key,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: entry.key == 'TODAY'
                  ? AppColors.primaryBlue
                  : entry.key == 'TOMORROW'
                      ? AppColors.orange
                      : entry.key == 'THIS WEEK'
                          ? AppColors.green
                          : AppColors.textGrey,
              letterSpacing: 0.5,
            )),
      ));
      for (final item in entry.value) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.title,
                    style: const TextStyle(fontSize: 11, color: AppColors.textDark),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              if (item.time.isNotEmpty)
                Text(item.time, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
            ],
          ),
        ));
      }
    }
    return widgets;
  }

  void _showAddTodoDialog() {
    final descController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('To Do List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        content: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Description', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
              const SizedBox(height: 6),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter task description...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildDialogField('Date', 'dd-mm-yyyy', Icons.calendar_today)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildDialogField('Time', 'hh:mm', Icons.access_time)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (descController.text.isNotEmpty) {
                setState(() => _todoItems.add(_TodoItem(descController.text, '', 'UNDATED')));
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            suffixIcon: Icon(icon, size: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}

class _StatData {
  final String label, value;
  final Color color;
  final IconData icon;
  const _StatData(this.label, this.value, this.color, this.icon);
}

class _ScheduleItem {
  final String timeRange, description;
  final bool hasJoin;
  const _ScheduleItem(this.timeRange, this.description, this.hasJoin);
}

class _TodoItem {
  final String title, time, group;
  const _TodoItem(this.title, this.time, this.group);
}
