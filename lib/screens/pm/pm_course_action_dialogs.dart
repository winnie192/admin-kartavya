import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

/// Rework dialog for PM course actions
void showPmReworkDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Rework Reason', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 14),
            const Text('Select Reason', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
              child: const Row(
                children: [
                  Expanded(child: Text('Select reason', style: TextStyle(fontSize: 10, color: AppColors.grey))),
                  Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textGrey),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text('Suggest Improvement', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
            const SizedBox(height: 4),
            TextField(
              maxLines: 3,
              style: const TextStyle(fontSize: 10),
              decoration: InputDecoration(
                hintText: 'Enter improvement suggestions...',
                hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _dateField('Start Date')),
                const SizedBox(width: 10),
                Expanded(child: _dateField('Deadline')),
              ],
            ),
            const SizedBox(height: 10),
            _attachmentField(),
            const SizedBox(height: 16),
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

/// Forward for Review dialog
void showPmForwardDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Forward for Review', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 14),
            _attachmentField(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _dateField('Current Date')),
                const SizedBox(width: 10),
                Expanded(child: _dateField('Expected Date')),
              ],
            ),
            const SizedBox(height: 16),
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

/// Visibility dialog
void showPmVisibilityDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const _VisibilityDialog(),
  );
}

class _VisibilityDialog extends StatefulWidget {
  const _VisibilityDialog();
  @override
  State<_VisibilityDialog> createState() => _VisibilityDialogState();
}

class _VisibilityDialogState extends State<_VisibilityDialog> {
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Visibility', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _visibilityOption('Active', true),
                const SizedBox(width: 10),
                _visibilityOption('Inactive', false),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _dateField('Expected Date')),
                const SizedBox(width: 10),
                Expanded(child: _dateField('Current Date')),
              ],
            ),
            const SizedBox(height: 16),
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
    );
  }

  Widget _visibilityOption(String label, bool value) {
    final isSelected = _isActive == value;
    return GestureDetector(
      onTap: () => setState(() => _isActive = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? (value ? AppColors.green : AppColors.grey).withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? (value ? AppColors.green : AppColors.grey) : AppColors.borderGrey),
        ),
        child: Text(label, style: TextStyle(fontSize: 10, color: isSelected ? (value ? AppColors.green : AppColors.grey) : AppColors.textGrey, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

/// Publish dialog
void showPmPublishDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Publish Course', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 14),
            _dateField('Date'),
            const SizedBox(height: 10),
            _timeField('Time'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                  child: const Text('Publish', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/// Delete course confirmation dialog
void showPmDeleteCourseDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber_rounded, size: 36, color: AppColors.red),
            const SizedBox(height: 10),
            const Text('Are you sure you want to delete this course?', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.textDark)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), elevation: 0),
                  child: const Text('Yes', style: TextStyle(fontSize: 10)),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.borderGrey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                  child: const Text('No', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// --- Shared field helpers ---
Widget _dateField(String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
        child: const Row(
          children: [
            Text('Select date', style: TextStyle(fontSize: 10, color: AppColors.grey)),
            Spacer(),
            Icon(Icons.calendar_today, size: 12, color: AppColors.textGrey),
          ],
        ),
      ),
    ],
  );
}

Widget _timeField(String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
        child: const Row(
          children: [
            Text('Select time', style: TextStyle(fontSize: 10, color: AppColors.grey)),
            Spacer(),
            Icon(Icons.access_time, size: 12, color: AppColors.textGrey),
          ],
        ),
      ),
    ],
  );
}

Widget _attachmentField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Attachment', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
        child: const Row(
          children: [
            Icon(Icons.attach_file, size: 12, color: AppColors.textGrey),
            SizedBox(width: 4),
            Text('Upload file', style: TextStyle(fontSize: 10, color: AppColors.grey)),
          ],
        ),
      ),
    ],
  );
}
