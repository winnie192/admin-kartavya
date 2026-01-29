import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ManageUserScreen extends StatelessWidget {
  final VoidCallback? onUserTap;

  const ManageUserScreen({super.key, this.onUserTap});

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
              onPressed: () {
                Navigator.pushNamed(context, '/create-user');
              },
              icon: const Icon(Icons.add, size: 12),
              label: const Text('Create', style: TextStyle(fontSize: 10)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Filter chips row
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
                _headerCell('Select', 40),
                _headerCell('First Name', 80),
                _headerCell('Last Name', 80),
                _headerCell('Courses Assign', 70),
                _headerCell('Status', 60),
                _headerCell('Access Type', 70),
                _headerCell('Actions', 50),
              ],
            ),
          ),
          // Rows
          ...users.map((u) => GestureDetector(
                onTap: onUserTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Checkbox(
                          value: false,
                          onChanged: (_) {},
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      _dataCell(u[0], 80),
                      _dataCell(u[1], 80),
                      _dataCell(u[2], 70),
                      SizedBox(
                        width: 60,
                        child: _statusBadge(u[3]),
                      ),
                      SizedBox(
                        width: 70,
                        child: Row(
                          children: _buildAccessDots(u[4]),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: onUserTap,
                              child: const Icon(Icons.visibility, size: 14, color: AppColors.primaryBlue),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          // Pagination
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text('1-6  of  1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
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

  Widget _headerCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: AppColors.textGrey,
        ),
      ),
    );
  }

  Widget _dataCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(text, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
    );
  }

  Widget _statusBadge(String status) {
    final isActive = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? AppColors.green.withValues(alpha: 0.1) : AppColors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 8,
          color: isActive ? AppColors.green : AppColors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> _buildAccessDots(String type) {
    final colors = {
      'T': AppColors.primaryBlue,
      'A': AppColors.amber,
      'PM': AppColors.red,
      'R': AppColors.green,
    };
    return type.split('').map((t) {
      return Container(
        margin: const EdgeInsets.only(right: 3),
        width: 14, height: 14,
        decoration: BoxDecoration(
          color: colors[t] ?? AppColors.primaryBlue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(t, style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    }).toList();
  }
}
