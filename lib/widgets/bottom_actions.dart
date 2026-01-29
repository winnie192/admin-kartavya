import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BottomActions extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSaveDraft;
  final VoidCallback? onNext;
  final String nextLabel;
  final bool showSaveDraft;

  const BottomActions({
    super.key,
    this.onCancel,
    this.onSaveDraft,
    this.onNext,
    this.nextLabel = 'Next',
    this.showSaveDraft = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.borderGrey)),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.primaryBlue, fontSize: 12),
            ),
          ),
          const Spacer(),
          if (showSaveDraft) ...[
            OutlinedButton(
              onPressed: onSaveDraft,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
              child: const Text(
                'Save Draft',
                style: TextStyle(color: AppColors.primaryBlue, fontSize: 12),
              ),
            ),
            const SizedBox(width: 10),
          ],
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              elevation: 0,
            ),
            child: Text(nextLabel, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
