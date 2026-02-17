import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/expandable_table_row.dart';
import '../../widgets/edit_access_dialog.dart';
import 'pm_add_user_dialog.dart';
import 'pm_send_invites_dialog.dart';

class PmManageLmsScreen extends StatefulWidget {
  final ValueChanged<String>? onUserTap;

  const PmManageLmsScreen({super.key, this.onUserTap});

  @override
  State<PmManageLmsScreen> createState() => _PmManageLmsScreenState();
}

class _PmManageLmsScreenState extends State<PmManageLmsScreen> {
  int _activeTabIndex = 0;

  final List<String> _subTabs = const [
    'Manage Course',
    'Role Management',
    'Manage Guest',
    'Trainee Progress',
    'Calendar',
    'Expert Pool',
    'Survey',
    'Exams',
  ];

  // ── Course data ──
  final List<_CourseData> _courses = const [
    _CourseData('UI/UX for beginner', '12hrs:32m', 'Shital Patil', 'New', 0),
    _CourseData('UI/UX for beginner with Gen AI (Get Ready For Future)', '02hrs:02m', 'Balvijay Gunaraj', 'Rework', 0),
    _CourseData('Fundamentals of ReactJS with G', '23hrs:38m', 'Ganesh Anandraj', 'Rejected', 0),
    _CourseData('Pharmaceutical medicine healthcar', '09hrs:52m', 'Divya Shetty', 'Published', 105),
    _CourseData('UI/UX for beginner with Gen AI (Ge', '42hrs:18m', 'Vimla Doliya', 'Inactive', 0),
    _CourseData('Fundamentals of ReactJS with Gen AI', '23hrs:38m', 'Ganesh Anandraj', 'Approved', 0),
    _CourseData('UI/UX for beginner with Gen AI (Get Ready For Future)', '62hrs:02m', 'Prajisha Jitesh', 'Under Review', 0),
    _CourseData('UI/UX for beginner', '12hrs:46m', 'Reetu Kudia', 'WIP', 0),
    _CourseData('Fundamentals of ReactJS with Gen AI', '02hrs:02m', 'Bhavika Jain', 'Reviewing', 0),
    _CourseData('UI/UX for beginner with Gen AI (Get Ready For Future)', '06hrs:02m', 'Om Padalkar', 'Forwarded', 0),
  ];

  // ── Role Management user data ──
  final List<_UserData> _roleUsers = const [
    _UserData('Monika', 'Verma', 'KH3247', 'IT Manager', 'IT', 'Active', ['T']),
    _UserData('Rahul', 'Gupta', 'KH1734', 'Admin staff', 'Admin', 'Inactive', ['T']),
    _UserData('Ankit', 'Pandey', 'KH6235', 'Finance team lead', 'Finance', 'Active', ['T']),
    _UserData('Priti', 'Shinde', 'KH5252', 'Marketing Manager', 'Marketing', 'Inactive', ['T', 'A']),
    _UserData('Rachana', 'Singh', 'KH6364', 'Training Department', 'Training', 'Active', ['T']),
    _UserData('Om', 'Padalkar', 'KH0733', 'Engineering Manager', 'Engineering', 'Active', ['T']),
    _UserData('Selva', 'Ganesh', 'KH8352', 'Camps team lead', 'Camps', 'Active', ['T', 'T', 'A']),
    _UserData('Sanjivani', 'Kokare', 'KH0915', 'DataBase Head', 'IT', 'Active', ['T', 'T']),
    _UserData('Anshuman', 'Shah', 'KH0733', 'Engineering Manager', 'Engineering', 'Active', ['T']),
    _UserData('Divya', 'Shetty', 'KH8352', 'System Admin', 'IT', 'Active', ['T', 'T', 'A']),
  ];

