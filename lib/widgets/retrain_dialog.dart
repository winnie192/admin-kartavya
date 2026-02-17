import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RetrainDialog extends StatefulWidget {
  const RetrainDialog({super.key});

  @override
  State<RetrainDialog> createState() => _RetrainDialogState();
}

class _RetrainDialogState extends State<RetrainDialog> {
  int _selectedType = 0; // 0=Self Train, 1=One-One

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 420,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Retrain Trainee', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _typeTab('Self Train', 0),
                  const SizedBox(width: 6),
                  _typeTab('One-One', 1),
                ],
              ),
              const SizedBox(height: 12),
              if (_selectedType == 0) _buildSelfTrainForm() else _buildOneOneForm(),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                    child: const Text('Send', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelfTrainForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type reason for self train.', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        TextField(
          maxLines: 3,
          style: const TextStyle(fontSize: 10),
          decoration: InputDecoration(
            hintText: 'Enter reason...',
            hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _dateField('From Date')),
          const SizedBox(width: 8),
          Expanded(child: _dateField('To Date')),
        ]),
      ],
    );
  }

  Widget _buildOneOneForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: _dateField('From Date')),
          const SizedBox(width: 8),
          Expanded(child: _dateField('To Date')),
        ]),
        const SizedBox(height: 8),
        // Select Trainer
        const Text('Select Trainer', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
          child: Row(children: [
            const Expanded(child: Text('Select Trainer', style: TextStyle(fontSize: 10, color: AppColors.grey))),
            const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textGrey),
          ]),
        ),
        const SizedBox(height: 8),
        // Time slots
        const Text('Available Slots', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6, runSpacing: 6,
          children: [
            _timeSlot('Morning', '09:00AM - 10:00AM', false),
            _timeSlot('Afternoon', '01:00PM - 02:00PM', true),
            _timeSlot('Evening', '05:00PM - 06:00PM', false),
          ],
        ),
      ],
    );
  }

  Widget _timeSlot(String label, String time, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.borderGrey),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 9, color: isSelected ? AppColors.primaryBlue : AppColors.textDark, fontWeight: FontWeight.w500)),
          Text(time, style: TextStyle(fontSize: 7, color: isSelected ? AppColors.primaryBlue : AppColors.textGrey)),
        ],
      ),
    );
  }

  Widget _typeTab(String label, int index) {
    final isActive = _selectedType == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = index),
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

  Widget _dateField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 3),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
          child: Row(children: [
            const Expanded(child: Text('12-09-2025', style: TextStyle(fontSize: 9, color: AppColors.textDark))),
            const Icon(Icons.calendar_today, size: 12, color: AppColors.textGrey),
          ]),
        ),
      ],
    );
  }
}

void showRetrainDialog(BuildContext context) {
  showDialog(context: context, builder: (_) => const RetrainDialog());
}
