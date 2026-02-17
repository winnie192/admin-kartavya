import 'package:flutter/material.dart';
import 'dart:math';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class TraineeDashboard extends StatelessWidget {
  const TraineeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsRow(isMobile),
          const SizedBox(height: 20),
          // Recent view courses
          const Text('Recent view courses',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _recentCourseCard(
                  'Beginner\'s Guide to becoming a professional frontend developer',
                  '04hrs:52m',
                  'Completed',
                  'Achiever',
                ),
                const SizedBox(width: 12),
                _recentCourseCard(
                  'Beginner\'s Guide to becoming a professional frontend developer',
                  '04hrs:52m',
                  'Ongoing',
                  'Pending',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          isMobile
              ? Column(children: [
                  _buildCourseSummaryCard(),
                  const SizedBox(height: 16),
                  _buildUpcomingScheduleCard(),
                  const SizedBox(height: 16),
                  const _TodoListWidget(),
                ])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildUpcomingScheduleCard(),
                          const SizedBox(height: 16),
                          _buildCourseSummaryCard(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      flex: 1,
                      child: _TodoListWidget(),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _recentCourseCard(
      String title, String duration, String status, String outcome) {
    Color statusColor;
    switch (status) {
      case 'Completed':
        statusColor = AppColors.green;
        break;
      case 'Ongoing':
        statusColor = AppColors.primaryBlue;
        break;
      default:
        statusColor = AppColors.grey;
    }
    Color outcomeColor;
    switch (outcome) {
      case 'Achiever':
        outcomeColor = AppColors.green;
        break;
      case 'Pending':
        outcomeColor = AppColors.orange;
        break;
      default:
        outcomeColor = AppColors.grey;
    }

    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.play_circle_outline,
                      size: 30, color: AppColors.primaryBlue),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(status,
                        style: TextStyle(
                            fontSize: 8,
                            color: statusColor,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: outcomeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(outcome,
                        style: TextStyle(
                            fontSize: 8,
                            color: outcomeColor,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(duration,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (status == 'Completed')
                      const Text('Certificate',
                          style: TextStyle(
                              fontSize: 10, color: AppColors.primaryBlue)),
                    const Spacer(),
                    const Text('View Course',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.primaryBlue)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(bool isMobile) {
    final stats = [
      ('210', 'Total Courses', AppColors.primaryBlue),
      ('502', 'Completed Course', AppColors.green),
      ('08', 'Pending Task', AppColors.orange),
      ('02', 'Ongoing Exams', const Color(0xFF9C27B0)),
      ('12', 'Upcoming Exams', AppColors.amber),
      ('08', 'Hours Completed', const Color(0xFF00BCD4)),
      ('08', 'Certificate', AppColors.red),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: stats
          .map((s) => _StatCard(value: s.$1, label: s.$2, color: s.$3))
          .toList(),
    );
  }

  Widget _buildCourseSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Course Summary',
                  style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const Spacer(),
              Row(
                children: [
                  const Text('Total Courses',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textGrey)),
                  const SizedBox(width: 4),
                  const Text('67',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 140, height: 140, child: _DonutChart()),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _legendItem(AppColors.green, 'Completed', '52'),
                  const SizedBox(height: 6),
                  _legendItem(AppColors.primaryBlue, 'Ongoing', '07'),
                  const SizedBox(height: 6),
                  _legendItem(AppColors.orange, 'Expired', '09'),
                  const SizedBox(height: 6),
                  _legendItem(AppColors.grey, 'Inactive', '02'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$label $count',
            style: const TextStyle(
                fontSize: 11, color: AppColors.textGrey)),
      ],
    );
  }

  Widget _buildUpcomingScheduleCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upcoming Schedule',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              _dateChip('From', '20-03-2025'),
              const SizedBox(width: 12),
              _dateChip('To', '27-03-2025'),
            ],
          ),
          const SizedBox(height: 16),
          _scheduleItem(
            '11:00 - 12:00 Feb 2, 2019',
            'Feedback form open for Time Management Skills Test',
          ),
          const Divider(height: 24),
          _scheduleItem(
            '11:00 - 12:00 Feb 2, 2019',
            'Review Exam Submissions',
            showJoin: false,
          ),
          const Divider(height: 24),
          _scheduleItem(
            '11:00 - 12:00 Feb 2, 2019',
            'Feedback form open for Time Management Skills Test',
          ),
          const Divider(height: 24),
          _scheduleItem(
            '11:00 - 12:00 Feb 2, 2019',
            'Review Exam Submissions',
            showJoin: false,
          ),
          const Divider(height: 24),
          _scheduleItem(
            '11:00 - 12:00 Feb 2, 2019',
            'Review Exam Submissions',
            showJoin: false,
          ),
        ],
      ),
    );
  }

  Widget _dateChip(String label, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ',
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textGrey)),
          Text(date,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _scheduleItem(String time, String title,
      {bool showJoin = true}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,
                  style: const TextStyle(
                      fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(height: 2),
              Text(title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (showJoin)
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Join', style: TextStyle(fontSize: 10)),
          ),
        const SizedBox(width: 6),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('View Details',
              style: TextStyle(fontSize: 10)),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatCard(
      {required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: color)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textGrey)),
        ],
      ),
    );
  }
}

