import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

void showPmSendInvitesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const _SendInvitesDialog(),
  );
}

class _SendInvitesDialog extends StatefulWidget {
  const _SendInvitesDialog();

  @override
  State<_SendInvitesDialog> createState() => _SendInvitesDialogState();
}

class _SendInvitesDialogState extends State<_SendInvitesDialog> {
  final _descController = TextEditingController();
  bool _requireDigitalSign = false;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                const Text('Send Invites', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 14),
            _buildField('Title', 'Enter invite title'),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Description', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(height: 4),
                TextField(
                  controller: _descController,
                  maxLines: 3,
                  maxLength: 150,
                  style: const TextStyle(fontSize: 10),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Enter description...',
                    hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                    contentPadding: const EdgeInsets.all(8),
                    counterText: '${_descController.text.length}/150',
                    counterStyle: const TextStyle(fontSize: 8, color: AppColors.textGrey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildDateField('Date'),
            const SizedBox(height: 10),
            _buildAttachmentField(),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _buildTimeField('From')),
              const SizedBox(width: 10),
              Expanded(child: _buildTimeField('To')),
            ]),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Require Digital Sign', style: TextStyle(fontSize: 10, color: AppColors.textDark)),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _requireDigitalSign = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _requireDigitalSign ? AppColors.green.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: _requireDigitalSign ? AppColors.green : AppColors.borderGrey),
                    ),
                    child: Text('Yes', style: TextStyle(fontSize: 9, color: _requireDigitalSign ? AppColors.green : AppColors.textGrey)),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => setState(() => _requireDigitalSign = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: !_requireDigitalSign ? AppColors.red.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: !_requireDigitalSign ? AppColors.red : AppColors.borderGrey),
                    ),
                    child: Text('No', style: TextStyle(fontSize: 9, color: !_requireDigitalSign ? AppColors.red : AppColors.textGrey)),
                  ),
                ),
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
    );
  }

  Widget _buildField(String label, String hint) {
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

  Widget _buildDateField(String label) {
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

  Widget _buildTimeField(String label) {
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

  Widget _buildAttachmentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Attachment', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
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
}
