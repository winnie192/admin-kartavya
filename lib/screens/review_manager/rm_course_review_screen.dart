import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class RmCourseReviewScreen extends StatefulWidget {
  const RmCourseReviewScreen({super.key});

  @override
  State<RmCourseReviewScreen> createState() => _RmCourseReviewScreenState();
}

class _RmCourseReviewScreenState extends State<RmCourseReviewScreen> {
  final _searchController = TextEditingController();
  int _expandedIndex = -1;

  final _filters = {
    'Business Segment': 'All',
    'Department': 'All',
    'Client': 'All',
    'Program': 'All',
  };

  final List<_CourseReviewItem> _courses = [
    _CourseReviewItem(
      dateCreated: '12-09-2023',
      dateUpdated: '23-10-2023',
      courseName: 'MIT Introduction to Computer Science and Programm...',
      fullCourseName: 'MIT Introduction to Computer Science and Programming in Python - MIT OpenCourseWare',
      programManager: 'Divya Balakrishna Shetty',
      status: 'New',
      classifyTypes: [],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '19-03-2025',
      dateUpdated: '25-03-2025',
      courseName: 'UI/UX the beginner guide for the Non IT and Non Codi...',
      fullCourseName: 'UI/UX the beginner guide for the Non IT and Non Coding',
      programManager: 'Zohra Sawant',
      status: 'In Progress',
      classifyTypes: ['Non Compliance', 'Unsolicited Content'],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '12-09-2023',
      dateUpdated: '10-10-2023',
      courseName: 'Software Testing - Manual Testing, Automation Testi...',
      fullCourseName: 'Software Testing - Manual Testing, Automation Testing, Unit Testing, Monkey Testing',
      programManager: 'Clement Pinto',
      status: 'Reviewed',
      classifyTypes: ['Ok To Publish'],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '07-12-2024',
      dateUpdated: '18-12-2024',
      courseName: 'Natural Language Processing (NLP) with AI',
      fullCourseName: 'Natural Language Processing (NLP) with AI',
      programManager: 'Rachana Dharmnath Singh',
      status: 'Pending',
      classifyTypes: [],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '19-03-2025',
      dateUpdated: '10-04-2025',
      courseName: 'UI/UX the beginner guide for the Non IT and Non Codi...',
      fullCourseName: 'UI/UX the beginner guide for the Non IT and Non Coding',
      programManager: 'Zohra Sawant',
      status: 'In Progress',
      classifyTypes: ['Ok To Publish', 'Other Concern', 'Unsolicited Content', 'Patient Privacy'],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_105',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '09-09-2025',
      lastStatus: 'Resubmitted',
      lastClassify: ['Non Compliance', 'Unsolicited Content'],
      lastReviewDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '12-09-2023',
      dateUpdated: '10-10-2023',
      courseName: 'Software Testing - Manual Testing, Automation Testi...',
      fullCourseName: 'Software Testing - Manual Testing, Automation Testing, Unit Testing, Monkey Testing',
      programManager: 'Clement Pinto',
      status: 'Reviewed',
      classifyTypes: ['Patient Privacy', 'Other Concern'],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '12-09-2023',
      dateUpdated: '09-12-2023',
      courseName: 'MIT Introduction to Computer Science and Programm...',
      fullCourseName: 'MIT Introduction to Computer Science and Programming in Python - MIT OpenCourseWare',
      programManager: 'Divya Balakrishna Shetty',
      status: 'Resubmitted',
      classifyTypes: ['Non Compliance', 'Unsolicited Content'],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '12-09-2023',
      dateUpdated: '10-10-2023',
      courseName: 'Software Testing - Manual Testing, Automation Testi...',
      fullCourseName: 'Software Testing - Manual Testing, Automation Testing, Unit Testing, Monkey Testing',
      programManager: 'Clement Pinto',
      status: 'Reviewed',
      classifyTypes: ['Patient Privacy', 'Other Concern'],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
    _CourseReviewItem(
      dateCreated: '19-03-2025',
      dateUpdated: '04-04-2025',
      courseName: 'UI/UX the beginner guide for the Non IT and Non Codi...',
      fullCourseName: 'UI/UX the beginner guide for the Non IT and Non Coding',
      programManager: 'Zohra Sawant',
      status: 'In Progress',
      classifyTypes: ['Ok To Publish'],
      businessSegment: 'Cipla',
      department: 'Campo',
      client: 'Cipla_new_123',
      program: 'Cipla_Ab_new_corners',
      reviewedDate: '23-08-2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters row
          _buildFilters(isMobile),
          const SizedBox(height: 16),
          // Search row
          _buildSearchRow(),
          const SizedBox(height: 16),
          // Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: Column(
              children: [
                // Table header
                _buildTableHeader(),
                const Divider(height: 1, color: AppColors.borderGrey),
                // Table rows
                ...List.generate(_courses.length, (i) => _buildTableRow(i)),
                const Divider(height: 1, color: AppColors.borderGrey),
                // Pagination
                _buildPagination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(bool isMobile) {
    if (isMobile) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _filters.keys.map((k) => _buildFilterDropdown(k)).toList(),
      );
    }
    return Row(
      children: [
        for (final key in _filters.keys) ...[
          _buildFilterDropdown(key),
          const SizedBox(width: 8),
        ],
      ],
    );
  }

  Widget _buildFilterDropdown(String label) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'All',
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
          items: [
            DropdownMenuItem(value: 'All', child: Text(label, style: const TextStyle(fontSize: 12))),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 36,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.amber,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text('Search', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          _headerCell('Date', flex: 2, hasFilter: true),
          _headerCell('Course Name', flex: 4, hasFilter: true),
          _headerCell('Program Manager', flex: 3, hasFilter: true),
          _headerCell('Status', flex: 2, hasFilter: true),
          _headerCell('Classify Type', flex: 3, hasFilter: true),
          _headerCell('Action', flex: 1),
        ],
      ),
    );
  }

