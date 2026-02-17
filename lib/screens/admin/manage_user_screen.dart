import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/expandable_table_row.dart';
import '../../widgets/edit_access_dialog.dart';

class ManageUserScreen extends StatefulWidget {
  final VoidCallback? onUserTap;

  const ManageUserScreen({super.key, this.onUserTap});

  @override
  State<ManageUserScreen> createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(context),
          const SizedBox(height: 12),
          _buildUserTable(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180, height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 14),
                  prefixIconConstraints: const BoxConstraints(minWidth: 30),
                  hintText: 'Search ...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/create-user'),
              icon: const Icon(Icons.add, size: 12),
              label: const Text('Create', style: TextStyle(fontSize: 10)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(children: [
          _buildFilterChip('Business Segment'),
          _buildFilterChip('Department'),
          _buildFilterChip('Client'),
          _buildFilterChip('Program'),
        ]),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
        ]),
      ),
    );
  }

  Widget _buildUserTable() {
    final users = [
      ['Shrey', 'Saraki', '21', 'Active', 'T'],
      ['Clement', 'Pinto', '07', 'Inactive', 'T'],
      ['Monishka', 'Mangnani', '23', 'Active', 'T'],
      ['Vimla', 'Doliya', '21', 'Active', 'R'],
      ['Lavesh', 'Paryani', '16', 'Inactive', 'T'],
      ['Piyush', 'Notani', '14', 'Active', 'T'],
      ['Dimple', 'Didwani', '11', 'Inactive', 'T'],
      ['Jitisha', 'Sabani', '16', 'Active', 'T'],
      ['Anil', 'Nayak', '21', 'Active', 'R'],
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(children: [
              _headerCell('Select', 40), _headerCell('First Name', 80), _headerCell('Last Name', 80), _headerCell('Courses Assign', 70), _headerCell('Status', 60), _headerCell('Access Type', 70), _headerCell('Actions', 50),
            ]),
          ),
          ...users.map((u) => ExpandableTableRow(
            header: GestureDetector(
              onTap: widget.onUserTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(children: [
                  SizedBox(width: 40, child: Checkbox(value: false, onChanged: (_) {}, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                  _dataCell(u[0], 80),
                  _dataCell(u[1], 80),
                  _dataCell(u[2], 70),
                  SizedBox(width: 60, child: _statusBadge(u[3])),
                  SizedBox(width: 70, child: Row(children: _buildAccessDots(u[4]))),
                  SizedBox(width: 50, child: Row(children: [
                    InkWell(onTap: widget.onUserTap, child: const Icon(Icons.visibility, size: 14, color: AppColors.primaryBlue)),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () => _showRoleAssignmentDialog(context, '${u[0]} ${u[1]}'),
                      child: const Icon(Icons.admin_panel_settings, size: 14, color: AppColors.amber),
                    ),
                  ])),
                ]),
              ),
            ),
            expandedContent: _buildExpandedUserCourses(u),
          )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              const Text('1-9  of  9', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
              const Spacer(),
              const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
              const Text('1/1', style: TextStyle(fontSize: 9)),
              const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedUserCourses(List<String> u) {
    final userName = '${u[0]} ${u[1]}';
    final courseRows = [
      ['Beginner Guide to Frontend Dev', 'Completed', 'Achiever', '12-01-2025', 'Trainee', 'Shital Patil'],
      ['UI/UX Designs for Beginners', 'Ongoing', 'Pending', '05-03-2025', 'Trainee', 'Ankit Pandey'],
      ['NLP with AI', 'Not Started', 'Aspirant', '20-06-2025', 'Trainer', 'Rachana Singh'],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Course Assignments - $userName', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const Spacer(),
            SizedBox(
              height: 24,
              child: ElevatedButton(
                onPressed: () => showEditAccessDialog(context, userName),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 8), elevation: 0),
                child: const Text('Edit Access', style: TextStyle(fontSize: 8)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Mini table header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
          child: Row(children: [
            _miniHdr('Course Name', 3),
            _miniHdr('Status', 1),
            _miniHdr('Outcome', 1),
            _miniHdr('Date', 1),
            _miniHdr('Access Type', 1),
            _miniHdr('Assigner', 2),
            _miniHdr('Actions', 1),
          ]),
        ),
        ...courseRows.map((c) => Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
          child: Row(children: [
            Expanded(flex: 3, child: Text(c[0], style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
            Expanded(flex: 1, child: _miniStatusBadge(c[1])),
            Expanded(flex: 1, child: Text(c[2], style: const TextStyle(fontSize: 8, color: AppColors.primaryBlue))),
            Expanded(flex: 1, child: Text(c[3], style: const TextStyle(fontSize: 8, color: AppColors.textGrey))),
            Expanded(flex: 1, child: Text(c[4], style: const TextStyle(fontSize: 8, color: AppColors.textGrey))),
            Expanded(flex: 2, child: Text(c[5], style: const TextStyle(fontSize: 8, color: AppColors.textGrey))),
            Expanded(flex: 1, child: InkWell(onTap: () {}, child: const Icon(Icons.visibility, size: 12, color: AppColors.primaryBlue))),
          ]),
        )),
      ],
    );
  }

  Widget _miniHdr(String text, int flex) => Expanded(flex: flex, child: Text(text, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.textGrey)));

  Widget _miniStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Completed': color = AppColors.green; break;
      case 'Ongoing': color = AppColors.orange; break;
      default: color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
      child: Text(status, style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.w500)),
    );
  }

  void _showRoleAssignmentDialog(BuildContext context, String userName) {
    showDialog(
      context: context,
      builder: (_) => _RoleAssignmentDialog(userName: userName),
    );
  }

  Widget _headerCell(String text, double width) {
    return SizedBox(width: width, child: Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey)));
  }

  Widget _dataCell(String text, double width) {
    return SizedBox(width: width, child: Text(text, style: const TextStyle(fontSize: 10, color: AppColors.textDark)));
  }

  Widget _statusBadge(String status) {
    final isActive = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: (isActive ? AppColors.green : AppColors.red).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: TextStyle(fontSize: 8, color: isActive ? AppColors.green : AppColors.red, fontWeight: FontWeight.w500)),
    );
  }

  List<Widget> _buildAccessDots(String type) {
    final colors = {'T': AppColors.primaryBlue, 'A': AppColors.amber, 'PM': AppColors.red, 'R': AppColors.green};
    return type.split('').map((t) {
      return Container(
        margin: const EdgeInsets.only(right: 3), width: 14, height: 14,
        decoration: BoxDecoration(color: colors[t] ?? AppColors.primaryBlue, shape: BoxShape.circle),
        child: Center(child: Text(t, style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold))),
      );
    }).toList();
  }
}

