import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class RequestReceivedScreen extends StatelessWidget {
  const RequestReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(),
          const SizedBox(height: 12),
          _buildRequestTable(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Row(
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
        ..._buildFilters(),
      ],
    );
  }

  List<Widget> _buildFilters() {
    return ['Business Segment', 'Department', 'Client', 'Program'].map((l) => Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(l, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
        ]),
      ),
    )).toList();
  }

  Widget _buildRequestTable() {
    final requests = [
      ['07-03-2024', 'Niloy Deb', 'Program Manager', 'Delete Course', 'Approved'],
      ['9-9-2025', 'Reetu Kulita', 'Program Manager', 'Guest Delete', 'Approved'],
      ['07-03-2024', 'Niloy Deb', 'Program Manager', 'Delete Course', 'Rejected'],
      ['15-04-2025', 'Shruti Shubham Patil', 'Program Manager', 'Guest Delete', 'New'],
      ['07-03-2024', 'Niloy Deb', 'Program Manager', 'Delete Course', 'Approved'],
      ['20-07-2025', 'Clement Pinto', 'Program Manager', 'Delete Course', 'Rejected'],
      ['07-03-2024', 'Niloy Deb', 'Program Manager', 'Delete Course', 'Approved'],
      ['20-07-2025', 'Clement Pinto', 'Program Manager', 'Delete Course', 'Rejected'],
      ['9-9-2025', 'Reetu Kulita', 'Program Manager', 'Guest Delete', 'Approved'],
      ['15-04-2025', 'Shruti Shubham Patil', 'Program Manager', 'Guest Delete', 'New'],
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(children: [
              _hdr('Info', 30), _hdr('Date', 70), _hdr('Requester Name', 110), _hdr('Role', 90), _hdr('Request Type', 80), _hdr('Status', 70), _hdr('Action', 40),
            ]),
          ),
          ...requests.map((r) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
            child: Row(children: [
              const SizedBox(width: 30, child: Icon(Icons.info_outline, size: 12, color: AppColors.textGrey)),
              SizedBox(width: 70, child: Text(r[0], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
              SizedBox(width: 110, child: Text(r[1], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
              SizedBox(width: 90, child: Text(r[2], style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
              SizedBox(width: 80, child: Row(children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: r[3].contains('Delete') ? AppColors.red : AppColors.amber, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Text(r[3], style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
              ])),
              SizedBox(width: 70, child: _statusBadge(r[4])),
              const SizedBox(width: 40, child: Icon(Icons.more_vert, size: 14, color: AppColors.textGrey)),
            ]),
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
    Color color;
    switch (status) {
      case 'Approved': color = AppColors.green; break;
      case 'Rejected': color = AppColors.red; break;
      case 'New': color = AppColors.primaryBlue; break;
      default: color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }
}
