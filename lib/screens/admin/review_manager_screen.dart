import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ReviewManagerScreen extends StatelessWidget {
  const ReviewManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header
          _buildProfileHeader(),
          const SizedBox(height: 14),
          // Stats row
          _buildStatsRow(),
          const SizedBox(height: 14),
          // Filters
          _buildFilters(),
          const SizedBox(height: 12),
          // Table
          _buildTable(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.amber,
          child: const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ankit Dharmnath Pandey', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            Row(
              children: [
                const Text('Review Manager', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _statCard('Reviewed Courses', '131', AppColors.green),
        _statCard('New Courses', '03', AppColors.primaryBlue),
        _statCard('In Progress', '12', AppColors.orange),
        _statCard('Resubmitted', '12', AppColors.amber),
        _statCard('Pending', '03', AppColors.red),
      ],
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        _searchField(),
        const SizedBox(width: 8),
        _searchButton(),
        const Spacer(),
        ..._filterChips(),
      ],
    );
  }

  Widget _searchField() {
    return SizedBox(
      width: 180,
      height: 30,
      child: TextField(
        style: const TextStyle(fontSize: 10),
        decoration: InputDecoration(
          hintText: 'Search ... ',
          hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          prefixIcon: const Icon(Icons.search, size: 14, color: AppColors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
        ),
      ),
    );
  }

  Widget _searchButton() {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.amber,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          elevation: 0,
        ),
        child: const Text('Search', style: TextStyle(fontSize: 10)),
      ),
    );
  }

  List<Widget> _filterChips() {
    return ['Business Segment', 'Department', 'Client', 'Program'].map((f) {
      return Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(f, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTable() {
    final rows = [
      _ReviewRow('12-09-2023', '23-10-2023', 'MIT Introduction to Computer Science and Programmi', 'Divya Balakrishna Shetty', 'New', '_'),
      _ReviewRow('19-03-2025', '25-03-2025', 'UI/UX the begginer guide for the Non IT and Non Codi', 'Zohra Sawant', 'In Progress', 'Non Compliance'),
      _ReviewRow('12-09-2023', '10-09-2023', 'Software Testing - Manual Testing ,Automation Testi', 'Clement Pinto', 'Reviewed', 'Ok To Publish'),
      _ReviewRow('07-12-2024', '18-12-2024', 'Natural Language Processing (NLP) with AI', 'Rachana Dharmnath Singh', 'Pending', '_'),
      _ReviewRow('19-03-2025', '10-04-2025', 'UI/UX the begginer guide for the Non IT and Non Codi', 'Zohra Sawant', 'In Progress', 'Ok To Publish'),
      _ReviewRow('12-09-2023', '09-12-2023', 'MIT Introduction to Computer Science and Programmi', 'Divya Balakrishna Shetty', 'Resubmitted', '_'),
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
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: const [
                SizedBox(width: 30, child: Text('Info', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                SizedBox(width: 80, child: Text('Date', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                Expanded(flex: 3, child: Text('Course Name', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                Expanded(flex: 2, child: Text('Program Manager', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                SizedBox(width: 70, child: Text('Status', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                Expanded(flex: 2, child: Text('Classify Type', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                SizedBox(width: 40, child: Text('Action', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark))),
              ],
            ),
          ),
          ...rows.map((r) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                child: Row(
                  children: [
                    const SizedBox(width: 30, child: Icon(Icons.info_outline, size: 14, color: AppColors.textGrey)),
                    SizedBox(width: 80, child: Text(r.date, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(flex: 3, child: Text(r.courseName, style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
                    Expanded(flex: 2, child: Text(r.manager, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    SizedBox(width: 70, child: _statusBadge(r.status)),
                    Expanded(flex: 2, child: r.classifyType == '_' ? const Text('_', style: TextStyle(fontSize: 9, color: AppColors.textGrey)) : _classifyChips(r.classifyType)),
                    const SizedBox(width: 40, child: Icon(Icons.more_vert, size: 14, color: AppColors.textGrey)),
                  ],
                ),
              )),
          // Pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text('1/1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                SizedBox(width: 16),
                Text('1-6  of  1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                SizedBox(width: 8),
                Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
                Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'Reviewed':
        color = AppColors.green;
        break;
      case 'New':
        color = AppColors.primaryBlue;
        break;
      case 'In Progress':
        color = AppColors.orange;
        break;
      case 'Resubmitted':
        color = AppColors.amber;
        break;
      case 'Pending':
        color = AppColors.red;
        break;
      default:
        color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _classifyChips(String type) {
    final types = type.split('\n');
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: types.map((t) {
        Color c = AppColors.primaryBlue;
        if (t.contains('Non Compliance')) c = AppColors.red;
        if (t.contains('Unsolicited')) c = AppColors.amber;
        if (t.contains('Ok To Publish')) c = AppColors.green;
        if (t.contains('Patient')) c = AppColors.orange;
        if (t.contains('Other')) c = AppColors.grey;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(color: c.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
          child: Text(t.trim(), style: TextStyle(fontSize: 7, color: c)),
        );
      }).toList(),
    );
  }
}

class _ReviewRow {
  final String date, endDate, courseName, manager, status, classifyType;
  _ReviewRow(this.date, this.endDate, this.courseName, this.manager, this.status, this.classifyType);
}
