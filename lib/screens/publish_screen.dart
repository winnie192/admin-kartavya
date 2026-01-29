import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class PublishScreen extends StatefulWidget {
  const PublishScreen({super.key});

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  int scheduleType = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Publish Exam',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          _buildExamSummary(context),
          const SizedBox(height: 16),
          const Text(
            'Choose how you want to publish your exam. You can set a specific date and time or opt for a flexible exam schedule.',
            style: TextStyle(fontSize: 11, color: AppColors.textGrey),
          ),
          const SizedBox(height: 14),
          _buildScheduleOption(
            0,
            'Specific Date & Time',
            'Set a specific date and time for the exam to start and end.',
          ),
          const SizedBox(height: 8),
          _buildScheduleOption(
            1,
            'Flexible Schedule',
            'Allow candidates to take the exam at their convenience within a defined period.',
          ),
          const SizedBox(height: 16),
          _buildDateTimeFields(context),
        ],
      ),
    );
  }

  Widget _buildExamSummary(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exam Summary',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          isMobile
              ? Column(
                  children: [
                    _buildSummaryItem('Total Questions', '10'),
                    const SizedBox(height: 8),
                    _buildSummaryItem('Total Marks', '50'),
                    const SizedBox(height: 8),
                    _buildSummaryItem('Total Duration', '30 mins'),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: _buildSummaryItem('Total Questions', '10')),
                    Expanded(child: _buildSummaryItem('Total Marks', '50')),
                    Expanded(
                        child:
                            _buildSummaryItem('Total Duration', '30 mins')),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark)),
      ],
    );
  }

  Widget _buildScheduleOption(int value, String title, String subtitle) {
    final isSelected = scheduleType == value;
    return GestureDetector(
      onTap: () => setState(() => scheduleType = value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.borderGrey,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? AppColors.primaryBlue.withValues(alpha: 0.05)
              : Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Radio<int>(
                value: value,
                groupValue: scheduleType,
                onChanged: (v) => setState(() => scheduleType = v!),
                activeColor: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeFields(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        isMobile
            ? Column(children: [
                _buildDateField('Start Date', '12-09-2025'),
                const SizedBox(height: 10),
                _buildTimeField('Start Time', '08:00AM'),
              ])
            : Row(children: [
                Expanded(
                    child: _buildDateField('Start Date', '12-09-2025')),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildTimeField('Start Time', '08:00AM')),
              ]),
        const SizedBox(height: 12),
        isMobile
            ? Column(children: [
                _buildDateField('End Date', '12-09-2025'),
                const SizedBox(height: 10),
                _buildTimeField('End Time', '08:00AM'),
              ])
            : Row(children: [
                Expanded(
                    child: _buildDateField('End Date', '12-09-2025')),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildTimeField('End Time', '08:00AM')),
              ]),
      ],
    );
  }

  Widget _buildDateField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 14, color: AppColors.textGrey),
              const SizedBox(width: 8),
              Text(value, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              const Icon(Icons.access_time,
                  size: 14, color: AppColors.textGrey),
              const SizedBox(width: 8),
              Text(value, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }
}
