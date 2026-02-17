import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class RmDashboard extends StatefulWidget {
  const RmDashboard({super.key});

  @override
  State<RmDashboard> createState() => _RmDashboardState();
}

class _RmDashboardState extends State<RmDashboard> {
  final List<_TodoItem> _todoItems = [
    _TodoItem('Review new course submission from Author', '10:00 AM', 'TODAY'),
    _TodoItem('Complete curriculum review for JavaScript course', '02:00 PM', 'TODAY'),
    _TodoItem('Submit feedback on compliance issues', '09:00 AM', 'TOMORROW'),
    _TodoItem('Follow up on resubmitted courses', '11:00 AM', 'THIS WEEK'),
    _TodoItem('Check pending course deadlines', '', 'UNDATED'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          _buildStatsRow(isMobile),
          const SizedBox(height: 24),
          // Main content: Deadlines + To-Do
          isMobile
              ? Column(
                  children: [
                    _buildUpcomingDeadlines(),
                    const SizedBox(height: 20),
                    _buildTodoList(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildUpcomingDeadlines()),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: _buildTodoList()),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(bool isMobile) {
    final stats = [
      _StatData('New Courses\nFor Review', '03', const Color(0xFF2196F3), Icons.file_copy_outlined),
      _StatData('In Progress\nCourses', '12', const Color(0xFFFF9800), Icons.hourglass_bottom),
      _StatData('Reviewed\nCourses', '131', const Color(0xFF4CAF50), Icons.check_circle_outline),
      _StatData('Pending\nCourses', '03', const Color(0xFFE53935), Icons.pending_outlined),
      _StatData('Resubmitted\nCourses', '12', const Color(0xFF9C27B0), Icons.replay_outlined),
    ];

    if (isMobile) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: stats.map((s) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildStatCard(s),
          )).toList(),
        ),
      );
    }

    // 3 cards in first row, 2 in second row (matching Figma)
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatCard(stats[0])),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard(stats[1])),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard(stats[2])),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard(stats[3])),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard(stats[4])),
            const Spacer(),
          ],
        ),
      ],
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.label,
                  style: TextStyle(
                    fontSize: 11,
                    color: stat.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  stat.value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: stat.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(stat.icon, color: stat.color, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingDeadlines() {
    final deadlines = [
      _DeadlineItem(
        'MIT Introduction to Computer Science and Programming in Python - MIT OpenCourseWare',
        'Aug 26, 2025',
      ),
      _DeadlineItem(
        'Healthcare Information Systems: Implementation, Compliance, and Data Governance in Clinical Environments',
        '01 Feb, 2024',
      ),
      _DeadlineItem(
        'Software Testing - Manual Testing, Automation Testing, Unit Testing, Monkey Testing',
        '01 Feb, 2024',
      ),
      _DeadlineItem(
        'Full Stack Web Development with JavaScript, React, Node.js, and MongoDB for Enterprise Applications',
        '01 Feb, 2024',
      ),
      _DeadlineItem(
        'Cybersecurity Essentials for Healthcare Professionals and Data Protection Officers',
        'Aug 26, 2025',
      ),
      _DeadlineItem(
        'Software Testing - Manual Testing, Automation Testing, Unit Testing, Monkey Testing',
        '01 Feb, 2024',
      ),
      _DeadlineItem(
        'Instructional Design for E-Learning Platforms Using Articulate Storyline, Adobe Captivate, and SCORM Standards',
        '01 Feb, 2024',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Upcoming Deadlines',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Text('From', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                  const SizedBox(width: 6),
                  _buildDateChip('20-03-2025'),
                  const SizedBox(width: 10),
                  const Text('To', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                  const SizedBox(width: 6),
                  _buildDateChip('27-03-2025'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...deadlines.map((d) => _buildDeadlineRow(d)),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 12, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(date, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildDeadlineRow(_DeadlineItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF26A69A).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.schedule, size: 16, color: Color(0xFF26A69A)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              style: const TextStyle(fontSize: 12, color: AppColors.textDark),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            item.date,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'To Do List',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          if (_todoItems.isEmpty) ...[
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Icon(Icons.assignment_outlined,
                      size: 64, color: AppColors.orange.withValues(alpha: 0.5)),
                  const SizedBox(height: 12),
                  const Text('No tasks yet',
                      style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ] else ...[
            ..._buildGroupedTodos(),
          ],
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () => _showAddTodoDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              ),
              child: const Text('Add', style: TextStyle(fontSize: 13)),
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
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(
            entry.key,
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
            ),
          ),
        ),
      );
      for (final item in entry.value) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(fontSize: 11, color: AppColors.textDark),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.time.isNotEmpty)
                  Text(
                    item.time,
                    style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
                  ),
              ],
            ),
          ),
        );
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Date', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                        const SizedBox(height: 6),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'dd-mm-yyyy',
                            hintStyle: const TextStyle(fontSize: 12),
                            suffixIcon: const Icon(Icons.calendar_today, size: 16),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Time', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                        const SizedBox(height: 6),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'hh:mm',
                            hintStyle: const TextStyle(fontSize: 12),
                            suffixIcon: const Icon(Icons.access_time, size: 16),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (descController.text.isNotEmpty) {
                setState(() {
                  _todoItems.add(_TodoItem(descController.text, '', 'UNDATED'));
                });
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
}

class _StatData {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  const _StatData(this.label, this.value, this.color, this.icon);
}

class _DeadlineItem {
  final String title;
  final String date;
  const _DeadlineItem(this.title, this.date);
}

class _TodoItem {
  final String title;
  final String time;
  final String group;
  const _TodoItem(this.title, this.time, this.group);
}
