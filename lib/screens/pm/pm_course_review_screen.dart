import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'pm_course_action_dialogs.dart';

class PmCourseReviewScreen extends StatelessWidget {
  const PmCourseReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title: const Text('Course Review', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseInfoHeader(),
            const SizedBox(height: 16),
            _buildCurriculumViewer(),
            const SizedBox(height: 16),
            _buildCoverSection(),
            const SizedBox(height: 16),
            _buildCourseDescription(),
            const SizedBox(height: 16),
            _buildPrerequisites(),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseInfoHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MIT Introduction to Computer Science', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('Comprehensive guide to CS fundamentals', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16, runSpacing: 6,
            children: [
              _infoChip('Business Segment', 'Cipla_new'),
              _infoChip('Department', 'Operations'),
              _infoChip('Customer', 'cipla_new_abc'),
              _infoChip('Program', 'cipla_new_abc_222'),
              _infoChip('Language', 'English'),
              _infoChip('Grade Level', 'Intermediate'),
              _infoChip('Learning', 'Self-paced'),
              _infoChip('Duration', '21hrs'),
              _infoChip('Certificate', 'Yes'),
              _infoChip('Suggestions', 'Yes'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        ],
      ),
    );
  }

  Widget _buildCurriculumViewer() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Curriculum', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 10),
          _buildSection('Section 1: Introduction to Programming', [
            _buildChapter('Chapter 1: Getting Started', [
              _TopicData('What is Computer Science?', '00hr:30m'),
              _TopicData('Setting Up Your Environment', '01hr:00m'),
            ]),
            _buildChapter('Chapter 2: Basic Concepts', [
              _TopicData('Variables and Data Types', '02hr:12m'),
              _TopicData('Control Flow', '01hr:45m'),
            ]),
          ]),
          const SizedBox(height: 8),
          _buildSection('Section 2: Data Structures', [
            _buildChapter('Chapter 3: Arrays and Lists', [
              _TopicData('Introduction to Arrays', '01hr:30m'),
              _TopicData('Linked Lists', '02hr:00m'),
            ]),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> chapters) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 12),
      title: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
      children: chapters,
    );
  }

  Widget _buildChapter(String title, List<_TopicData> topics) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 12),
      title: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
      children: topics.map((t) => _buildTopicTile(t)).toList(),
    );
  }

  Widget _buildTopicTile(_TopicData topic) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 12, bottom: 8),
      title: Row(
        children: [
          Text(topic.duration, style: const TextStyle(fontSize: 8, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(child: Text(topic.name, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
        ],
      ),
      children: [
        // Topic descriptions
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Topic Description', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
              const SizedBox(height: 4),
              const Text('This topic covers the fundamental concepts and provides hands-on examples for practical understanding.', style: TextStyle(fontSize: 9, color: AppColors.textDark)),
              const SizedBox(height: 8),
              // Exam info
              Row(
                children: [
                  _miniField('Exam Title', 'Quiz 1'),
                  const SizedBox(width: 8),
                  _miniField('Total Questions', '10'),
                  const SizedBox(width: 8),
                  _miniField('Total Marks', '100'),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _miniField('Time', '30 min'),
                  const SizedBox(width: 8),
                  _miniField('Qualifying Marks', '60'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primaryBlue), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2)),
                    child: const Text('View Uploads', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue)),
                  ),
                  const SizedBox(width: 6),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.amber), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2)),
                    child: const Text('View Exam', style: TextStyle(fontSize: 8, color: AppColors.amber)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
        Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.textDark)),
      ],
    );
  }

  Widget _buildCoverSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cover', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 10),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.image, size: 40, color: AppColors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseDescription() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          SizedBox(height: 8),
          Text(
            'This comprehensive course covers the fundamentals of computer science, including programming concepts, data structures, algorithms, and software engineering principles. Students will gain hands-on experience through practical exercises and projects.',
            style: TextStyle(fontSize: 10, color: AppColors.textGrey, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPrerequisites() {
    final prereqs = [
      'Basic understanding of mathematics',
      'Familiarity with using a computer',
      'No prior programming experience required',
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('System Pre-requisites', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 8),
          ...prereqs.asMap().entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${e.key + 1}. ', style: const TextStyle(fontSize: 10, color: AppColors.textDark, fontWeight: FontWeight.w500)),
                Expanded(child: Text(e.value, style: const TextStyle(fontSize: 10, color: AppColors.textGrey))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          _actionBtn('Edit', AppColors.primaryBlue, Icons.edit, () {}),
          _actionBtn('Rework', AppColors.orange, Icons.replay, () => showPmReworkDialog(context)),
          _actionBtn('Forward', AppColors.primaryBlue, Icons.forward, () => showPmForwardDialog(context)),
          _actionBtn('Visibility', AppColors.amber, Icons.visibility, () => showPmVisibilityDialog(context)),
          _actionBtn('Publish', AppColors.green, Icons.publish, () => showPmPublishDialog(context)),
          _actionBtn('Feedback', AppColors.primaryBlue, Icons.feedback_outlined, () {}),
          _actionBtn('Delete', AppColors.red, Icons.delete_outline, () => showPmDeleteCourseDialog(context)),
          _actionBtn('Course Learners', AppColors.primaryBlue, Icons.people_outline, () {}),
        ],
      ),
    );
  }

  Widget _actionBtn(String label, Color color, IconData icon, VoidCallback onTap) {
    return SizedBox(
      height: 30,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 12),
        label: Text(label, style: const TextStyle(fontSize: 9)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          elevation: 0,
        ),
      ),
    );
  }
}

class _TopicData {
  final String name, duration;
  const _TopicData(this.name, this.duration);
}
