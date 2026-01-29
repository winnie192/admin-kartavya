import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/exam_sidebar.dart';

class RelatedExamsScreen extends StatefulWidget {
  const RelatedExamsScreen({super.key});

  @override
  State<RelatedExamsScreen> createState() => _RelatedExamsScreenState();
}

class _RelatedExamsScreenState extends State<RelatedExamsScreen> {
  // Filter state - will be used when filter dialog is implemented
  // String _selectedProgram = '';
  // String _selectedCourse = '';

  final _exams = [
    _ExamData('Assess your skills in writing complex SQL queries.', 'Complete', '18/04/2025 - 21/08/2025', '45 minutes', 25, 109, 82, 3, 31),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Schedule', '18/04/2025 - 21/08/2025', '45 minutes', 25, 20, 0, 0, 0),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Draft', '18/04/2025 - 21/08/2025', '45 minutes', 25, 0, 0, 0, 0),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Complete', '18/04/2025 - 21/08/2025', '45 minutes', 25, 109, 82, 3, 31),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Schedule', '18/04/2025 - 21/08/2025', '45 minutes', 25, 10, 0, 0, 0),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Complete', '18/04/2025 - 21/08/2025', '45 minutes', 25, 109, 82, 3, 31),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Complete', '18/04/2025 - 21/08/2025', '45 minutes', 25, 109, 82, 3, 31),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Draft', '18/04/2025 - 21/08/2025', '45 minutes', 30, 0, 0, 0, 0),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Draft', '18/04/2025 - 21/08/2025', '45 minutes', 32, 109, 0, 0, 0),
    _ExamData('Assess your skills in writing complex SQL queries.', 'Schedule', '18/04/2025 - 21/08/2025', '45 minutes', 25, 50, 0, 0, 0),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const Drawer(child: ExamSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Related Exams', style: TextStyle(fontSize: 16)),
              leading: IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => Navigator.pop(context)),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const ExamSidebar(),
          Expanded(
            child: Column(
              children: [
                // Top bar
                if (!isMobile)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.borderGrey)),
                            child: const Icon(Icons.arrow_back, size: 14, color: AppColors.textDark),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('View Related Exams', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/exams/create'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            elevation: 0,
                          ),
                          child: const Text('Create New', style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                // Filters
                _buildFilters(),
                // Exam list
                Expanded(
                  child: _buildExamGrid(isMobile),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Search
          SizedBox(
            width: 180,
            height: 30,
            child: TextField(
              style: const TextStyle(fontSize: 10),
              decoration: InputDecoration(
                hintText: 'Search ... ',
                hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                prefixIcon: const Icon(Icons.search, size: 14, color: AppColors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
          ),
          const Spacer(),
          // Filter button
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, size: 14),
            label: const Text('Filter', style: TextStyle(fontSize: 10)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textDark,
              side: const BorderSide(color: AppColors.borderGrey),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamGrid(bool isMobile) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: isMobile ? 2.5 : 2.8,
      ),
      itemCount: _exams.length,
      itemBuilder: (context, i) => _buildExamCard(_exams[i]),
    );
  }

  Widget _buildExamCard(_ExamData exam) {
    Color statusColor;
    switch (exam.status) {
      case 'Complete':
        statusColor = AppColors.green;
        break;
      case 'Schedule':
        statusColor = AppColors.primaryBlue;
        break;
      case 'Draft':
        statusColor = AppColors.amber;
        break;
      default:
        statusColor = AppColors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(exam.title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark), maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(exam.status, style: TextStyle(fontSize: 8, color: statusColor, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(exam.dateRange, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          Text(exam.duration, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          const Spacer(),
          Row(
            children: [
              _miniStat(Icons.help_outline, '${exam.questions}', AppColors.primaryBlue),
              const SizedBox(width: 12),
              _miniStat(Icons.people, '${exam.assigned}', AppColors.textDark),
              const SizedBox(width: 12),
              _miniStat(Icons.check_circle_outline, '${exam.completed}', AppColors.green),
              const SizedBox(width: 12),
              _miniStat(Icons.thumb_up_alt_outlined, '${exam.passed}', AppColors.primaryBlue),
              const SizedBox(width: 12),
              _miniStat(Icons.thumb_down_alt_outlined, '${exam.failed}', AppColors.red),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: const Text('View', style: TextStyle(fontSize: 9, color: AppColors.primaryBlue)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStat(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(value, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _ExamData {
  final String title, status, dateRange, duration;
  final int questions, assigned, completed, passed, failed;
  _ExamData(this.title, this.status, this.dateRange, this.duration, this.questions, this.assigned, this.completed, this.passed, this.failed);
}
