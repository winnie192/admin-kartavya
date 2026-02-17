import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TrainerCoursesScreen extends StatefulWidget {
  final void Function(String courseName) onCourseDetail;

  const TrainerCoursesScreen({super.key, required this.onCourseDetail});

  @override
  State<TrainerCoursesScreen> createState() => _TrainerCoursesScreenState();
}

class _TrainerCoursesScreenState extends State<TrainerCoursesScreen> {
  final _courses = const [
    _CourseRow('UI/UX for beginner', '12hrs:32m', 0, 23),
    _CourseRow('UI/UX for beginner with Gen AI (Get Ready For Future)', '02hrs:02m', 0, 64),
    _CourseRow('Fundamentals of ReactJS with G...', '23hrs:38m', 25, 8),
    _CourseRow('Pharmaceutical medicine healthcar...', '09hrs:52m', 13, 105),
    _CourseRow('UI/UX for beginner with Gen AI (Ge...', '42hrs:18m', 4, 95),
    _CourseRow('Fundamentals of ReactJS with Gen AI', '23hrs:38m', 25, 36),
    _CourseRow('UI/UX for beginner with Gen AI (Get Ready For Future)', '62hrs:02m', 4, 64),
    _CourseRow('UI/UX for beginner', '12hrs:46m', 13, 95),
    _CourseRow('Fundamentals of ReactJS with Gen AI', '02hrs:02m', 13, 24),
    _CourseRow('UI/UX for beginner (Get Ready For Future)', '06hrs:02m', 13, 14),
  ];

  final _thumbGradients = const [
    [Color(0xFF42A5F5), Color(0xFF7E57C2)],
    [Color(0xFFFF7043), Color(0xFFFFCA28)],
    [Color(0xFF66BB6A), Color(0xFF26C6DA)],
    [Color(0xFFEC407A), Color(0xFFAB47BC)],
    [Color(0xFF5C6BC0), Color(0xFF42A5F5)],
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Search + filters row
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.borderGrey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.borderGrey)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Search', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildFilterChip('Business Segment'),
              const SizedBox(width: 8),
              _buildFilterChip('Department'),
              const SizedBox(width: 8),
              _buildFilterChip('Client'),
              const SizedBox(width: 8),
              _buildFilterChip('Program'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('New Course', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
                  ),
                  child: Row(
                    children: [
                      _headerCell('Course Name', flex: 4, hasFilter: true),
                      _headerCell('Duration', flex: 2, hasFilter: true),
                      _headerCell('Sessions', flex: 1, hasFilter: true),
                      _headerCell('Learners', flex: 1, hasFilter: true),
                      _headerCell('Action', flex: 1),
                    ],
                  ),
                ),
                // Rows
                ..._courses.asMap().entries.map((e) => _buildRow(e.key, e.value)),
                // Pagination
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Text('1-${_courses.length} of 1',
                          style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
                      const Spacer(),
                      _pageBtn(Icons.chevron_left),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('1/1', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      const SizedBox(width: 4),
                      _pageBtn(Icons.chevron_right),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _headerCell(String label, {int flex = 1, bool hasFilter = false}) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.orange)),
          if (hasFilter) ...[
            const SizedBox(width: 4),
            Icon(Icons.filter_list, size: 12, color: AppColors.orange),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(int index, _CourseRow course) {
    final grad = _thumbGradients[index % _thumbGradients.length];
    return InkWell(
      onTap: () => widget.onCourseDetail(course.name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
        ),
        child: Row(
          children: [
            // Course name with thumb
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(colors: grad),
                    ),
                    child: const Icon(Icons.play_circle_outline, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(course.name,
                        style: const TextStyle(fontSize: 11, color: AppColors.textDark),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            // Duration
            Expanded(
              flex: 2,
              child: Text(course.duration, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
            ),
            // Sessions
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text('${course.sessions}', style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
                  if (course.sessions > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('${course.sessions}',
                          style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ],
              ),
            ),
            // Learners
            Expanded(
              flex: 1,
              child: Text('${course.learners}', style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
            ),
            // Action
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textGrey),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageBtn(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

class _CourseRow {
  final String name, duration;
  final int sessions, learners;
  const _CourseRow(this.name, this.duration, this.sessions, this.learners);
}