class _DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(140, 140),
      painter: _DonutPainter(),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('67',
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            Text('Total',
                style:
                    TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ],
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 20.0;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final segments = [
      (AppColors.green, 52.0),
      (AppColors.primaryBlue, 7.0),
      (AppColors.orange, 9.0),
      (AppColors.grey, 2.0),
    ];
    const total = 67.0;

    var startAngle = -pi / 2;
    for (final (color, value) in segments) {
      final sweep = (value / total) * 2 * pi;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// To Do List widget
class _TodoListWidget extends StatefulWidget {
  const _TodoListWidget();

  @override
  State<_TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<_TodoListWidget> {
  final _todos = <_TodoItem>[
    _TodoItem(
        title: 'Design test for new batch of cipla',
        date: 'TODAY: JAN 18',
        time: '06:30 AM'),
    _TodoItem(
        title: 'Take test of ui/ux for two new emplo...',
        date: 'TOMORROW: AUG 26',
        time: '06:30 AM'),
    _TodoItem(
        title: 'Take test of ui/ux for two new emplo...',
        date: 'THIS WEEK',
        time: ''),
    _TodoItem(
        title: 'Take test of ui/ux for two new emplo...',
        date: 'UNDATED',
        time: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('To Do List',
                  style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const Spacer(),
              GestureDetector(
                onTap: () => _showAddTodoDialog(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Add',
                      style: TextStyle(
                          color: Colors.white, fontSize: 11)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final todo in _todos) ...[
            _buildTodoItem(todo),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildTodoItem(_TodoItem todo) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${todo.date}${todo.time.isNotEmpty ? ' [${todo.time}]' : ''}',
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppColors.textGrey),
          ),
          const SizedBox(height: 4),
          Text(todo.title,
              style: const TextStyle(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('To Do List',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              const Text('Description',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  hintStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColors.borderGrey),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Date',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 6),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: '12/4/2025',
                            hintStyle: const TextStyle(fontSize: 12),
                            suffixIcon: const Icon(
                                Icons.calendar_today,
                                size: 14),
                            contentPadding:
                                const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.borderGrey),
                            ),
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
                        const Text('Time',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 6),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: '06:30 AM',
                            hintStyle: const TextStyle(fontSize: 12),
                            suffixIcon: const Icon(
                                Icons.access_time,
                                size: 14),
                            contentPadding:
                                const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.borderGrey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel',
                        style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save',
                        style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodoItem {
  final String title;
  final String date;
  final String time;

  _TodoItem(
      {required this.title, required this.date, required this.time});
}
