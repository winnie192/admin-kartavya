import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/expandable_table_row.dart';

class ManageGuestScreen extends StatefulWidget {
  final VoidCallback? onGuestTap;

  const ManageGuestScreen({super.key, this.onGuestTap});

  @override
  State<ManageGuestScreen> createState() => _ManageGuestScreenState();
}

class _ManageGuestScreenState extends State<ManageGuestScreen> {
  int _selectedGuestType = 0; // 0 = Internal, 1 = External

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(context),
          const SizedBox(height: 12),
          _buildGuestTypeTabs(),
          const SizedBox(height: 12),
          _buildGuestTable(),
        ],
      ),
    );
  }

  Widget _buildGuestTypeTabs() {
    return Row(
      children: [
        _guestTypeTab('Internal Guest', 0),
        const SizedBox(width: 6),
        _guestTypeTab('External Guest', 1),
      ],
    );
  }

  Widget _guestTypeTab(String label, int index) {
    final isActive = _selectedGuestType == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedGuestType = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
        ),
        child: Text(label, style: TextStyle(fontSize: 10, color: isActive ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.w500)),
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
            ElevatedButton.icon(onPressed: () => Navigator.pushNamed(context, '/create-guest'), icon: const Icon(Icons.person_add, size: 12), label: const Text('Add Guest', style: TextStyle(fontSize: 10)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0)),
          ],
        ),
        const SizedBox(height: 8),
        Row(children: ['Business Segment', 'Department', 'Client', 'Program'].map((l) => _buildFilterChip(l)).toList()),
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
    final guests = _selectedGuestType == 0
        ? [
            _GuestData('Shrey', 'Saraki', '02', 'Active', 'Shital Patil', 'Engineering', 'Software Dev', 'Acme Corp', '01-01-2025', '30-06-2025', '40'),
            _GuestData('Pratik', 'Indulkar', '11', 'Active', 'Ganesh AnandRaj', 'Design', 'UX Team', 'Beta Inc', '01-03-2025', '30-09-2025', '60'),
            _GuestData('Prasant', 'Dihge', '32', 'Active', 'Balvijay Gunaraj', 'QA', 'Testing', 'Delta Corp', '15-02-2025', '15-08-2025', '80'),
            _GuestData('Zohra', 'Sawant', '12', 'Inactive', 'Divya Shetty', 'AI/ML', 'Research', 'Gamma Ltd', '01-04-2025', '31-10-2025', '50'),
          ]
        : [
            _GuestData('Niloy', 'Deb', '09', 'Active', 'Om Auti', 'Education', 'CS Dept', 'MIT', '01-05-2025', '30-11-2025', '30'),
            _GuestData('Anil', 'Verma', '39', 'Inactive', 'Ankit Dharmnath Pandey', 'Engineering', 'Backend', 'Acme Corp', '01-01-2025', '30-06-2025', '45'),
            _GuestData('Ashish', 'Singh', '41', 'Inactive', 'Kaushal Shetty', 'Design', 'UI Team', 'Beta Inc', '01-06-2025', '31-12-2025', '55'),
            _GuestData('Shetla', 'Shah', '04', 'Active', 'Anita Chorotiya', 'QA', 'Automation', 'Delta Corp', '01-02-2025', '31-07-2025', '35'),
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
          ...guests.map((g) => ExpandableTableRow(
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(children: [
                SizedBox(width: 35, child: Checkbox(value: false, onChanged: (_) {}, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                SizedBox(width: 70, child: Text(g.firstName, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                SizedBox(width: 70, child: Text(g.lastName, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                SizedBox(width: 60, child: Text(g.coursesAssign, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                SizedBox(width: 55, child: _statusBadge(g.status)),
                SizedBox(width: 55, child: _accessDot('T')),
                SizedBox(width: 100, child: Text(g.creator, style: const TextStyle(fontSize: 9, color: AppColors.textGrey), overflow: TextOverflow.ellipsis)),
              ]),
            ),
            expandedContent: _buildExpandedGuest(g),
          )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              Text('1-${guests.length}  of  ${guests.length}', style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
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

  Widget _buildExpandedGuest(_GuestData g) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Guest Details', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 6, children: [
          _detailItem('First Name', g.firstName),
          _detailItem('Last Name', g.lastName),
          _detailItem('Business Segment', g.businessSegment),
          _detailItem('Department', g.department),
          _detailItem('Client', g.client),
          _detailItem('Creator', g.creator),
          _detailItem('Start Date', g.startDate),
          _detailItem('End Date', g.endDate),
          _detailItem('Hours Assigned', g.hoursAssigned),
          _detailItem('Courses Assigned', g.coursesAssign),
          _detailItem('Guest Type', _selectedGuestType == 0 ? 'Internal' : 'External'),
        ]),
        const SizedBox(height: 6),
        Row(children: [
          const Text('Status: ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          _statusBadge(g.status),
        ]),
      ],
    );
  }

  Widget _detailItem(String label, String value) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          const SizedBox(height: 1),
          Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
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

class _GuestData {
  final String firstName, lastName, coursesAssign, status, creator;
  final String businessSegment, department, client, startDate, endDate, hoursAssigned;
  _GuestData(this.firstName, this.lastName, this.coursesAssign, this.status, this.creator, this.businessSegment, this.department, this.client, this.startDate, this.endDate, this.hoursAssigned);
}
