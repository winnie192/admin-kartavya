import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class EditAccessDialog extends StatefulWidget {
  final String userName;
  const EditAccessDialog({super.key, required this.userName});

  @override
  State<EditAccessDialog> createState() => _EditAccessDialogState();
}

class _EditAccessDialogState extends State<EditAccessDialog> {
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Edit Access', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  const Spacer(),
                  InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
                ],
              ),
              const SizedBox(height: 4),
              Text(widget.userName, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(height: 14),
              _dropdownField('Business Segment', 'Select Business Segment'),
              const SizedBox(height: 8),
              _dropdownField('Department', 'Select Department'),
              const SizedBox(height: 8),
              _dropdownField('Customer', 'Select Customer'),
              const SizedBox(height: 8),
              _dropdownField('Program', 'Select Program'),
              const SizedBox(height: 8),
              _dropdownField('Assign Role', 'Select'),
              const SizedBox(height: 8),
              _dropdownField('Select Course', 'Select Course'),
              const SizedBox(height: 8),
              _field('Assign Hours'),
              const SizedBox(height: 10),
              Row(
                children: [
                  _dateField('Start Date'),
                  const SizedBox(width: 8),
                  _dateField('End Date'),
                ],
              ),
              const SizedBox(height: 10),
              // Pause/Resume
              Row(
                children: [
                  const Text('Pause/Resume', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
                  const SizedBox(width: 12),
                  _toggleButton('Pause', !_isPaused, () => setState(() => _isPaused = false)),
                  const SizedBox(width: 6),
                  _toggleButton('Resume', _isPaused, () => setState(() => _isPaused = true)),
                ],
              ),
              const SizedBox(height: 14),
              // Action buttons
              Row(
                children: [
                  _actionBtn('Give Access', AppColors.green),
                  const SizedBox(width: 6),
                  _actionBtn('Remove Access', AppColors.red),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                    child: const Text('Apply', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownField(String label, String hint) {
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
            Expanded(child: Text(hint, style: const TextStyle(fontSize: 10, color: AppColors.grey))),
            const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textGrey),
          ]),
        ),
      ],
    );
  }

  Widget _field(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 3),
        SizedBox(
          height: 30,
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateField(String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(height: 3),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              const Expanded(child: Text('dd/mm/yyyy', style: TextStyle(fontSize: 9, color: AppColors.grey))),
              const Icon(Icons.calendar_today, size: 12, color: AppColors.textGrey),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
        ),
        child: Text(label, style: TextStyle(fontSize: 9, color: isActive ? Colors.white : AppColors.textGrey)),
      ),
    );
  }

  Widget _actionBtn(String label, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), elevation: 0),
      child: Text(label, style: const TextStyle(fontSize: 9)),
    );
  }
}

void showEditAccessDialog(BuildContext context, String userName) {
  showDialog(context: context, builder: (_) => EditAccessDialog(userName: userName));
}
