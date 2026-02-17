import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TrainingRequestDialog extends StatefulWidget {
  const TrainingRequestDialog({super.key});

  @override
  State<TrainingRequestDialog> createState() => _TrainingRequestDialogState();
}

class _TrainingRequestDialogState extends State<TrainingRequestDialog> {
  String _selectedType = 'Expiry Date';
  String? _selectedReason;

  List<String> get _reasons {
    switch (_selectedType) {
      case '1-1 Training':
        return ['Topic difficulty', 'Need guidance', 'Missed training', 'Absent', 'Other'];
      case 'Refresher Training':
        return ['Less time to complete', 'Technical issues', 'Was on leave', 'Content Updated', 'Other'];
      default:
        return ['Less time to complete', 'Technical issues', 'Was on leave', 'Content Updated', 'Other'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Request',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Radio buttons for training type
              Row(
                children: [
                  _buildRadioOption('Expiry Date'),
                  const SizedBox(width: 12),
                  _buildRadioOption('1-1 Training'),
                  const SizedBox(width: 12),
                  _buildRadioOption('Refresher Training'),
                ],
              ),
              const SizedBox(height: 20),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label) {
    final isSelected = _selectedType == label;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedType = label;
        _selectedReason = null;
      }),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            size: 18,
            color: isSelected ? AppColors.primaryBlue : AppColors.textGrey,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.textDark : AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select Reason dropdown
        DropdownButtonFormField<String>(
          value: _selectedReason,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
          ),
          hint: const Text('Select Reason', style: TextStyle(fontSize: 12)),
          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
          items: _reasons.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
          onChanged: (v) => setState(() => _selectedReason = v),
        ),
        const SizedBox(height: 16),
        // Date and Attachment in same row
        Row(
          children: [
            // Date field
            Expanded(
              child: TextField(
                readOnly: true,
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 7)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                },
                decoration: InputDecoration(
                  hintText: '12-09-2025',
                  hintStyle: const TextStyle(fontSize: 12),
                  prefixIcon: const Icon(Icons.calendar_today, size: 16, color: Colors.white),
                  prefixIconConstraints: const BoxConstraints(minWidth: 40),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Attachment field
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Text('Attachment', style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                    const Spacer(),
                    Icon(Icons.attach_file, size: 16, color: AppColors.textGrey),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Suggestions
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Suggestions',
            hintStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(fontSize: 13)),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              child: const Text('Send', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ],
    );
  }
}
