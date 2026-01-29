import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow1(),
          const SizedBox(height: 16),
          _buildRow2(context),
          const SizedBox(height: 16),
          _buildRow3(),
        ],
      ),
    );
  }

  // ── ROW 1: Course Summary (donut) + User Summary (grouped bars) ──

  Widget _buildRow1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildCourseSummary()),
        const SizedBox(width: 12),
        Expanded(flex: 4, child: _buildUserSummary()),
      ],
    );
  }

  Widget _buildCourseSummary() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Course Summary'),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: _DonutPainter(
                    segments: [
                      _DonutSegment(52, AppColors.green),
                      _DonutSegment(7, AppColors.amber),
                      _DonutSegment(9, AppColors.red),
                      _DonutSegment(2, AppColors.grey),
                    ],
                    total: 67,
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total Courses',
                            style: TextStyle(fontSize: 7, color: AppColors.textGrey)),
                        Text('67',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _legendItem(AppColors.green, 'Published', '52'),
                    _legendItem(AppColors.amber, 'Under Review', '07'),
                    _legendItem(AppColors.red, 'Rejected', '09'),
                    _legendItem(AppColors.grey, 'Inactive', '02'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
          const Spacer(),
          Text(value,
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildUserSummary() {
    const categories = ['Trainee', 'Trainor', 'Author', 'Guest'];
    const activeValues = [480, 480, 480, 480];
    const inactiveValues = [590, 590, 590, 590];
    const maxVal = 800.0;

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _sectionTitle('User Summary'),
              const Spacer(),
              _dotLabel(AppColors.primaryBlue, 'Active'),
              const SizedBox(width: 10),
              _dotLabel(AppColors.red, 'Inactive'),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(categories.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${activeValues[i]}',
                            style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryBlue)),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 12,
                              height: 70 * (activeValues[i] / maxVal),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(3)),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Container(
                              width: 12,
                              height: 70 * (inactiveValues[i] / maxVal),
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(3)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(categories[i],
                            style: const TextStyle(
                                fontSize: 8, color: AppColors.textGrey)),
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

  Widget _dotLabel(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
      ],
    );
  }

  // ── ROW 2: Exam Creation + Exams Summary + Create Course (3 cols) ──

  Widget _buildRow2(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildExamCreationCard(context)),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: _buildExamsSummaryCard()),
        const SizedBox(width: 12),
        Expanded(flex: 3, child: _buildCreateCourseCard(context)),
      ],
    );
  }

  Widget _buildExamCreationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome To',
                    style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                const Text('Exam Creation',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                const Text(
                  'Ready to assess and empower your learners?\nCreate, assign, and track exams all in one place.\nChoose a method that fits your style — both are just a click away!',
                  style: TextStyle(fontSize: 9, color: AppColors.textGrey),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _smallOutlinedBtn('AI Generated', Icons.auto_awesome,
                        () => Navigator.pushNamed(context, '/exams')),
                    const SizedBox(width: 6),
                    _smallOutlinedBtn('Create Manually', Icons.edit,
                        () => Navigator.pushNamed(context, '/exams')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Illustration placeholder
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.quiz, size: 36, color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }

  Widget _smallOutlinedBtn(String label, IconData icon, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 12),
      label: Text(label, style: const TextStyle(fontSize: 9)),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: const BorderSide(color: AppColors.primaryBlue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  Widget _buildExamsSummaryCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Exams Summary'),
          const SizedBox(height: 14),
          _examSummaryRow(AppColors.primaryBlue, 'Ongoing', '09'),
          _examSummaryRow(AppColors.green, 'Completed', '143'),
          _examSummaryRow(AppColors.amber, 'Upcoming', '09'),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Total Exams',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark)),
              Text('143',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _examSummaryRow(Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
              width: 8,
              height: 8,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label,
              style:
                  const TextStyle(fontSize: 10, color: AppColors.textGrey)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildCreateCourseCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create Course',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                const Text(
                  'Start building a course from scratch!',
                  style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/create-course'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    elevation: 0,
                  ),
                  child:
                      const Text('Create', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.school, size: 36, color: AppColors.amber),
          ),
        ],
      ),
    );
  }

  // ── ROW 3: Recent view courses + To Do List ──

  Widget _buildRow3() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildRecentCourses()),
        const SizedBox(width: 12),
        Expanded(flex: 3, child: _buildTodoList()),
      ],
    );
  }

  Widget _buildRecentCourses() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _sectionTitle('Recent view courses'),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('View All',
                    style: TextStyle(
                        color: AppColors.primaryBlue, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _courseCard(
                date: '18 Jan 2025',
                title: 'JavaScript the advance level for pro coders by kartavya Healtheon',
                author: 'Rahul Verma',
                trainer: 'Ganesh Anandraj',
                duration: '04hrs:52m',
                sections: 3,
                learners: 123,
                color: AppColors.primaryBlue,
                icon: Icons.code,
              )),
              const SizedBox(width: 12),
              Expanded(child: _courseCard(
                date: '18 Jan 2025',
                title: 'JavaScript the advance level for pro coders by kartavya Healtheon',
                author: 'Rahul Verma',
                trainer: 'Ganesh Anandraj',
                duration: '04hrs:52m',
                sections: 3,
                learners: 123,
                color: AppColors.primaryBlue,
                icon: Icons.code,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _courseCard({
    required String date,
    required String title,
    required String author,
    required String trainer,
    required String duration,
    required int sections,
    required int learners,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail placeholder
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Center(
              child: Icon(icon, size: 40, color: color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date,
                    style: const TextStyle(
                        fontSize: 8, color: AppColors.textGrey)),
                const SizedBox(height: 4),
                Text(title,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                _infoRow(Icons.person, 'Author : $author'),
                const SizedBox(height: 3),
                _infoRow(Icons.school, 'Trainor : $trainer'),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _iconStat(Icons.access_time, duration),
                    const SizedBox(width: 10),
                    _iconStat(Icons.layers, '$sections Sections'),
                    const SizedBox(width: 10),
                    _iconStat(Icons.people, '$learners'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 11, color: AppColors.textGrey),
        const SizedBox(width: 4),
        Text(text,
            style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
      ],
    );
  }

  Widget _iconStat(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10, color: AppColors.textGrey),
        const SizedBox(width: 3),
        Text(text,
            style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
      ],
    );
  }

  Widget _buildTodoList() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _sectionTitle('To Do List'),
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
                        color: AppColors.primaryBlue, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.checklist,
                      size: 40, color: AppColors.primaryBlue),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    elevation: 0,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

// ── Custom donut chart painter ──

class _DonutSegment {
  final double value;
  final Color color;
  _DonutSegment(this.value, this.color);
}

class _DonutPainter extends CustomPainter {
  final List<_DonutSegment> segments;
  final double total;

  _DonutPainter({required this.segments, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const strokeWidth = 14.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    final sum = segments.fold<double>(0, (s, seg) => s + seg.value);
    var startAngle = -math.pi / 2;

    for (final seg in segments) {
      final sweep = (seg.value / sum) * 2 * math.pi;
      final paint = Paint()
        ..color = seg.color
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