  Widget _headerCell(String label, {int flex = 1, bool hasFilter = false}) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          if (hasFilter) ...[
            const SizedBox(width: 4),
            Icon(Icons.filter_list, size: 12, color: AppColors.textGrey),
          ],
        ],
      ),
    );
  }

  Widget _buildTableRow(int index) {
    final course = _courses[index];
    final isExpanded = _expandedIndex == index;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expandedIndex = isExpanded ? -1 : index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: isExpanded ? AppColors.primaryBlue.withValues(alpha: 0.05) : Colors.white,
            child: Row(
              children: [
                // Date column
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.dateCreated,
                          style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
                      Text(course.dateUpdated,
                          style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
                    ],
                  ),
                ),
                // Course Name
                Expanded(
                  flex: 4,
                  child: Text(
                    course.courseName,
                    style: const TextStyle(fontSize: 11, color: AppColors.textDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Program Manager
                Expanded(
                  flex: 3,
                  child: Text(
                    course.programManager,
                    style: const TextStyle(fontSize: 11, color: AppColors.textDark),
                  ),
                ),
                // Status
                Expanded(
                  flex: 2,
                  child: _buildStatusBadge(course.status),
                ),
                // Classify Type
                Expanded(
                  flex: 3,
                  child: course.classifyTypes.isEmpty
                      ? const Text('--', style: TextStyle(fontSize: 11, color: AppColors.textGrey))
                      : Wrap(
                          spacing: 4,
                          runSpacing: 2,
                          children: course.classifyTypes.map((t) => _buildClassifyChip(t)).toList(),
                        ),
                ),
                // Action
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.info_outline, size: 18, color: AppColors.primaryBlue),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/review-manager/course-detail');
                        },
                        child: const Icon(Icons.visibility_outlined, size: 18, color: AppColors.primaryBlue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expanded row detail
        if (isExpanded) _buildExpandedDetail(course),
        if (index < _courses.length - 1)
          const Divider(height: 1, color: AppColors.borderGrey),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    switch (status) {
      case 'New':
        bgColor = const Color(0xFF2196F3);
        textColor = Colors.white;
        break;
      case 'In Progress':
        bgColor = const Color(0xFFFF9800);
        textColor = Colors.white;
        break;
      case 'Reviewed':
        bgColor = const Color(0xFF4CAF50);
        textColor = Colors.white;
        break;
      case 'Pending':
        bgColor = const Color(0xFFFFC107);
        textColor = Colors.white;
        break;
      case 'Resubmitted':
        bgColor = const Color(0xFF9C27B0);
        textColor = Colors.white;
        break;
      default:
        bgColor = AppColors.grey;
        textColor = Colors.white;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(fontSize: 10, color: textColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildClassifyChip(String type) {
    Color dotColor;
    switch (type) {
      case 'Non Compliance':
        dotColor = const Color(0xFFE53935);
        break;
      case 'Unsolicited Content':
        dotColor = const Color(0xFFE53935);
        break;
      case 'Ok To Publish':
        dotColor = const Color(0xFF4CAF50);
        break;
      case 'Patient Privacy':
        dotColor = const Color(0xFF424242);
        break;
      case 'Other Concern':
        dotColor = const Color(0xFF424242);
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
        const SizedBox(width: 4),
        Text(type, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
      ],
    );
  }

  Widget _buildExpandedDetail(_CourseReviewItem course) {
    final bool hasLastStatus = course.lastStatus != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info icon row
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bar_chart, size: 14, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  course.fullCourseName,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _detailRow('Course Name', course.fullCourseName),
          _detailRow('Business Segment', course.businessSegment),
          _detailRow('Department', course.department),
          _detailRow('Client', course.client),
          _detailRow('Program', course.program),
          _detailRow('Program Manager', course.programManager),
          const Divider(height: 20, color: AppColors.borderGrey),
          // Status icon
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.info_outline, size: 14, color: AppColors.primaryBlue),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (hasLastStatus) ...[
            _detailRowWidget('Last Status', _buildStatusBadge(course.lastStatus!)),
            _detailRowWidget('Last Classify', Wrap(
              spacing: 8,
              children: (course.lastClassify ?? []).map((t) => _buildClassifyChip(t)).toList(),
            )),
            _detailRow('Last Review Date', course.lastReviewDate ?? ''),
          ],
          _detailRowWidget('Status', _buildStatusBadge(course.status)),
          _detailRowWidget('Classify', course.classifyTypes.isEmpty
              ? const Text('--', style: TextStyle(fontSize: 11, color: AppColors.textGrey))
              : Wrap(
                  spacing: 8,
                  children: course.classifyTypes.map((t) => _buildClassifyChip(t)).toList(),
                )),
          _detailRow('Reviewed Date', course.reviewedDate),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 11, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRowWidget(String label, Widget value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          Expanded(child: value),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '1-${_courses.length} of 1',
            style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
          ),
          const SizedBox(width: 12),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.chevron_left, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 4),
          const Text('1/1', style: TextStyle(fontSize: 11, color: AppColors.textDark)),
          const SizedBox(width: 4),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.chevron_right, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _CourseReviewItem {
  final String dateCreated;
  final String dateUpdated;
  final String courseName;
  final String fullCourseName;
  final String programManager;
  final String status;
  final List<String> classifyTypes;
  final String businessSegment;
  final String department;
  final String client;
  final String program;
  final String reviewedDate;
  final String? lastStatus;
  final List<String>? lastClassify;
  final String? lastReviewDate;

  const _CourseReviewItem({
    required this.dateCreated,
    required this.dateUpdated,
    required this.courseName,
    required this.fullCourseName,
    required this.programManager,
    required this.status,
    required this.classifyTypes,
    required this.businessSegment,
    required this.department,
    required this.client,
    required this.program,
    required this.reviewedDate,
    this.lastStatus,
    this.lastClassify,
    this.lastReviewDate,
  });
}
