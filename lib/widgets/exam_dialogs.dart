import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ExamDialogs {
  static Future<bool?> showReuseDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Reuse Exam', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("You're about to reuse this exam.", style: TextStyle(fontSize: 11, color: AppColors.textDark)),
            SizedBox(height: 8),
            Text(
              'This will create a duplicate copy of the exam which you can edit and publish. The original exam will remain unchanged.',
              style: TextStyle(fontSize: 10, color: AppColors.textGrey),
            ),
            SizedBox(height: 8),
            Text('Do you want to proceed with reusing this exam?', style: TextStyle(fontSize: 10, color: AppColors.textDark)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text('Yes, Reuse', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showExportDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Export', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        content: const Text('Do you want to export as PDF?', style: TextStyle(fontSize: 11, color: AppColors.textDark)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text('Yes', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Saved Exam', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.red)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Once you delete it then it permanently gets deleted from the system and not accessible.',
              style: TextStyle(fontSize: 10, color: AppColors.textGrey),
            ),
            SizedBox(height: 8),
            Text('Are you sure you want to delete exam?', style: TextStyle(fontSize: 11, color: AppColors.textDark)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text('Yes', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  static Future<void> showSaveDraftDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Save as Draft', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        content: const Text(
          'Are you sure you want to save this exam as a draft? You can resume editing later.',
          style: TextStyle(fontSize: 11, color: AppColors.textDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.amber,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text('Yes', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  static Future<void> showPublishDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Publish Exam', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        content: const Text(
          'Are you sure you want to publish this exam? Candidates will be able to access it.',
          style: TextStyle(fontSize: 11, color: AppColors.textDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text('Yes', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  static Future<void> showCancelDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Cancel Exam', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.red)),
        content: const Text(
          'Are you sure you want to cancel this exam? Exam will not save.',
          style: TextStyle(fontSize: 11, color: AppColors.textDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: const Text('Yes', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  static Future<void> showAssignedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.green.withValues(alpha: 0.1)),
              child: const Icon(Icons.check_circle, color: AppColors.green, size: 40),
            ),
            const SizedBox(height: 12),
            const Text('Assigned Trainees', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 8),
            const Text(
              'The exam has been successfully assigned to the selected trainee(s). They will be notified and can begin the test as per the defined schedule.',
              style: TextStyle(fontSize: 10, color: AppColors.textGrey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                elevation: 0,
              ),
              child: const Text('OK', style: TextStyle(fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}
