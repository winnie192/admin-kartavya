import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthorSendEditRequestDialog extends StatelessWidget {
  const AuthorSendEditRequestDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const AuthorSendEditRequestDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Send request for edit',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'You are requesting to edit this course. Please provide a reason for your edit request. The request will be reviewed and you will be notified upon approval.',
            style: TextStyle(fontSize: 10, color: AppColors.textGrey),
          ),
          const SizedBox(height: 12),
          const Text('Reason for edit?',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          TextField(
            maxLines: 3,
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: 'Enter your reason for editing...',
              hintStyle:
                  const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.all(8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.help_outline,
                  size: 14, color: AppColors.amber),
              const SizedBox(width: 6),
              const Text('Are you sure you want to Edit?',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark)),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)),
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            elevation: 0,
          ),
          child: const Text('Yes', style: TextStyle(fontSize: 11)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)),
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            elevation: 0,
          ),
          child: const Text('No', style: TextStyle(fontSize: 11)),
        ),
      ],
    );
  }
}
