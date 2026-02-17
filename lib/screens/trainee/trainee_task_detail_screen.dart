import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TraineeTaskDetailScreen extends StatelessWidget {
  const TraineeTaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title: const Text('Task Detail', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Task Info
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: AppColors.cardShadow, blurRadius: 6)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Title',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    const Text(
                      'Design a Responsive UI for Login Page',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    const Text('Description',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    const Text(
                      'Create a mobile-first responsive design for a login page using HTML, CSS, and any frontend framework of your choice (e.g., Bootstrap, Tailwind). Ensure the layout works well on desktop, tablet, and mobile views. The design should include email and password fields, login button, and basic error handling.',
                      style: TextStyle(fontSize: 12, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.person_outline,
                            size: 14, color: AppColors.textGrey),
                        const SizedBox(width: 6),
                        const Text('Devesh Dharmnath Singh Gupta',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _infoChip(
                            'Assignment Date', '08-03-2025', AppColors.primaryBlue),
                        const SizedBox(width: 12),
                        _infoChip('Submission Date', '12-07-2025', AppColors.orange),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Submitted',
                          style: TextStyle(
                              fontSize: 10,
                              color: AppColors.green,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 16),
                    const Text('Attachment',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textGrey)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderGrey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.description_outlined,
                              size: 16, color: AppColors.primaryBlue),
                          SizedBox(width: 6),
                          Text('DesignRequirements.pdf',
                              style: TextStyle(
                                  fontSize: 11, color: AppColors.primaryBlue)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Upload Task',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.borderGrey,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.cloud_upload_outlined,
                              size: 28, color: AppColors.textGrey),
                          const SizedBox(height: 6),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Browse',
                                style: TextStyle(fontSize: 12)),
                          ),
                          const Text(
                            'Supported formates: JPEG, PNG, GIF, MP4, PDF, PSD, AI, Word, PPT',
                            style: TextStyle(
                                fontSize: 9, color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Note',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Write your note here',
                        hintStyle: const TextStyle(fontSize: 12),
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.borderGrey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Submit',
                            style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Right: Task Progress
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: AppColors.cardShadow, blurRadius: 6)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Task Progress',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    _progressRow('Assignment Date', '08-03-2025'),
                    _progressRow('Submission Date', '12-03-2025'),
                    _progressRow('Submitted Date', '10-03-2025'),
                    _progressRow('Status', 'Submitted', isStatus: true),
                    const SizedBox(height: 12),
                    const Text('Feedback',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    const Text(
                      'Clean layout and good responsiveness. Please use company font in assignment.',
                      style: TextStyle(fontSize: 12, height: 1.4),
                    ),
                    const Divider(height: 24),
                    _progressRow('Resubmitted Date', '10-03-2025'),
                    _progressRow('Reassign Date', '08-03-2025'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('$label $value',
          style: TextStyle(fontSize: 10, color: color)),
    );
  }

  static Widget _progressRow(String label, String value,
      {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textGrey)),
          ),
          if (isStatus)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.green,
                      fontWeight: FontWeight.w600)),
            )
          else
            Text(value,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
