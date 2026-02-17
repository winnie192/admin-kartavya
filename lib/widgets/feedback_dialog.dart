import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({super.key});

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
                const Text('Comment', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 4),
            const Text('This feedback is visible to program manager, author and trainer.', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
            const SizedBox(height: 12),
            // Feedback type
            const Text('Select feedback type', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
            const SizedBox(height: 4),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
              child: Row(children: [
                const Expanded(child: Text('Comment', style: TextStyle(fontSize: 10, color: AppColors.textDark))),
                const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textGrey),
              ]),
            ),
            const SizedBox(height: 10),
            // Comment
            const Text('Comment', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
            const SizedBox(height: 4),
            TextField(
              maxLines: 4,
              style: const TextStyle(fontSize: 10),
              decoration: InputDecoration(
                hintText: 'Write your feedback here...',
                hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                contentPadding: const EdgeInsets.all(8),
              ),
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
    );
  }
}

void showFeedbackDialog(BuildContext context) {
  showDialog(context: context, builder: (_) => const FeedbackDialog());
}
