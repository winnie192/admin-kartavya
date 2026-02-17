import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthorManageCourseScreen extends StatefulWidget {
  const AuthorManageCourseScreen({super.key});

  @override
  State<AuthorManageCourseScreen> createState() =>
      _AuthorManageCourseScreenState();
}

class _AuthorManageCourseScreenState extends State<AuthorManageCourseScreen> {
  int _tabIndex = 0; // 0=Courses, 1=Requests
  bool _isCardView = false;
  final Set<int> _expandedCourseRows = {};
  final Set<int> _expandedRequestRows = {};

  final _courses = const [
    _CourseRow('12 Jan 2025', 'Introduction to Flutter', 'Request', 'New'),
    _CourseRow('10 Jan 2025', 'Advanced Dart Programming', 'Self', 'Approved'),
    _CourseRow('08 Jan 2025', 'UI/UX Design Basics', 'Request', 'Rejected'),
    _CourseRow('05 Jan 2025', 'Cloud Computing 101', 'Self', 'Draft'),
    _CourseRow('03 Jan 2025', 'Data Science Intro', 'Request', 'New'),
    _CourseRow('01 Jan 2025', 'Machine Learning Basics', 'Self', 'Approved'),
  ];

  final _requests = const [
    _RequestRow('15 Jan 2025', 'Rahul Sharma', 'Trainer', 'New', 'New Course', 'Need a course on React Native'),
    _RequestRow('13 Jan 2025', 'Priya Singh', 'Trainee', 'Existing', 'Update content for Module 3', 'Approved'),
    _RequestRow('11 Jan 2025', 'Amit Kumar', 'Trainer', 'New', 'Course on DevOps CI/CD', 'Rejected'),
    _RequestRow('09 Jan 2025', 'Neha Gupta', 'Trainee', 'Existing', 'Fix assessment questions', 'Complete'),
    _RequestRow('07 Jan 2025', 'Vikram Patel', 'Trainer', 'New', 'Course on AWS Services', 'Draft'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Manage Course',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 14),
          // Sub-tab bar
          _buildSubTabs(),
          const SizedBox(height: 14),
          // Search + action bar
          _buildSearchBar(),
          const SizedBox(height: 12),
          // Filters
          _buildFilters(),
          const SizedBox(height: 12),
          // Date range
          _buildDateRange(),
          const SizedBox(height: 12),
          // View toggle (only for Courses tab)
          if (_tabIndex == 0) _buildViewToggle(),
          if (_tabIndex == 0) const SizedBox(height: 12),
          // Content
          _tabIndex == 0
              ? (_isCardView ? _buildCardView() : _buildCoursesTable())
              : _buildRequestsTable(),
          const SizedBox(height: 12),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildSubTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.borderGrey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabPill(0, 'Courses'),
          _buildTabPill(1, 'Requests'),
        ],
      ),
    );
  }

  Widget _buildTabPill(int index, String label) {
    final isActive = _tabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _tabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : AppColors.textGrey)),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 34,
            child: TextField(
              style: const TextStyle(fontSize: 11),
              decoration: InputDecoration(
                hintText: 'Search courses...',
                hintStyle:
                    const TextStyle(fontSize: 11, color: AppColors.grey),
                prefixIcon:
                    const Icon(Icons.search, size: 16, color: AppColors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
          ),
          child: const Text('Search', style: TextStyle(fontSize: 11)),
        ),
        if (_tabIndex == 0) ...[
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, '/author/create-course'),
            icon: const Icon(Icons.add, size: 14),
            label: const Text('New Course', style: TextStyle(fontSize: 11)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 0,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFilters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildFilterDropdown('Business Segment'),
        _buildFilterDropdown('Department'),
        _buildFilterDropdown('Client'),
        _buildFilterDropdown('Program'),
      ],
    );
  }

  Widget _buildFilterDropdown(String label) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down,
              size: 14, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _buildDateRange() {
    return Row(
      children: [
        _buildDateField('From'),
        const SizedBox(width: 10),
        _buildDateField('To'),
      ],
    );
  }

  Widget _buildDateField(String label) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
          const SizedBox(width: 8),
          const Icon(Icons.calendar_today,
              size: 12, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _buildViewToggle() {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () => setState(() => _isCardView = false),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: !_isCardView
                  ? AppColors.primaryBlue.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.table_rows_outlined,
                size: 16,
                color: !_isCardView
                    ? AppColors.primaryBlue
                    : AppColors.textGrey),
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => setState(() => _isCardView = true),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _isCardView
                  ? AppColors.primaryBlue.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.grid_view,
                size: 16,
                color:
                    _isCardView ? AppColors.primaryBlue : AppColors.textGrey),
          ),
        ),
      ],
    );
  }

  // ─── Courses Table ───

  Widget _buildCoursesTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                SizedBox(width: 30, child: Text('', style: TextStyle(fontSize: 9))),
                SizedBox(width: 30, child: Text('Sno', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 80, child: Text('Date', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                Expanded(child: Text('Course Name', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 70, child: Text('Request Type', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 70, child: Text('Status', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 40, child: Text('Action', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderGrey),
          // Rows
          ...List.generate(_courses.length, (i) => _buildCourseRow(i)),
        ],
      ),
    );
  }

  Widget _buildCourseRow(int index) {
    final c = _courses[index];
    final isExpanded = _expandedCourseRows.contains(index);

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() {
            if (isExpanded) {
              _expandedCourseRows.remove(index);
            } else {
              _expandedCourseRows.add(index);
            }
          }),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    size: 14,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(
                    width: 30,
                    child: Text('${index + 1}',
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textDark))),
                SizedBox(
                    width: 80,
                    child: Text(c.date,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textDark))),
                Expanded(
                    child: Text(c.name,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textDark))),
                SizedBox(
                  width: 70,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: c.requestType == 'Request'
                          ? AppColors.primaryBlue.withValues(alpha: 0.1)
                          : AppColors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(c.requestType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9,
                            color: c.requestType == 'Request'
                                ? AppColors.primaryBlue
                                : AppColors.green,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(width: 70, child: _buildStatusBadge(c.status)),
                SizedBox(
                  width: 40,
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert,
                        size: 14, color: AppColors.textGrey),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit', style: TextStyle(fontSize: 11))),
                      const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(fontSize: 11))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) _buildCourseExpansion(c),
        const Divider(height: 1, color: AppColors.borderGrey),
      ],
    );
  }

  Widget _buildCourseExpansion(_CourseRow c) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow('Created Date', c.date),
          _detailRow('Last Update', c.date),
          _detailRow('Creation Type', 'New'),
          _detailRow('Request Type', c.requestType),
          _detailRow('Reason', 'Course requirement for new batch'),
          _detailRow('Role', 'Author'),
          _detailRow('Requestor Name', 'Admin User'),
          _detailRow('Course Name', c.name),
          _detailRow('Course Description',
              'A comprehensive course covering fundamentals and advanced topics.'),
          _detailRow('Suggestion', 'Include practical exercises'),
          _detailRow('Business Segment', 'Technology'),
          _detailRow('Department', 'Engineering'),
          _detailRow('Client', 'Internal'),
          _detailRow('Program', 'Q1 Training'),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatusBadge(c.status),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 14, color: AppColors.primaryBlue),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, size: 14, color: AppColors.red),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text('$label:',
                style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 9, color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  // ─── Card View ───

  Widget _buildCardView() {
    final colors = [
      const Color(0xFF42A5F5),
      const Color(0xFF66BB6A),
      const Color(0xFFEF5350),
      const Color(0xFFAB47BC),
      const Color(0xFFFFA726),
      const Color(0xFF26C6DA),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(_courses.length, (i) {
        final c = _courses[i];
        final color = colors[i % colors.length];
        return Container(
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderGrey),
            boxShadow: const [
              BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 1)),
            ],
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
                      color.withValues(alpha: 0.25),
                      color.withValues(alpha: 0.08),
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: _CardIllustrationPainter(color),
                  child: Center(
                    child: Icon(Icons.menu_book, size: 24,
                        color: color.withValues(alpha: 0.6)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(c.date,
                        style: const TextStyle(
                            fontSize: 9, color: AppColors.textGrey)),
                    const SizedBox(height: 6),
                    _buildStatusBadge(c.status),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ─── Requests Table ───

  Widget _buildRequestsTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                SizedBox(width: 30, child: Text('', style: TextStyle(fontSize: 9))),
                SizedBox(width: 80, child: Text('Date', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 100, child: Text('Requester Name', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 60, child: Text('Role', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 60, child: Text('Request Type', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                Expanded(child: Text('Reason', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 70, child: Text('Status', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
                SizedBox(width: 40, child: Text('Action', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderGrey),
          ...List.generate(_requests.length, (i) => _buildRequestRow(i)),
        ],
      ),
    );
  }

  Widget _buildRequestRow(int index) {
    final r = _requests[index];
    final isExpanded = _expandedRequestRows.contains(index);

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() {
            if (isExpanded) {
              _expandedRequestRows.remove(index);
            } else {
              _expandedRequestRows.add(index);
            }
          }),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    size: 14,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(
                    width: 80,
                    child: Text(r.date,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textDark))),
                SizedBox(
                    width: 100,
                    child: Text(r.requesterName,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textDark))),
                SizedBox(
                    width: 60,
                    child: Text(r.role,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textDark))),
                SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: r.requestType == 'New'
                              ? AppColors.primaryBlue
                              : AppColors.green,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(r.requestType,
                          style: const TextStyle(
                              fontSize: 9, color: AppColors.textDark)),
                    ],
                  ),
                ),
                Expanded(
                    child: Text(r.reason,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textDark),
                        overflow: TextOverflow.ellipsis)),
                SizedBox(width: 70, child: _buildStatusBadge(r.status)),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit,
                        size: 14, color: AppColors.primaryBlue),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) _buildRequestExpansion(r),
        const Divider(height: 1, color: AppColors.borderGrey),
      ],
    );
  }

  Widget _buildRequestExpansion(_RequestRow r) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow('Date', r.date),
          _detailRow('Requester Name', r.requesterName),
          _detailRow('Role', r.role),
          _detailRow('Request Type', r.requestType),
          _detailRow('Reason', r.reason),
          _detailRow('Status', r.status),
          _detailRow('Course Name', 'Related Course Name'),
          _detailRow('Course Description',
              'Detailed description of the request and course requirements.'),
          _detailRow('Business Segment', 'Technology'),
          _detailRow('Department', 'Engineering'),
          _detailRow('Client', 'Internal'),
          _detailRow('Program', 'Q1 Training'),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatusBadge(r.status),
              const Spacer(),
              _actionIcon(Icons.check_circle, AppColors.green, () {
                showDialog(
                  context: context,
                  builder: (_) => _acceptDialog(),
                );
              }),
              const SizedBox(width: 8),
              _actionIcon(Icons.cancel, AppColors.red, () {
                showDialog(
                  context: context,
                  builder: (_) => _rejectDialog(),
                );
              }),
              const SizedBox(width: 8),
              _actionIcon(Icons.chat, AppColors.primaryBlue, () {
                showDialog(
                  context: context,
                  builder: (_) => _discussionDialog(),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Icon(icon, size: 18, color: color),
    );
  }

  // Inline accept dialog
  Widget _acceptDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Accept Request',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.green)),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Do you want to be redirected to the course to submit course first?',
              style: TextStyle(fontSize: 11, color: AppColors.textDark)),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontSize: 11))),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: const Text('No', style: TextStyle(fontSize: 11)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: const Text('Yes', style: TextStyle(fontSize: 11)),
        ),
      ],
    );
  }

  // Inline reject dialog
  Widget _rejectDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Reject Request',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.red)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reason for rejection?',
              style: TextStyle(fontSize: 11, color: AppColors.textDark)),
          const SizedBox(height: 8),
          TextField(
            maxLines: 3,
            style: const TextStyle(fontSize: 11),
            decoration: InputDecoration(
              hintText: 'Enter reason...',
              hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.all(8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontSize: 11))),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: const Text('Save', style: TextStyle(fontSize: 11)),
        ),
      ],
    );
  }

  // Inline discussion dialog
  Widget _discussionDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 340,
        height: 400,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Text('R', style: TextStyle(fontSize: 11, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 8),
                  const Text('Rahul Sharma', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Trainee', style: TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert, size: 16, color: Colors.white),
                ],
              ),
            ),
            // Messages
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  const Center(
                    child: Text('Today', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                  ),
                  const SizedBox(height: 8),
                  _chatBubble('omg, this is amazing', false),
                  _chatBubble('perfect', false),
                  _chatBubble("I'll be there in 2 mins", true),
                  _chatBubble('Wow, this is really epic', false),
                  _chatBubble('just ideas for next time', true),
                ],
              ),
            ),
            // Quick replies
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 6,
                children: ['Awesome', 'really all good', 'Good that\'s working']
                    .map((t) => Chip(
                          label: Text(t, style: const TextStyle(fontSize: 9)),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: AppColors.background,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 6),
            // Input
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: TextField(
                        style: const TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: AppColors.borderGrey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: AppColors.borderGrey)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, size: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatBubble(String text, bool isSent) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 220),
        decoration: BoxDecoration(
          color: isSent ? AppColors.primaryBlue : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 10,
                color: isSent ? Colors.white : AppColors.textDark)),
      ),
    );
  }

  // ─── Common ───

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'New':
        color = const Color(0xFF2196F3);
        break;
      case 'Approved':
        color = const Color(0xFF4CAF50);
        break;
      case 'Rejected':
        color = const Color(0xFFE53935);
        break;
      case 'Complete':
        color = const Color(0xFF4CAF50);
        break;
      case 'Draft':
        color = const Color(0xFF9E9E9E);
        break;
      default:
        color = const Color(0xFF9E9E9E);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 9, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          _tabIndex == 0
              ? '1-${_courses.length} of ${_courses.length}'
              : '1-${_requests.length} of ${_requests.length}',
          style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left, size: 16),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: AppColors.textGrey,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_right, size: 16),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: AppColors.textGrey,
        ),
      ],
    );
  }
}

class _CardIllustrationPainter extends CustomPainter {
  final Color color;
  _CardIllustrationPainter(this.color);

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

class _CourseRow {
  final String date;
  final String name;
  final String requestType;
  final String status;
  const _CourseRow(this.date, this.name, this.requestType, this.status);
}

class _RequestRow {
  final String date;
  final String requesterName;
  final String role;
  final String requestType;
  final String reason;
  final String status;
  const _RequestRow(this.date, this.requesterName, this.role,
      this.requestType, this.reason, this.status);
}
