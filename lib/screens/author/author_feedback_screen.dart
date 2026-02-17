import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthorFeedbackScreen extends StatefulWidget {
  const AuthorFeedbackScreen({super.key});

  @override
  State<AuthorFeedbackScreen> createState() => _AuthorFeedbackScreenState();
}

class _AuthorFeedbackScreenState extends State<AuthorFeedbackScreen> {
  int _filterTab = 0; // 0=All, 1=Working, 2=Created
  final Set<int> _expandedRows = {};

  final _feedbackItems = const [
    _FeedbackItem('Advisory Advisory', 'Need improvements in Module 2 content flow', '12 Jan 2025'),
    _FeedbackItem('Content Design Advisory', 'Visual elements should be more engaging', '10 Jan 2025'),
    _FeedbackItem('Course Design', 'Restructure section 3 for better learning outcomes', '08 Jan 2025'),
    _FeedbackItem('Advisory Advisory', 'Assessment questions need revision', '05 Jan 2025'),
    _FeedbackItem('Content Design Advisory', 'Add more interactive elements', '03 Jan 2025'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Feedback',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 14),
          // Filter tabs
          _buildFilterTabs(),
          const SizedBox(height: 14),
          // Date range
          _buildDateRange(),
          const SizedBox(height: 14),
          // Table
          _buildFeedbackTable(),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Row(
      children: [
        _buildFilterTab(0, 'All'),
        const SizedBox(width: 16),
        _buildFilterTab(1, 'Working'),
        const SizedBox(width: 16),
        _buildFilterTab(2, 'Created'),
      ],
    );
  }

  Widget _buildFilterTab(int index, String label) {
    final isActive = _filterTab == index;
    return GestureDetector(
      onTap: () => setState(() => _filterTab = index),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? AppColors.primaryBlue
                      : AppColors.textGrey)),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 40,
            color:
                isActive ? AppColors.primaryBlue : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildDateRange() {
    return Row(
      children: [
        _buildDateField('From'),
        const SizedBox(width: 10),
        _buildDateField('To'),
      ],
    );
  }

  Widget _buildDateField(String label) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10, color: AppColors.textGrey)),
          const SizedBox(width: 8),
          const Icon(Icons.calendar_today,
              size: 12, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _buildFeedbackTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 6,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                SizedBox(
                    width: 30,
                    child: Text('',
                        style: TextStyle(fontSize: 9))),
                Expanded(
                    flex: 2,
                    child: Text('Type',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textGrey))),
                Expanded(
                    flex: 3,
                    child: Text('Comment',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textGrey))),
                SizedBox(
                    width: 80,
                    child: Text('Date',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textGrey))),
                SizedBox(
                    width: 40,
                    child: Text('Action',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textGrey))),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderGrey),
          // Rows
          ...List.generate(
              _feedbackItems.length, (i) => _buildFeedbackRow(i)),
        ],
      ),
    );
  }

  Widget _buildFeedbackRow(int index) {
    final item = _feedbackItems[index];
    final isExpanded = _expandedRows.contains(index);

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() {
            if (isExpanded) {
              _expandedRows.remove(index);
            } else {
              _expandedRows.add(index);
            }
          }),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    size: 14,
                    color: AppColors.textGrey,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(item.type,
                        style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textDark))),
                Expanded(
                    flex: 3,
                    child: Text(item.comment,
                        style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textDark),
                        overflow: TextOverflow.ellipsis)),
                SizedBox(
                    width: 80,
                    child: Text(item.date,
                        style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textDark))),
                SizedBox(
                  width: 40,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.edit,
                            size: 13,
                            color: AppColors.primaryBlue),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.delete,
                            size: 13, color: AppColors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Type: ${item.type}',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark)),
                const SizedBox(height: 6),
                Text(item.comment,
                    style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textGrey)),
                const SizedBox(height: 4),
                Text('Date: ${item.date}',
                    style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textGrey)),
                const SizedBox(height: 8),
                const Text(
                  'Detailed feedback: This section provides comprehensive feedback on the course content, structure, and delivery. The reviewer has provided specific suggestions for improvement that should be addressed in the next revision.',
                  style: TextStyle(
                      fontSize: 9, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
        const Divider(height: 1, color: AppColors.borderGrey),
      ],
    );
  }
}

class _FeedbackItem {
  final String type;
  final String comment;
  final String date;
  const _FeedbackItem(this.type, this.comment, this.date);
}