class _RoleAssignmentDialog extends StatefulWidget {
  final String userName;
  const _RoleAssignmentDialog({required this.userName});

  @override
  State<_RoleAssignmentDialog> createState() => _RoleAssignmentDialogState();
}

class _RoleAssignmentDialogState extends State<_RoleAssignmentDialog> {
  final Map<String, bool> _roles = {
    'Program Manager': false,
    'Admin': false,
    'Author': false,
    'Guest': false,
    'Trainee': true,
    'Trainer': false,
    'Guest Trainer': false,
  };

  static const Map<String, Color> _roleColors = {
    'Program Manager': AppColors.red,
    'Admin': AppColors.primaryBlue,
    'Author': AppColors.amber,
    'Guest': AppColors.grey,
    'Trainee': AppColors.green,
    'Trainer': AppColors.primaryBlue,
    'Guest Trainer': AppColors.orange,
  };

  bool _success = false;

  @override
  Widget build(BuildContext context) {
    if (_success) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: AppColors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.thumb_up, color: AppColors.green, size: 24),
              ),
              const SizedBox(height: 12),
              const Text('Access Provided Successfully', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.green)),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), elevation: 0),
                child: const Text('OK', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Assign Role', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 4),
            Text(widget.userName, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
            const SizedBox(height: 12),
            ..._roles.entries.map((entry) {
              final color = _roleColors[entry.key] ?? AppColors.primaryBlue;
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20, height: 20,
                      child: Checkbox(
                        value: entry.value,
                        onChanged: (v) => setState(() => _roles[entry.key] = v ?? false),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(entry.key, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _success = true),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                  child: const Text('Assign', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