  // ── Manage Guest user data ──
  final List<_GuestData> _guests = const [
    _GuestData('Rahul', 'Gupta', '9653441131', 'Rahul@gmail.com', 'Inactive', ['T']),
    _GuestData('Ankit', 'Pandey', '8267676564', 'ap@gmail.com', 'Active', ['T']),
    _GuestData('Priti', 'Shinde', '7696235665', 'pshinde@gmail.com', 'Inactive', ['T', 'A']),
    _GuestData('Rachana', 'Singh', '9625676724', 'Rsinghl@gmail.com', 'Active', ['T']),
    _GuestData('Om', 'Padalkar', '8955235626', 'om@gmail.com', 'Active', ['T']),
    _GuestData('Selva', 'Ganesh', '9626552653', 'selvaganesh@gmail.com', 'Active', ['T', 'T', 'A']),
    _GuestData('Sanjivani', 'Kokare', '9923425556', 'sanjivani.k@gmail.com', 'Active', ['T', 'T']),
  ];

  // ── Trainee Progress data ──
  final List<_TraineeData> _trainees = const [
    _TraineeData('Om', 'Padalkar', 3, 180, 119),
    _TraineeData('Pratik', 'Indulkar', 23, 130, 93),
    _TraineeData('Divya', 'Shetty', 3, 130, 126),
    _TraineeData('Ankit', 'Pandey', 3, 130, 116),
    _TraineeData('Rachana', 'Singh', 12, 150, 139),
    _TraineeData('Siddhi', 'Auti', 31, 150, 97),
    _TraineeData('Priti', 'Shinde', 16, 150, 79),
    _TraineeData('Karan', 'Singh', 9, 180, 91),
    _TraineeData('Piyush', 'Roy', 11, 180, 56),
  ];

