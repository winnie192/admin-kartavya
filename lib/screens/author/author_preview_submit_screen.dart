import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthorPreviewSubmitScreen extends StatelessWidget {
  const AuthorPreviewSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Preview & Submit',
            style: TextStyle(fontSize: 16)),
      ),
      body: Column(
        children: [
          // Stepper indicator
          _buildStepper(),
          const Divider(height: 1, color: AppColors.borderGrey),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.cardShadow,
                        blurRadius: 6,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Preview course link
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamed(
                          context, '/author/course-preview'),
                      icon: const Icon(Icons.play_arrow, size: 14),
                      label: const Text('Preview Course',
                          style: TextStyle(fontSize: 11)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        side:
                            const BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Course details - read only display
                    _readOnlyField('Course Title',
                        'Introduction to Web Development'),
                    _readOnlyField('Business Segment', 'Technology'),
                    _readOnlyField('Department', 'Engineering'),
                    _readOnlyField('Client', 'Internal'),
                    _readOnlyField('Program', 'Q1 Training'),
                    _readOnlyField(
                        'Course Language', 'English'),
                    _readOnlyField('Course Level', 'Beginner'),
                    _readOnlyField('Learning Flow', 'Sequential'),
                    _readOnlyField('Duration', '04hrs:52min'),
                    _readOnlyField('Certificate', 'Yes'),
                    const SizedBox(height: 12),
                    const Text('Course Description',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: AppColors.borderGrey),
                      ),
                      child: const Text(
                        'A comprehensive course covering the fundamentals of web development including HTML, CSS, JavaScript, and modern frameworks.',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textDark),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Curriculum Summary',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    _curriculumSummaryItem(
                        'Section 01', 'Introduction to Web Development'),
                    _curriculumSummaryItem(
                        'Section 02', 'Advanced Concepts'),
                    const SizedBox(height: 12),
                    const Text('Copyrights',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    const Text('This course belongs to KHPL',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textDark)),
                  ],
                ),
              ),
            ),
          ),
          // Bottom actions
          _buildBottomActions(context),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    final steps = [
      'Basic Information',
      'Curriculum',
      'Cover Page',
      'Preview & Submit',
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                color: AppColors.primaryBlue,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isActive = stepIndex == 3;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBlue,
                  border: Border.all(
                      color: AppColors.primaryBlue, width: 2),
                ),
                child: Center(
                  child: stepIndex < 3
                      ? const Icon(Icons.check,
                          size: 14, color: Colors.white)
                      : Text('${stepIndex + 1}',
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                ),
              ),
              const SizedBox(height: 4),
              Text(steps[stepIndex],
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isActive
                          ? AppColors.primaryBlue
                          : AppColors.textGrey)),
            ],
          );
        }),
      ),
    );
  }

  Widget _readOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text('$label:',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  Widget _curriculumSummaryItem(String label, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(label,
                style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
          Text(name,
              style: const TextStyle(
                  fontSize: 10, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(top: BorderSide(color: AppColors.borderGrey)),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.amber,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              elevation: 0,
            ),
            child: const Text('Save Draft',
                style: TextStyle(fontSize: 11)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 8),
              elevation: 0,
            ),
            child:
                const Text('Submit', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
