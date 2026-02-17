import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TrainerRequestsScreen extends StatefulWidget {
  const TrainerRequestsScreen({super.key});

  @override
  State<TrainerRequestsScreen> createState() => _TrainerRequestsScreenState();
}

class _TrainerRequestsScreenState extends State<TrainerRequestsScreen> {
  int _activeTab = 0; // 0=Received, 1=Sent

  final _receivedRequests = const [
    _ReceivedReq('Refresher', 'Muskan Verma', '1', '09-07-2025', 'Pending'),
    _ReceivedReq('Retrain', 'Clement Pinto', '07', '21-11-2025', 'Approved'),
    _ReceivedReq('Expiry Date', 'Rahul Gupta', '07', '21-11-2025', 'Approved'),
    _ReceivedReq('Retrain', 'Rahul Gupta', '07', '21-11-2025', 'Approved'),
    _ReceivedReq('Retrain', 'Rahul Gupta', '07', '21-11-2025', 'Approved'),
    _ReceivedReq('Meeting', 'Niloy Deb', '109', '18-09-2024', 'Rejected'),
    _ReceivedReq('Meeting', 'Nikita Fulwariya', '109', '18-09-2024', 'Rejected'),
    _ReceivedReq('Expiry Date', 'Ankit Pandey', '76', '08-10-2024', 'Pending'),
    _ReceivedReq('Retrain', 'Rahul Gupta', '07', '21-11-2025', 'Approved'),
    _ReceivedReq('Meeting', 'Nikita Fulwariya', '109', '18-09-2024', 'Rejected'),
  ];

  final _sentRequests = const [
    _SentReq('Inactive', 'Clement Pinto', 'Other', '21-11-2025', 'Approved'),
    _SentReq('New Course', 'Clement Pinto', 'Other', '21-11-2025', 'Rejected'),
    _SentReq('Inactive', 'Muskan Verma', 'Other', '21-11-2025', 'Approved'),
    _SentReq('Existing Course', 'Muskan Verma', 'Other', '21-11-2025', 'Rejected'),
    _SentReq('New Course', 'Clement Pinto', 'Incorrect Info', '09-07-2025', 'Pending'),
    _SentReq('Inactive', 'Clement Pinto', 'Other', '21-11-2025', 'Rejected'),
    _SentReq('New Course', 'Clement Pinto', 'Other', '21-11-2025', 'Approved'),
    _SentReq('Active', 'Clement Pinto', 'Other', '21-11-2025', 'Approved'),
    _SentReq('Active', 'Clement Pinto', 'Other', '21-11-2025', 'Rejected'),
    _SentReq('Existing Course', 'Muskan Verma', 'Other', '09-07-2025', 'Pending'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs
          Row(
            children: [
              _buildTab('Received Requests', 0),
              const SizedBox(width: 24),
              _buildTab('Sent Requests', 1),
            ],
          ),
          const SizedBox(height: 16),
          // Search + date range
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    filled: true, fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.borderGrey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.borderGrey)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Search', style: TextStyle(fontSize: 12)),
              ),
              const Spacer(),
              const Text('From', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(width: 6),
              _buildDateChip('20-03-2025'),
              const SizedBox(width: 10),
              const Text('To', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(width: 6),
              _buildDateChip('27-03-2025'),
            ],
          ),
          const SizedBox(height: 16),
          // Table
          _activeTab == 0 ? _buildReceivedTable() : _buildSentTable(),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? AppColors.textDark : AppColors.textGrey,
              )),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 100,
            color: isActive ? AppColors.primaryBlue : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 11, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(date, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildReceivedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          _tableHeader(['Request Type', 'Sender Name', 'Trainee QTY', 'Request Date', 'Status', 'Action'], flexMap: {'Trainee QTY': 1, 'Action': 1}),
          ..._receivedRequests.map((r) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(r.type, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r.sender, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 1, child: Text(r.traineeQty, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r.date, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 2, child: _statusBadge(r.status)),
                    Expanded(flex: 1, child: Icon(Icons.visibility, size: 18, color: AppColors.primaryBlue)),
                  ],
                ),
              )),
          _pagination(_receivedRequests.length),
        ],
      ),
    );
  }

  Widget _buildSentTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          _tableHeader(['Request Type', 'Send To', 'Reason', 'Request Date', 'Status', 'Action']),
          ..._sentRequests.map((r) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(r.type, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r.sendTo, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r.reason, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 2, child: Text(r.date, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
                    Expanded(flex: 2, child: _statusBadge(r.status)),
                    Expanded(flex: 1, child: Icon(Icons.visibility, size: 18, color: AppColors.primaryBlue)),
                  ],
                ),
              )),
          _pagination(_sentRequests.length),
        ],
      ),
    );
  }

  Widget _tableHeader(List<String> cols, {Map<String, int>? flexMap}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
      child: Row(
        children: cols.map((c) {
          final flex = flexMap?[c] ?? (c == 'Action' ? 1 : 2);
          return Expanded(
            flex: flex,
            child: Row(
              children: [
                Text(c, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.orange)),
                if (c != 'Action') ...[
                  const SizedBox(width: 4),
                  Icon(Icons.filter_list, size: 12, color: AppColors.orange),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bg;
    switch (status) {
      case 'Pending':
        bg = AppColors.orange;
        break;
      case 'Approved':
        bg = AppColors.green;
        break;
      case 'Rejected':
        bg = AppColors.red;
        break;
      default:
        bg = AppColors.textGrey;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
        child: Text(status, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _pagination(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Text('1-$count of 1', style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
          const Spacer(),
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
            child: const Icon(Icons.chevron_left, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
            child: const Text('1/1', style: TextStyle(color: Colors.white, fontSize: 10)),
          ),
          const SizedBox(width: 4),
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
            child: const Icon(Icons.chevron_right, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

class _ReceivedReq {
  final String type, sender, traineeQty, date, status;
  const _ReceivedReq(this.type, this.sender, this.traineeQty, this.date, this.status);
}

class _SentReq {
  final String type, sendTo, reason, date, status;
  const _SentReq(this.type, this.sendTo, this.reason, this.date, this.status);
}
