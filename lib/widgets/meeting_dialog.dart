import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MeetingDialog extends StatefulWidget {
  const MeetingDialog({super.key});

  @override
  State<MeetingDialog> createState() => _MeetingDialogState();
}

class _MeetingDialogState extends State<MeetingDialog> {
  int _selectedType = 0; // 0=Sessions, 1=Meeting
  bool _requireSignature = false;
  final _days = {'Monday': false, 'Tuesday': false, 'Wednesday': false, 'Thursday': false, 'Friday': false, 'Saturday': false, 'Sunday': false};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 440,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _typeTab('Sessions', 0),
                  const SizedBox(width: 6),
                  _typeTab('Meeting', 1),
                  const Spacer(),
                  InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
                ],
              ),
              const SizedBox(height: 14),
              if (_selectedType == 0) _buildSessionsForm() else _buildMeetingForm(),
              const SizedBox(height: 10),
              // Attachment
              const Text('Attachment', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
              const SizedBox(height: 4),
              SizedBox(
                height: 30,
                child: TextField(
                  style: const TextStyle(fontSize: 10),
                  decoration: InputDecoration(
                    hintText: 'Text',
                    hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                    suffixIcon: const Icon(Icons.attach_file, size: 14, color: AppColors.textGrey),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 16, height: 16,
                    child: Checkbox(
                      value: _requireSignature,
                      onChanged: (v) => setState(() => _requireSignature = v ?? false),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('Require Digital Signature', style: TextStyle(fontSize: 9, color: AppColors.textDark)),
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

  Widget _buildSessionsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: _dateField('Start Date')),
          const SizedBox(width: 8),
          Expanded(child: _dateField('End Date')),
        ]),
        const SizedBox(height: 8),
        const Text('Select Days', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4, runSpacing: 4,
          children: _days.entries.map((e) => GestureDetector(
            onTap: () => setState(() => _days[e.key] = !e.value),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: e.value ? AppColors.primaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: e.value ? AppColors.primaryBlue : AppColors.borderGrey),
              ),
              child: Text(e.key, style: TextStyle(fontSize: 8, color: e.value ? Colors.white : AppColors.textGrey)),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildMeetingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dateField('Date'),
        const SizedBox(height: 8),
        // Meeting Agenda
        const Text('Meeting Agenda', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        SizedBox(
          height: 30,
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: 'Text',
              hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _timeField('From', '14:34')),
          const SizedBox(width: 8),
          Expanded(child: _timeField('To', '14:34')),
        ]),
      ],
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

  Widget _timeField(String label, String value) {
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
            Expanded(child: Text(value, style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
            const Icon(Icons.access_time, size: 12, color: AppColors.textGrey),
          ]),
        ),
      ],
    );
  }
}

void showMeetingDialog(BuildContext context) {
  showDialog(context: context, builder: (_) => const MeetingDialog());
}
