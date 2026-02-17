import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class PmNotificationsScreen extends StatefulWidget {
  /// If true, renders as a compact panel (used in dashboard). If false, renders as full screen.
  final bool compact;

  const PmNotificationsScreen({super.key, this.compact = false});

  @override
  State<PmNotificationsScreen> createState() => _PmNotificationsScreenState();
}

class _PmNotificationsScreenState extends State<PmNotificationsScreen> {
  int _statusFilter = 0; // 0=All, 1=Unread, 2=Read
  int _roleFilter = -1; // -1=All, 0=Guest, 1=Trainee, 2=Trainer, 3=Author, 4=Review Department

  static const _statusTabs = ['All', 'Unread', 'Read'];
  static const _roleTabs = ['Guest', 'Trainee', 'Trainer', 'Author', 'Review Department'];

  static const _roleColors = {
    'Guest': AppColors.grey,
    'Trainee': AppColors.green,
    'Trainer': AppColors.primaryBlue,
    'Author': AppColors.amber,
    'Review Department': AppColors.orange,
  };

  final _notifications = const [
    _NotifData('Mahalaxmi Balakrishna Shetty', 'Author', 'A new course has been submitted for review.', '04mins ago', false),
    _NotifData('Mahalaxmi Balakrishna Shetty', 'Author', 'The course has been updated and resubmitted.', '23h ago', false),
    _NotifData('Yashoda Anchan', 'Trainer', 'Trainer has completed the assigned task.', '3h ago', false),
    _NotifData('Yashoda Anchan', 'Trainer', 'You have a new message from the Trainer. Check your inbox.', '23h ago', true),
    _NotifData('Rachana Dharamnath Singh', 'Trainee', 'Trainee has completed the course.', 'October 21, 2024', true),
    _NotifData('Rachana Dharamnath Singh', 'Trainee', 'You have a new message. Check your inbox.', '23mins ago', false),
    _NotifData('Mahalaxmi Balakrishna Shetty', 'Author', 'You have a new message. Check your inbox.', 'March 09', true),
    _NotifData('Ankit Omkareshwar Pandey', 'Review Department', 'The course has been returned. Rework needed.', '23mins ago', false),
    _NotifData('Ankit Omkareshwar Pandey', 'Review Department', 'The course has been approved.', '10h ago', true),
    _NotifData('Ankit Omkareshwar Pandey', 'Review Department', 'The course has been rejected. Please review the feedback.', 'December 04', true),
    _NotifData('Ankit Omkareshwar Pandey', 'Review Department', 'You have a new message. Check your inbox', 'August 26, 2024', true),
  ];

  List<_NotifData> get _filteredNotifications {
    var list = _notifications.toList();
    if (_statusFilter == 1) list = list.where((n) => !n.isRead).toList();
    if (_statusFilter == 2) list = list.where((n) => n.isRead).toList();
    if (_roleFilter >= 0) list = list.where((n) => n.role == _roleTabs[_roleFilter]).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.compact) return _buildCompactPanel();
    return _buildFullScreen();
  }

  Widget _buildFullScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notifications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          _buildFilters(),
          const SizedBox(height: 12),
          _buildNotificationList(),
        ],
      ),
    );
  }

  Widget _buildCompactPanel() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 8),
          _buildFilters(),
          const SizedBox(height: 8),
          ..._filteredNotifications.take(5).map((n) => _buildNotifItem(n)),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        // Status filter row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _statusTabs.asMap().entries.map((e) {
              final isActive = e.key == _statusFilter;
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () => setState(() => _statusFilter = e.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primaryBlue : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
                    ),
                    child: Text(e.value, style: TextStyle(fontSize: 9, color: isActive ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.w500)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 6),
        // Role filter row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _roleFilter = -1),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: _roleFilter == -1 ? AppColors.textDark : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _roleFilter == -1 ? AppColors.textDark : AppColors.borderGrey),
                  ),
                  child: Text('All', style: TextStyle(fontSize: 8, color: _roleFilter == -1 ? Colors.white : AppColors.textGrey)),
                ),
              ),
              ..._roleTabs.asMap().entries.map((e) {
                final isActive = e.key == _roleFilter;
                final color = _roleColors[e.value] ?? AppColors.grey;
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => _roleFilter = e.key),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isActive ? color.withValues(alpha: 0.15) : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: isActive ? color : AppColors.borderGrey),
                      ),
                      child: Text(e.value, style: TextStyle(fontSize: 8, color: isActive ? color : AppColors.textGrey)),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationList() {
    final list = _filteredNotifications;
    if (list.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: Text('No notifications', style: TextStyle(fontSize: 12, color: AppColors.textGrey))),
      );
    }
    return Column(children: list.map((n) => _buildNotifItem(n)).toList());
  }

  Widget _buildNotifItem(_NotifData n) {
    final roleColor = _roleColors[n.role] ?? AppColors.grey;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: roleColor.withValues(alpha: 0.15),
            child: Text(n.name[0], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: roleColor)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(n.name, style: TextStyle(fontSize: 11, fontWeight: n.isRead ? FontWeight.w400 : FontWeight.w600, color: AppColors.textDark)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(color: roleColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(n.role, style: TextStyle(fontSize: 7, fontWeight: FontWeight.w500, color: roleColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(n.message, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(height: 2),
                Text(n.timestamp, style: TextStyle(fontSize: 8, color: AppColors.textGrey.withValues(alpha: 0.7))),
              ],
            ),
          ),
          if (!n.isRead)
            Container(
              width: 6, height: 6,
              margin: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}

class _NotifData {
  final String name, role, message, timestamp;
  final bool isRead;
  const _NotifData(this.name, this.role, this.message, this.timestamp, this.isRead);
}
