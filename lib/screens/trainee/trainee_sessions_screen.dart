import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'trainee_session_detail_screen.dart';

class TraineeSessionsScreen extends StatefulWidget {
  const TraineeSessionsScreen({super.key});

  @override
  State<TraineeSessionsScreen> createState() => _TraineeSessionsScreenState();
}

class _TraineeSessionsScreenState extends State<TraineeSessionsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats row
          Row(
            children: [
              _statChip('Session : 15', AppColors.primaryBlue),
              const SizedBox(width: 8),
              _statChip('Meeting : 02', AppColors.orange),
            ],
          ),
          const SizedBox(height: 16),
          // Filter tabs
          Row(
            children: [
              for (final f in [
                'All',
                'Upcoming : 14',
                'Ongoing : 1',
                'Completed : 2',
                'Cancel : 2'
              ]) ...[
                _filterTab(f),
                const SizedBox(width: 6),
              ],
              const Spacer(),
              _dateChip('From', '27-03-2025'),
              const SizedBox(width: 8),
              _dateChip('To', '27-03-2025'),
            ],
          ),
          const SizedBox(height: 16),
          // Search
          SizedBox(
            height: 36,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ...',
                hintStyle:
                    const TextStyle(fontSize: 12, color: AppColors.textGrey),
                prefixIcon: const Icon(Icons.search, size: 18),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.borderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.borderGrey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Session cards
          ..._sessions.map((s) => _SessionCard(session: s)),
          const SizedBox(height: 16),
          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('1-6  of  1',
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
              Row(
                children: [
                  _pageBtn(Icons.chevron_left),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('1/1',
                        style:
                            TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                  const SizedBox(width: 4),
                  _pageBtn(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget _filterTab(String label) {
    final key = label.split(' :').first.trim();
    final isActive = _selectedFilter == key ||
        (_selectedFilter == 'All' && label == 'All');
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryBlue.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
        ),
        child: Text(label,
            style: TextStyle(
              fontSize: 11,
              color:
                  isActive ? AppColors.primaryBlue : AppColors.textGrey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            )),
      ),
    );
  }

  Widget _dateChip(String label, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label ',
              style:
                  const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          Text(date,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _pageBtn(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Icon(icon, size: 16, color: AppColors.textGrey),
    );
  }
}

class _SessionData {
  final String status;
  final String timeSlot;
  final String dateLabel;
  final String type;
  final String statusDetail;

  const _SessionData({
    required this.status,
    required this.timeSlot,
    required this.dateLabel,
    required this.type,
    required this.statusDetail,
  });
}

const _sessions = [
  _SessionData(
    status: 'Ongoing',
    timeSlot: 'Morning  09:00 AM - 10:00 AM',
    dateLabel: '15 April 2025 : Session',
    type: 'Session',
    statusDetail: 'Status : Started 41 Mins ago',
  ),
  _SessionData(
    status: 'Upcoming',
    timeSlot: 'Afternoon  01:00 PM - 02:00 PM',
    dateLabel: '15 April 2025 : Session',
    type: 'Session',
    statusDetail: 'Status : Starting in 0 Days 04 Hrs 10 Mins',
  ),
  _SessionData(
    status: 'Upcoming',
    timeSlot: 'Afternoon 03:00 PM - 04:00 PM',
    dateLabel: '16 April 2025 : Session',
    type: 'Session',
    statusDetail: 'Status : Starting in 01 Days 24 Hrs 10 Mins',
  ),
  _SessionData(
    status: 'Upcoming',
    timeSlot: 'Evening  04:00 PM - 05:00 PM',
    dateLabel: '17 April 2025 : Session',
    type: 'Session',
    statusDetail: 'Status : Starting in 02 Days 21 Hrs 54 Mins',
  ),
  _SessionData(
    status: 'Upcoming',
    timeSlot: 'Morning  09:00 AM - 10:00 AM',
    dateLabel: '18 April 2025 : Meeting',
    type: 'Meeting',
    statusDetail: 'Status : Starting in 02 Days 21 Hrs 54 Mins',
  ),
  _SessionData(
    status: 'Completed',
    timeSlot: 'Evening  05:00 PM - 06:00 PM',
    dateLabel: '21 April 2025 : Meeting',
    type: 'Meeting',
    statusDetail: 'Status : Completed',
  ),
  _SessionData(
    status: 'Cancel',
    timeSlot: 'Morning  09:00 AM - 10:00 AM',
    dateLabel: '03 Jan 2025 : Session',
    type: 'Session',
    statusDetail: 'Status : Cancel on 02 Jan 2025',
  ),
];

class _SessionCard extends StatelessWidget {
  final _SessionData session;

  const _SessionCard({required this.session});

  Color get _statusColor {
    switch (session.status) {
      case 'Ongoing':
        return AppColors.green;
      case 'Upcoming':
        return AppColors.primaryBlue;
      case 'Completed':
        return const Color(0xFF9C27B0);
      case 'Cancel':
        return AppColors.red;
      default:
        return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: _statusColor, width: 4)),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          // Status badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(session.status,
                style: TextStyle(
                    fontSize: 10,
                    color: _statusColor,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(session.timeSlot,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(session.dateLabel,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textGrey)),
                const SizedBox(height: 2),
                Text(session.statusDetail,
                    style: TextStyle(
                        fontSize: 10,
                        color: _statusColor,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          // Actions
          if (session.status == 'Ongoing' || session.status == 'Upcoming') ...[
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TraineeSessionDetailScreen(type: session.type),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                side: const BorderSide(color: AppColors.primaryBlue),
              ),
              child: const Text('View Details',
                  style: TextStyle(fontSize: 11)),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child:
                  const Text('Join Now', style: TextStyle(fontSize: 11)),
            ),
          ] else
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TraineeSessionDetailScreen(type: session.type),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                side: const BorderSide(color: AppColors.primaryBlue),
              ),
              child: const Text('View Details',
                  style: TextStyle(fontSize: 11)),
            ),
        ],
      ),
    );
  }
}
