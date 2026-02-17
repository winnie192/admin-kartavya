import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'training_request_dialog.dart';

class TraineeCoursesScreen extends StatefulWidget {
  const TraineeCoursesScreen({super.key});

  @override
  State<TraineeCoursesScreen> createState() => _TraineeCoursesScreenState();
}

class _TraineeCoursesScreenState extends State<TraineeCoursesScreen> {
  bool _isCardView = true;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Courses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark)),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const TrainingRequestDialog(),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Training Request', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatsRow(),
          const SizedBox(height: 16),
          _buildToolbar(),
          const SizedBox(height: 16),
          if (_isCardView) _buildCardGrid() else _buildTableView(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      ('34', 'Enrolled', AppColors.primaryBlue),
      ('12', 'Completed', AppColors.green),
      ('21', 'Ongoing', const Color(0xFF2196F3)),
      ('21', 'Not Started', AppColors.grey),
      ('21', 'Expired', AppColors.orange),
      ('21', 'Hours Completed', const Color(0xFF00BCD4)),
      ('21', 'Certificates', AppColors.amber),
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: stats
          .map((s) => Container(
                width: 120,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: s.$3.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: s.$3.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.$1,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: s.$3)),
                    const SizedBox(height: 2),
                    Text(s.$2, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildToolbar() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 36,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search courses...',
                hintStyle: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                prefixIcon: const Icon(Icons.search, size: 18),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _filterChip('Business Segment'),
        const SizedBox(width: 8),
        _filterChip('Department'),
        const SizedBox(width: 8),
        _filterChip('Client'),
        const SizedBox(width: 8),
        _filterChip('Program'),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () => setState(() => _isCardView = true),
          icon: Icon(Icons.grid_view,
              size: 20, color: _isCardView ? AppColors.primaryBlue : AppColors.textGrey),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () => setState(() => _isCardView = false),
          icon: Icon(Icons.view_list,
              size: 20, color: !_isCardView ? AppColors.primaryBlue : AppColors.textGrey),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _filterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, size: 16, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _buildCardGrid() {
    final courses = _sampleCourses;
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: courses.map((c) => _CourseCard(course: c)).toList(),
    );
  }

  Widget _buildTableView() {
    final courses = _sampleCourses;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 6)],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: AppColors.topNavBg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: const Row(
                  children: [
                    Expanded(flex: 3, child: Text('Course Name', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(flex: 1, child: Text('Duration', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(flex: 1, child: Text('Status', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(flex: 1, child: Text('Outcome', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(flex: 1, child: Text('Certificate', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(flex: 1, child: Text('Action', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))),
                  ],
                ),
              ),
              // Rows
              ...courses.map((c) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(c.title, style: const TextStyle(fontSize: 12))),
                        Expanded(flex: 1, child: Text(c.duration, style: const TextStyle(fontSize: 12, color: AppColors.textGrey))),
                        Expanded(flex: 1, child: _statusBadge(c.status)),
                        Expanded(flex: 1, child: _outcomeBadge(c.outcome)),
                        Expanded(
                          flex: 1,
                          child: c.status == 'Completed'
                              ? const Text('View', style: TextStyle(fontSize: 11, color: AppColors.primaryBlue))
                              : const Text('-', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/trainee/course-player'),
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            child: const Text('View Course', style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildPagination(),
      ],
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
          icon: const Icon(Icons.chevron_left, size: 20),
        ),
        for (int i = 1; i <= 5; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: InkWell(
              onTap: () => setState(() => _currentPage = i),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _currentPage == i ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$i',
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentPage == i ? Colors.white : AppColors.textGrey,
                  ),
                ),
              ),
            ),
          ),
        IconButton(
          onPressed: _currentPage < 5 ? () => setState(() => _currentPage++) : null,
          icon: const Icon(Icons.chevron_right, size: 20),
        ),
      ],
    );
  }
}

Widget _statusBadge(String status) {
  Color color;
  switch (status) {
    case 'Completed':
      color = AppColors.green;
      break;
    case 'Ongoing':
      color = AppColors.primaryBlue;
      break;
    case 'Not Started':
      color = AppColors.grey;
      break;
    case 'Enrolled':
      color = const Color(0xFF00BCD4);
      break;
    case 'Pending':
      color = AppColors.orange;
      break;
    default:
      color = AppColors.textGrey;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(status, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
  );
}

Widget _outcomeBadge(String outcome) {
  Color color;
  switch (outcome) {
    case 'Achiever':
      color = AppColors.green;
      break;
    case 'Aspirant':
      color = AppColors.primaryBlue;
      break;
    case 'Performer':
      color = AppColors.orange;
      break;
    case 'Front Runner':
      color = const Color(0xFF9C27B0);
      break;
    default:
      color = AppColors.grey;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(outcome, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
  );
}

class _CourseData {
  final String title;
  final String duration;
  final String status;
  final String outcome;

  const _CourseData({required this.title, required this.duration, required this.status, required this.outcome});
}

final _sampleCourses = [
  const _CourseData(title: 'Basics of UX Design', duration: '2h 30m', status: 'Completed', outcome: 'Achiever'),
  const _CourseData(title: 'Advanced Flutter Development', duration: '4h 15m', status: 'Ongoing', outcome: 'Aspirant'),
  const _CourseData(title: 'Project Management Fundamentals', duration: '1h 45m', status: 'Not Started', outcome: 'Pending'),
  const _CourseData(title: 'Business Communication Skills', duration: '3h 00m', status: 'Completed', outcome: 'Performer'),
  const _CourseData(title: 'Data Analytics Essentials', duration: '5h 20m', status: 'Enrolled', outcome: 'Pending'),
  const _CourseData(title: 'Leadership & Team Management', duration: '2h 00m', status: 'Ongoing', outcome: 'Front Runner'),
  const _CourseData(title: 'Cloud Computing Basics', duration: '3h 30m', status: 'Completed', outcome: 'Achiever'),
  const _CourseData(title: 'Cybersecurity Awareness', duration: '1h 15m', status: 'Not Started', outcome: 'Pending'),
];

class _CourseCard extends StatelessWidget {
  final _CourseData course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail placeholder
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.play_circle_outline, size: 36, color: AppColors.primaryBlue),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: _statusBadge(course.status),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _outcomeBadge(course.outcome),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text(course.duration, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (course.status == 'Completed')
                      const Text('Certificate',
                          style: TextStyle(fontSize: 11, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/trainee/course-player'),
                      child: const Text('View Course',
                          style: TextStyle(fontSize: 11, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
