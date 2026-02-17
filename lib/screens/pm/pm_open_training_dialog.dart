import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

/// Open Training dialog
void showPmOpenTrainingDialog(BuildContext context) {
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
                const Text('Open Training', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 14),
            _fieldHelper('Attachment'),
            const SizedBox(height: 10),
            _textFieldHelper('Meeting Agenda', 'Enter meeting agenda'),
            const SizedBox(height: 10),
            _textAreaHelper('Description', 'Enter description...'),
            const SizedBox(height: 10),
            _dateFieldHelper('Date'),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _timeFieldHelper('From')),
              const SizedBox(width: 10),
              Expanded(child: _timeFieldHelper('To')),
            ]),
            const SizedBox(height: 10),
            _digitalSignField(),
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

/// Refresher Training confirmation dialog
void showPmRefresherDialog(BuildContext context, String requesterName) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: AppColors.amber.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.refresh, color: AppColors.amber, size: 28),
            ),
            const SizedBox(height: 12),
            const Text('Refresher Training', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 8),
            Text(
              'You have a request from $requesterName for refresher training.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                  child: const Text('Yes, Allow', style: TextStyle(fontSize: 10)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                  child: const Text('No, Deny', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/// Delete User confirmation dialog
void showPmDeleteUserDialog(BuildContext context, String userName) {
  showDialog(
    context: context,
    builder: (_) => _DeleteUserDialog(userName: userName),
  );
}

class _DeleteUserDialog extends StatefulWidget {
  final String userName;
  const _DeleteUserDialog({required this.userName});
  @override
  State<_DeleteUserDialog> createState() => _DeleteUserDialogState();
}

class _DeleteUserDialogState extends State<_DeleteUserDialog> {
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    if (_success) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: AppColors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, color: AppColors.green, size: 24),
              ),
              const SizedBox(height: 12),
              Text('Request For Deleting [Guest] User Sent Successfully.', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.green)),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), elevation: 0),
                child: const Text('OK', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber_rounded, size: 36, color: AppColors.red),
            const SizedBox(height: 10),
            const Text('Are you sure you want to delete this user permanently?', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.textDark)),
            const SizedBox(height: 6),
            Text(widget.userName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _success = true),
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
    );
  }
}

/// Select People for Meeting dialog
void showPmSelectPeopleDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const _SelectPeopleDialog(),
  );
}

class _SelectPeopleDialog extends StatefulWidget {
  const _SelectPeopleDialog();
  @override
  State<_SelectPeopleDialog> createState() => _SelectPeopleDialogState();
}

class _SelectPeopleDialogState extends State<_SelectPeopleDialog> {
  final _people = {
    'Shrey Saraki': false,
    'Clement Pinto': false,
    'Monishka Mangnani': true,
    'Vimla Doliya': false,
    'Lavesh Paryani': true,
    'Piyush Notani': false,
  };
  String _selectedSlot = 'Morning';

  final _timeSlots = {
    'Morning': ['09:00AM - 10:00AM', '10:00AM - 11:00AM', '11:00AM - 12:00PM'],
    'Afternoon': ['01:00PM - 02:00PM', '02:00PM - 03:00PM', '03:00PM - 04:00PM'],
    'Evening': ['05:00PM - 06:00PM', '06:00PM - 07:00PM'],
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 500),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Select People for Meeting', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._people.entries.map((e) => CheckboxListTile(
                      value: e.value,
                      onChanged: (v) => setState(() => _people[e.key] = v ?? false),
                      title: Text(e.key, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    )),
                    const SizedBox(height: 10),
                    const Text('Time Slot', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      children: _timeSlots.keys.map((slot) {
                        final isActive = _selectedSlot == slot;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedSlot = slot),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.primaryBlue : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
                            ),
                            child: Text(slot, style: TextStyle(fontSize: 9, color: isActive ? Colors.white : AppColors.textGrey)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    ...(_timeSlots[_selectedSlot] ?? []).map((t) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(4)),
                        child: Text(t, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
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
    );
  }
}

// --- Shared field helpers ---
Widget _fieldHelper(String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 8),
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

Widget _textFieldHelper(String label, String hint) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      SizedBox(
        height: 30,
        child: TextField(
          style: const TextStyle(fontSize: 10),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
          ),
        ),
      ),
    ],
  );
}

Widget _textAreaHelper(String label, String hint) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      TextField(
        maxLines: 3,
        style: const TextStyle(fontSize: 10),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
        ),
      ),
    ],
  );
}

Widget _dateFieldHelper(String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 8),
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

Widget _timeFieldHelper(String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
      const SizedBox(height: 4),
      Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 8),
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

Widget _digitalSignField() {
  return const Row(
    children: [
      Text('Require Digital Signature', style: TextStyle(fontSize: 10, color: AppColors.textDark)),
      Spacer(),
      Text('Yes / No', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
    ],
  );
}
