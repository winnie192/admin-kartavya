import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ManageGuestScreen extends StatelessWidget {
  final VoidCallback? onGuestTap;

  const ManageGuestScreen({super.key, this.onGuestTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(context),
          const SizedBox(height: 12),
          _buildGuestTable(),
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
            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0), child: const Text('Search', style: TextStyle(fontSize: 10))),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {
              Navigator.pushNamed(context, '/create-guest');
            }, icon: const Icon(Icons.person_add, size: 12), label: const Text('Add Guest', style: TextStyle(fontSize: 10)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: ['Business Segment', 'Department', 'Client', 'Program'].map((l) => _buildFilterChip(l)).toList(),
        ),
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

  Widget _buildGuestTable() {
    final guests = [
      ['Shrey', 'Saraki', '02', 'Active', 'Shital Patil'],
      ['Pratik', 'Indulkar', '11', 'Active', 'Ganesh AnandRaj'],
      ['Prasant', 'Dihge', '32', 'Active', 'Balvijay Gunaraj'],
      ['Zohra', 'Sawant', '12', 'Inactive', 'Divya Shetty'],
      ['Niloy', 'Deb', '09', 'Active', 'Om Auti'],
      ['Anil', 'Verma', '39', 'Inactive', 'Ankit Dharmnath Pandey'],
      ['Ashish', 'Singh', '41', 'Inactive', 'Kaushal Shetty'],
      ['Shetla', 'Shah', '04', 'Active', 'Anita Chorotiya'],
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(children: [
              _hdr('Select', 35), _hdr('First Name', 70), _hdr('Last Name', 70), _hdr('Courses Assign', 60), _hdr('Status', 55), _hdr('Access Type', 55), _hdr('Creator', 100), _hdr('Action', 40),
            ]),
          ),
          ...guests.map((g) => GestureDetector(
            onTap: onGuestTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
              child: Row(children: [
                SizedBox(width: 35, child: Checkbox(value: false, onChanged: (_) {}, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                SizedBox(width: 70, child: Text(g[0], style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                SizedBox(width: 70, child: Text(g[1], style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                SizedBox(width: 60, child: Text(g[2], style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                SizedBox(width: 55, child: _statusBadge(g[3])),
                SizedBox(width: 55, child: _accessDot('T')),
                SizedBox(width: 100, child: Text(g[4], style: const TextStyle(fontSize: 9, color: AppColors.textGrey), overflow: TextOverflow.ellipsis)),
                SizedBox(width: 40, child: Row(children: [
                  const Icon(Icons.visibility, size: 13, color: AppColors.primaryBlue),
                  const SizedBox(width: 4),
                  const Icon(Icons.more_vert, size: 13, color: AppColors.textGrey),
                ])),
              ]),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              const Text('1-6  of  1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
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

  Widget _hdr(String text, double width) => SizedBox(width: width, child: Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey)));

  Widget _statusBadge(String status) {
    final isActive = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: (isActive ? AppColors.green : AppColors.red).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: TextStyle(fontSize: 8, color: isActive ? AppColors.green : AppColors.red, fontWeight: FontWeight.w500)),
    );
  }

  Widget _accessDot(String t) {
    return Container(width: 14, height: 14, decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle), child: Center(child: Text(t, style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold))));
  }
}