  final Set<int> _selectedTrainees = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSubNavTabs(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _buildActiveTabContent(),
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════
  // SUB-NAVIGATION TABS
  // ════════════════════════════════════════════════════════

  Widget _buildSubNavTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_subTabs.length, (i) {
            final isActive = _activeTabIndex == i;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                onTap: () => setState(() => _activeTabIndex = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primaryBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isActive ? AppColors.primaryBlue : AppColors.borderGrey,
                    ),
                  ),
                  child: Text(
                    _subTabs[i],
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive ? Colors.white : AppColors.textGrey,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════
  // TAB CONTENT ROUTER
  // ════════════════════════════════════════════════════════

  Widget _buildActiveTabContent() {
    switch (_activeTabIndex) {
      case 0:
        return _buildManageCourseTab();
      case 1:
        return _buildRoleManagementTab();
      case 2:
        return _buildManageGuestTab();
      case 3:
        return _buildTraineeProgressTab();
      default:
        return _buildComingSoon();
    }
  }

  Widget _buildComingSoon() {
    return SizedBox(
      height: 300,
      child: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════
  //  TAB 0 : MANAGE COURSE
  // ════════════════════════════════════════════════════════

  Widget _buildManageCourseTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCourseTopBar(),
        const SizedBox(height: 8),
        _buildCourseSearchAndFilters(),
        const SizedBox(height: 12),
        _buildCourseTable(),
      ],
    );
  }

  Widget _buildCourseTopBar() {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 12),
          label: const Text('New Course', style: TextStyle(fontSize: 10)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 0,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 0,
          ),
          child: const Text('Rejected', style: TextStyle(fontSize: 10)),
        ),
      ],
    );
  }

  Widget _buildCourseSearchAndFilters() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180,
              height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 14),
                  prefixIconConstraints: const BoxConstraints(minWidth: 30),
                  hintText: 'Search ...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildFilterChip('Business Segment'),
            _buildFilterChip('Department'),
            _buildFilterChip('Client'),
            _buildFilterChip('Program'),
          ],
        ),
      ],
    );
  }

  Widget _buildCourseTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              children: [
                _headerCell('Course Name', flex: 4),
                _headerCell('Duration', flex: 2),
                _headerCell('Author Name', flex: 2),
                _headerCell('Status', flex: 2),
                _headerCell('Learners', flex: 1),
                _headerCell('Action', flex: 1),
              ],
            ),
          ),
          // Rows
          ..._courses.map((c) => Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    _dataCell(c.name, flex: 4),
                    _dataCell(c.duration, flex: 2),
                    _dataCell(c.author, flex: 2),
                    Expanded(flex: 2, child: _courseStatusBadge(c.status)),
                    _dataCell(c.learners.toString(), flex: 1),
                    Expanded(
                      flex: 1,
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'view', child: Text('View', style: TextStyle(fontSize: 10))),
                          PopupMenuItem(value: 'edit', child: Text('Edit', style: TextStyle(fontSize: 10))),
                          PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(fontSize: 10, color: AppColors.red))),
                        ],
                        onSelected: (_) {},
                      ),
                    ),
                  ],
                ),
              )),
          // Pagination
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  '1-${_courses.length}  of  ${_courses.length}',
                  style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
                ),
                const Spacer(),
                const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
                const Text('1/1', style: TextStyle(fontSize: 9)),
                const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _courseStatusBadge(String status) {
    final Color color;
    switch (status) {
      case 'New':
        color = AppColors.primaryBlue;
        break;
      case 'Rework':
        color = AppColors.amber;
        break;
      case 'Rejected':
        color = AppColors.red;
        break;
      case 'Published':
        color = AppColors.green;
        break;
      case 'Inactive':
        color = AppColors.grey;
        break;
      case 'Approved':
        color = AppColors.green;
        break;
      case 'Under Review':
        color = AppColors.amber;
        break;
      case 'WIP':
        color = AppColors.orange;
        break;
      case 'Reviewing':
        color = AppColors.primaryBlue;
        break;
      case 'Forwarded':
        color = const Color(0xFF009688);
        break;
      default:
        color = AppColors.grey;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          status,
          style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════
  //  TAB 1 : ROLE MANAGEMENT
  // ════════════════════════════════════════════════════════

  Widget _buildRoleManagementTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRoleSearchAndFilters(),
        const SizedBox(height: 12),
        _buildRoleUserTable(),
      ],
    );
  }

  Widget _buildRoleSearchAndFilters() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180,
              height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 14),
                  prefixIconConstraints: const BoxConstraints(minWidth: 30),
                  hintText: 'Search ...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildFilterChip('Business Segment'),
            _buildFilterChip('Department'),
            _buildFilterChip('Client'),
            _buildFilterChip('Program'),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleUserTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              children: [
                _headerCell('First Name', flex: 2),
                _headerCell('Last Name', flex: 2),
                _headerCell('Code', flex: 1),
                _headerCell('Designation', flex: 2),
                _headerCell('Department', flex: 2),
                _headerCell('Status', flex: 1),
                _headerCell('Access Type', flex: 1),
                _headerCell('Actions', flex: 1),
              ],
            ),
          ),
          ..._roleUsers.map((u) => ExpandableTableRow(
                header: GestureDetector(
                  onTap: () => widget.onUserTap?.call('${u.firstName} ${u.lastName}'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        _dataCell(u.firstName, flex: 2),
                        _dataCell(u.lastName, flex: 2),
                        _dataCell(u.code, flex: 1),
                        _dataCell(u.designation, flex: 2),
                        _dataCell(u.department, flex: 2),
                        Expanded(flex: 1, child: _userStatusBadge(u.status)),
                        Expanded(flex: 1, child: Row(children: _buildAccessDots(u.accessTypes))),
                        Expanded(flex: 1, child: _buildUserActionsMenu(u)),
                      ],
                    ),
                  ),
                ),
                expandedContent: _buildExpandedAccess(u),
              )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  '1-${_roleUsers.length}  of  ${_roleUsers.length}',
                  style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
                ),
                const Spacer(),
                const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
                const Text('1/1', style: TextStyle(fontSize: 9)),
                const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════
  //  TAB 2 : MANAGE GUEST
  // ════════════════════════════════════════════════════════

  Widget _buildManageGuestTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGuestSearchAndFilters(),
        const SizedBox(height: 12),
        _buildGuestTable(),
      ],
    );
  }

  Widget _buildGuestSearchAndFilters() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180,
              height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 14),
                  prefixIconConstraints: const BoxConstraints(minWidth: 30),
                  hintText: 'Search ...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => showPmAddUserDialog(context),
              icon: const Icon(Icons.add, size: 12),
              label: const Text('Add Guest', style: TextStyle(fontSize: 10)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildFilterChip('Business Segment'),
            _buildFilterChip('Department'),
            _buildFilterChip('Client'),
            _buildFilterChip('Program'),
          ],
        ),
      ],
    );
  }

  Widget _buildGuestTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              children: [
                _headerCell('First Name', flex: 2),
                _headerCell('Last Name', flex: 2),
                _headerCell('Mobile Number', flex: 2),
                _headerCell('Email ID', flex: 3),
                _headerCell('Status', flex: 1),
                _headerCell('Access Type', flex: 1),
                _headerCell('Actions', flex: 1),
              ],
            ),
          ),
          ..._guests.map((g) => ExpandableTableRow(
                header: GestureDetector(
                  onTap: () => widget.onUserTap?.call('${g.firstName} ${g.lastName}'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        _dataCell(g.firstName, flex: 2),
                        _dataCell(g.lastName, flex: 2),
                        _dataCell(g.mobile, flex: 2),
                        _dataCell(g.email, flex: 3),
                        Expanded(flex: 1, child: _userStatusBadge(g.status)),
                        Expanded(flex: 1, child: Row(children: _buildAccessDots(g.accessTypes))),
                        Expanded(flex: 1, child: _buildGuestActionsMenu(g)),
                      ],
                    ),
                  ),
                ),
                expandedContent: _buildExpandedGuestAccess(g),
              )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  '1-${_guests.length}  of  ${_guests.length}',
                  style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
                ),
                const Spacer(),
                const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
                const Text('1/1', style: TextStyle(fontSize: 9)),
                const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════
  //  TAB 3 : TRAINEE PROGRESS
  // ════════════════════════════════════════════════════════

  Widget _buildTraineeProgressTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTraineeSearchAndFilters(),
        const SizedBox(height: 12),
        _buildTraineeTable(),
      ],
    );
  }

  Widget _buildTraineeSearchAndFilters() {
    return Row(
      children: [
        SizedBox(
          width: 180,
          height: 30,
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, size: 14),
              prefixIconConstraints: const BoxConstraints(minWidth: 30),
              hintText: 'Search ...',
              hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.amber,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 0,
          ),
          child: const Text('Search', style: TextStyle(fontSize: 10)),
        ),
      ],
    );
  }

  Widget _buildTraineeTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              children: [
                // Select all checkbox header
                SizedBox(
                  width: 30,
                  child: Checkbox(
                    value: _selectedTrainees.length == _trainees.length && _trainees.isNotEmpty,
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          _selectedTrainees.addAll(List.generate(_trainees.length, (i) => i));
                        } else {
                          _selectedTrainees.clear();
                        }
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const SizedBox(width: 4),
                // Expand placeholder header
                const SizedBox(width: 24),
                _headerCell('First Name', flex: 2),
                _headerCell('Last Name', flex: 2),
                _headerCell('Courses Assign', flex: 2),
                _headerCell('Hours Assign', flex: 2),
                _headerCell('Hours Completed', flex: 2),
                _headerCell('Profile', flex: 1),
              ],
            ),
          ),
          // Rows
          ...List.generate(_trainees.length, (i) {
            final t = _trainees[i];
            return ExpandableTableRow(
              header: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Checkbox(
                        value: _selectedTrainees.contains(i),
                        onChanged: (v) {
                          setState(() {
                            if (v == true) {
                              _selectedTrainees.add(i);
                            } else {
                              _selectedTrainees.remove(i);
                            }
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Expand icon placeholder (handled by ExpandableTableRow)
                    const SizedBox(width: 24),
                    _dataCell(t.firstName, flex: 2),
                    _dataCell(t.lastName, flex: 2),
                    _dataCell(t.coursesAssign.toString().padLeft(2, '0'), flex: 2),
                    _dataCell(t.hoursAssign.toString(), flex: 2),
                    _dataCell(t.hoursCompleted.toString(), flex: 2),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => widget.onUserTap?.call('${t.firstName} ${t.lastName}'),
                        child: const Icon(Icons.visibility, size: 14, color: AppColors.primaryBlue),
                      ),
                    ),
                  ],
                ),
              ),
              expandedContent: _buildTraineeExpandedContent(t),
            );
          }),
          // Pagination
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  '1-${_trainees.length}  of  ${_trainees.length}',
                  style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
                ),
                const Spacer(),
                const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
                const Text('1/1', style: TextStyle(fontSize: 9)),
                const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraineeExpandedContent(_TraineeData t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Progress - ${t.firstName} ${t.lastName}',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _miniInfoCard('Courses Assigned', t.coursesAssign.toString().padLeft(2, '0')),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _miniInfoCard('Hours Assigned', '${t.hoursAssign}h'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _miniInfoCard('Hours Completed', '${t.hoursCompleted}h'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _miniInfoCard(
                'Completion',
                t.hoursAssign > 0
                    ? '${((t.hoursCompleted / t.hoursAssign) * 100).round()}%'
                    : '0%',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _miniInfoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════
  //  SHARED HELPERS
  // ════════════════════════════════════════════════════════

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderGrey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey),
      ),
    );
  }

  Widget _dataCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, color: AppColors.textDark),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _userStatusBadge(String status) {
    final isActive = status == 'Active';
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: (isActive ? AppColors.green : AppColors.grey).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 8,
            color: isActive ? AppColors.green : AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAccessDots(List<String> types) {
    const colors = {
      'T': AppColors.primaryBlue,
      'A': AppColors.amber,
      'TN': AppColors.green,
    };
    return types
        .map((t) => Container(
              margin: const EdgeInsets.only(right: 3),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: colors[t] ?? AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  t,
                  style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ))
        .toList();
  }

  // ── Role Management actions menu ──

  Widget _buildUserActionsMenu(_UserData u) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'view', child: Text('View Details', style: TextStyle(fontSize: 10))),
        const PopupMenuItem(value: 'edit_access', child: Text('Edit Access', style: TextStyle(fontSize: 10))),
        PopupMenuItem(
          value: 'pause',
          child: Text(u.status == 'Active' ? 'Pause' : 'Resume', style: const TextStyle(fontSize: 10)),
        ),
        PopupMenuItem(
          value: 'toggle_status',
          child: Text(u.status == 'Active' ? 'Inactive' : 'Active', style: const TextStyle(fontSize: 10)),
        ),
        const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(fontSize: 10, color: AppColors.red))),
        const PopupMenuItem(value: 'invite', child: Text('Send Invites', style: TextStyle(fontSize: 10))),
      ],
      onSelected: (v) {
        switch (v) {
          case 'view':
            widget.onUserTap?.call('${u.firstName} ${u.lastName}');
            break;
          case 'edit_access':
            showEditAccessDialog(context, '${u.firstName} ${u.lastName}');
            break;
          case 'invite':
            showPmSendInvitesDialog(context);
            break;
          case 'delete':
            _showDeleteConfirmation('${u.firstName} ${u.lastName}');
            break;
        }
      },
    );
  }

  // ── Guest actions menu ──

  Widget _buildGuestActionsMenu(_GuestData g) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'view', child: Text('View Details', style: TextStyle(fontSize: 10))),
        const PopupMenuItem(value: 'edit_access', child: Text('Edit Access', style: TextStyle(fontSize: 10))),
        PopupMenuItem(
          value: 'toggle_status',
          child: Text(g.status == 'Active' ? 'Inactive' : 'Active', style: const TextStyle(fontSize: 10)),
        ),
        const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(fontSize: 10, color: AppColors.red))),
        const PopupMenuItem(value: 'invite', child: Text('Send Invites', style: TextStyle(fontSize: 10))),
      ],
      onSelected: (v) {
        switch (v) {
          case 'view':
            widget.onUserTap?.call('${g.firstName} ${g.lastName}');
            break;
          case 'edit_access':
            showEditAccessDialog(context, '${g.firstName} ${g.lastName}');
            break;
          case 'invite':
            showPmSendInvitesDialog(context);
            break;
          case 'delete':
            _showDeleteConfirmation('${g.firstName} ${g.lastName}');
            break;
        }
      },
    );
  }

  // ── Delete confirmation dialog ──

  void _showDeleteConfirmation(String name) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 36, color: AppColors.red),
              const SizedBox(height: 10),
              const Text(
                'Are you sure you want to delete this user permanently?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.textDark),
              ),
              const SizedBox(height: 6),
              Text(
                name,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      elevation: 0,
                    ),
                    child: const Text('Yes', style: TextStyle(fontSize: 10)),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderGrey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                    child: const Text('No', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Expanded access content for Role Management users ──

  Widget _buildExpandedAccess(_UserData u) {
    final accessRows = [
      ['Cipla_new', 'Operations', 'cipla_new_abc', 'cipla_new_abc_222', 'Trainee'],
      ['Beta_segment', 'Development', 'beta_client', 'beta_program', 'Author'],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Access Programs - ${u.firstName} ${u.lastName}',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
          ),
          child: Row(
            children: [
              _miniHdr('Business Segment', 2),
              _miniHdr('Department', 2),
              _miniHdr('Client', 2),
              _miniHdr('Program', 2),
              _miniHdr('Access Type', 1),
              _miniHdr('Actions', 1),
            ],
          ),
        ),
        ...accessRows.map((a) => Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
              ),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(a[0], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 2, child: Text(a[1], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 2, child: Text(a[2], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 2, child: Text(a[3], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 1, child: Text(a[4], style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(Icons.edit, size: 12, color: AppColors.primaryBlue),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  // ── Expanded access content for Guest users ──

  Widget _buildExpandedGuestAccess(_GuestData g) {
    final accessRows = [
      ['Cipla_new', 'Operations', 'cipla_new_abc', 'cipla_new_abc_222', 'Trainee'],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Access Programs - ${g.firstName} ${g.lastName}',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
          ),
          child: Row(
            children: [
              _miniHdr('Business Segment', 2),
              _miniHdr('Department', 2),
              _miniHdr('Client', 2),
              _miniHdr('Program', 2),
              _miniHdr('Access Type', 1),
              _miniHdr('Actions', 1),
            ],
          ),
        ),
        ...accessRows.map((a) => Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
              ),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(a[0], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 2, child: Text(a[1], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 2, child: Text(a[2], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 2, child: Text(a[3], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                  Expanded(flex: 1, child: Text(a[4], style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(Icons.edit, size: 12, color: AppColors.primaryBlue),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _miniHdr(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.textGrey),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  DATA MODELS
// ════════════════════════════════════════════════════════

class _CourseData {
  final String name;
  final String duration;
  final String author;
  final String status;
  final int learners;

  const _CourseData(this.name, this.duration, this.author, this.status, this.learners);
}

class _UserData {
  final String firstName;
  final String lastName;
  final String code;
  final String designation;
  final String department;
  final String status;
  final List<String> accessTypes;

  const _UserData(this.firstName, this.lastName, this.code, this.designation, this.department, this.status, this.accessTypes);
}

class _GuestData {
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String status;
  final List<String> accessTypes;

  const _GuestData(this.firstName, this.lastName, this.mobile, this.email, this.status, this.accessTypes);
}

class _TraineeData {
  final String firstName;
  final String lastName;
  final int coursesAssign;
  final int hoursAssign;
  final int hoursCompleted;

  const _TraineeData(this.firstName, this.lastName, this.coursesAssign, this.hoursAssign, this.hoursCompleted);
}
