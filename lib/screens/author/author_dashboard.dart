import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class AuthorDashboard extends StatelessWidget {
  const AuthorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Dashboard',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 16),
          // Stats Row
          _buildStatsRow(),
          const SizedBox(height: 20),
          // Main content
          isMobile
              ? Column(
                  children: [
                    _buildRecentCourses(),
                    const SizedBox(height: 16),
                    _buildCreateCourseCta(context),
                    const SizedBox(height: 16),
                    _buildNotifications(),
                    const SizedBox(height: 16),
                    _buildTodoList(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          _buildRecentCourses(),
                          const SizedBox(height: 16),
                          _buildNotifications(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildCreateCourseCta(context),
                          const SizedBox(height: 16),
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

  Widget _buildStatsRow() {
    final stats = [
      _StatItem('67', 'Total Course', const Color(0xFF2196F3)),
      _StatItem('12', 'Completed', const Color(0xFF4CAF50)),
      _StatItem('8', 'Ongoing', const Color(0xFFFF9800)),
      _StatItem('3', 'Rejected', const Color(0xFFE53935)),
      _StatItem('15', 'Draft', const Color(0xFF9E9E9E)),
      _StatItem('20', 'Approved', const Color(0xFF2196F3)),
      _StatItem('9', 'Pending', const Color(0xFFFFC107)),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stats
            .map((s) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildStatCard(s),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatCard(_StatItem item) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: item.color, width: 3)),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.value,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: item.color)),
          const SizedBox(height: 4),
          Text(item.label,
              style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
        ],
      ),
    );
  }

  Widget _buildRecentCourses() {
    final courses = [
      _CourseItem('Introduction to Flutter', 'Ongoing', const Color(0xFFFF9800), const Color(0xFF42A5F5)),
      _CourseItem('Advanced Dart Programming', 'Completed', const Color(0xFF4CAF50), const Color(0xFF66BB6A)),
      _CourseItem('UI/UX Design Basics', 'Draft', const Color(0xFF9E9E9E), const Color(0xFFEF5350)),
      _CourseItem('Cloud Computing 101', 'Approved', const Color(0xFF2196F3), const Color(0xFFAB47BC)),
      _CourseItem('Data Science Intro', 'Pending', const Color(0xFFFFC107), const Color(0xFFFFA726)),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent View Courses',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: courses
                  .map((c) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _buildCourseCard(c),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(_CourseItem item) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  item.thumbColor.withValues(alpha: 0.25),
                  item.thumbColor.withValues(alpha: 0.08),
                ],
              ),
            ),
            child: CustomPaint(
              painter: _IllustrationPainter(item.thumbColor),
              child: Center(
                child: Icon(Icons.menu_book, size: 24,
                    color: item.thumbColor.withValues(alpha: 0.6)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: item.statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(item.status,
                      style: TextStyle(
                          fontSize: 9,
                          color: item.statusColor,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateCourseCta(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.auto_stories, size: 40, color: AppColors.amber),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Start building a course from scratch',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/author/create-course'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                elevation: 0,
              ),
              child:
                  const Text('Create Course', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifications() {
    final notifications = [
      _NotifItem('Rahul Sharma', 'Trainer', 'Submitted feedback on Module 3', '21 Min Ago', const Color(0xFF42A5F5), 0.75),
      _NotifItem('Priya Singh', 'Trainee', 'Completed Course: Flutter Basics', '45 Min Ago', const Color(0xFF66BB6A), 1.0),
      _NotifItem('Amit Kumar', 'Trainer', 'Requested course content update', '2 Hr Ago', const Color(0xFFEF5350), 0.4),
      _NotifItem('Neha Gupta', 'Trainee', 'Started new course enrollment', '3 Hr Ago', const Color(0xFFAB47BC), 0.15),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notifications',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 12),
          ...notifications.map((n) => _buildNotifItem(n)),
        ],
      ),
    );
  }

  Widget _buildNotifItem(_NotifItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: item.avatarColor.withValues(alpha: 0.2),
            child: Text(item.name[0],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: item.avatarColor)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: item.role == 'Trainer'
                            ? AppColors.primaryBlue.withValues(alpha: 0.1)
                            : AppColors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(item.role,
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: item.role == 'Trainer'
                                  ? AppColors.primaryBlue
                                  : AppColors.green)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(item.message,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(height: 4),
                // Progress indicator bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: item.progress,
                    backgroundColor: AppColors.borderGrey,
                    valueColor: AlwaysStoppedAnimation(item.avatarColor),
                    minHeight: 3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(item.time,
                    style: TextStyle(
                        fontSize: 9,
                        color: AppColors.textGrey.withValues(alpha: 0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    final todos = [
      'Review Module 5 content',
      'Update course description for Flutter Advanced',
      'Reply to trainer feedback',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('To-Do List',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark)),
              const Spacer(),
              SizedBox(
                width: 28,
                height: 28,
                child: FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  backgroundColor: AppColors.primaryBlue,
                  elevation: 0,
                  child: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.checklist, size: 28, color: AppColors.primaryBlue),
            ),
          ),
          const SizedBox(height: 12),
          ...todos.map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderGrey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(t,
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.textDark)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _IllustrationPainter extends CustomPainter {
  final Color color;
  _IllustrationPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Large circle (top-right)
    paint.color = color.withValues(alpha: 0.15);
    canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.2), 28, paint);

    // Medium circle (bottom-left)
    paint.color = color.withValues(alpha: 0.12);
    canvas.drawCircle(
        Offset(size.width * 0.15, size.height * 0.7), 18, paint);

    // Small decorative dots
    paint.color = color.withValues(alpha: 0.25);
    canvas.drawCircle(
        Offset(size.width * 0.6, size.height * 0.75), 6, paint);
    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.3), 4, paint);
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 0.6), 5, paint);

    // Rounded rect accent
    paint.color = color.withValues(alpha: 0.1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.05, size.height * 0.1, 30, 14),
        const Radius.circular(4),
      ),
      paint,
    );

    // Triangle-ish shape
    paint.color = color.withValues(alpha: 0.08);
    final path = Path()
      ..moveTo(size.width * 0.45, size.height * 0.05)
      ..lineTo(size.width * 0.55, size.height * 0.3)
      ..lineTo(size.width * 0.35, size.height * 0.3)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatItem {
  final String value;
  final String label;
  final Color color;
  const _StatItem(this.value, this.label, this.color);
}

class _CourseItem {
  final String title;
  final String status;
  final Color statusColor;
  final Color thumbColor;
  const _CourseItem(this.title, this.status, this.statusColor, this.thumbColor);
}

class _NotifItem {
  final String name;
  final String role;
  final String message;
  final String time;
  final Color avatarColor;
  final double progress;
  const _NotifItem(this.name, this.role, this.message, this.time, this.avatarColor, this.progress);
}
