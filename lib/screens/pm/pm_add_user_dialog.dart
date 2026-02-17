import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

void showPmAddUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const _AddUserDialog(),
  );
}

class _AddUserDialog extends StatefulWidget {
  const _AddUserDialog();

  @override
  State<_AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<_AddUserDialog> {
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
                child: const Icon(Icons.thumb_up, color: AppColors.green, size: 24),
              ),
              const SizedBox(height: 12),
              const Text('Guest User Added Successfully', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.green)),
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
        width: 500,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
              child: Row(
                children: [
                  const Text('Add Guest User', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  const Spacer(),
                  InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
                ],
              ),
            ),
            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: _textField('First Name', 'Enter first name')),
                      const SizedBox(width: 10),
                      Expanded(child: _textField('Last Name', 'Enter last name')),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mobile Number', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.borderGrey),
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)),
                                  ),
                                  child: const Text('+91', style: TextStyle(fontSize: 10, color: AppColors.textDark)),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 30,
                                    child: TextField(
                                      style: const TextStyle(fontSize: 10),
                                      decoration: InputDecoration(
                                        hintText: 'Enter number',
                                        hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                        border: OutlineInputBorder(borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)), borderSide: const BorderSide(color: AppColors.borderGrey)),
                                        enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)), borderSide: const BorderSide(color: AppColors.borderGrey)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Email ID', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.borderGrey),
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)),
                                  ),
                                  child: const Icon(Icons.alternate_email, size: 12, color: AppColors.textGrey),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 30,
                                    child: TextField(
                                      style: const TextStyle(fontSize: 10),
                                      decoration: InputDecoration(
                                        hintText: 'Enter email',
                                        hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                        border: OutlineInputBorder(borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)), borderSide: const BorderSide(color: AppColors.borderGrey)),
                                        enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)), borderSide: const BorderSide(color: AppColors.borderGrey)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    _dropdownField('Assign Role', 'Guest Author'),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: _dropdownField('Business Segment', 'Select')),
                      const SizedBox(width: 10),
                      Expanded(child: _dropdownField('Department', 'Select')),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: _dropdownField('Client', 'Select')),
                      const SizedBox(width: 10),
                      Expanded(child: _dropdownField('Program', 'Select')),
                    ]),
                    const SizedBox(height: 10),
                    _dropdownField('Select Course', 'Select course'),
                    const SizedBox(height: 10),
                    _dropdownField('Assign Hours', 'Default 125hrs'),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: _datePickerField('Start Date')),
                      const SizedBox(width: 10),
                      Expanded(child: _datePickerField('End Date')),
                    ]),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        SizedBox(
                          height: 28,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 12), elevation: 0),
                            child: const Text('Give Access', style: TextStyle(fontSize: 9)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 28,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 12)),
                            child: const Text('Remove Access', style: TextStyle(fontSize: 9, color: AppColors.red)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.borderGrey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => setState(() => _success = true),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), elevation: 0),
                    child: const Text('Apply', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, String hint) {
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

  Widget _dropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
        const SizedBox(height: 4),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              Text(value, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textGrey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _datePickerField(String label) {
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
}
