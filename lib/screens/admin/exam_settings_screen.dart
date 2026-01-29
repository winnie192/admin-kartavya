import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ExamSettingsScreen extends StatelessWidget {
  const ExamSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Exam Settings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 16),
          _buildInstructions(),
          const SizedBox(height: 16),
          _buildGradingSystem(),
          const SizedBox(height: 16),
          _buildAssessmentMatrix(),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description_outlined, size: 14, color: AppColors.textDark),
              const SizedBox(width: 6),
              const Text('Instructions (2)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            ],
          ),
          const SizedBox(height: 10),
          _buildInstructionRow(1, 'All questions are mandatory.'),
          _buildInstructionRow(2, 'Each question carries equal marks.'),
          const SizedBox(height: 8),
          Row(
            children: [
              _addRemoveBtn(Icons.remove, AppColors.red),
              const SizedBox(width: 6),
              _addRemoveBtn(Icons.add, AppColors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionRow(int num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 16, child: Text('$num.', style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
              child: Align(alignment: Alignment.centerLeft, child: Text(text, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addRemoveBtn(IconData icon, Color color) {
    return Container(
      width: 20, height: 20,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
      child: Icon(icon, color: Colors.white, size: 14),
    );
  }

  Widget _buildGradingSystem() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Grading System', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 10),
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4)),
            child: Row(children: [
              const Expanded(flex: 2, child: Text('Question Type', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              const Expanded(flex: 2, child: Text('Time (minutes)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              const Expanded(flex: 1, child: Text('Marks', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
            ]),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 12),
            label: const Text('Add', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentMatrix() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Assessment Matrix', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4)),
            child: Row(children: [
              const Expanded(flex: 2, child: Text('Assessment Category', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              const Expanded(flex: 2, child: Text('Marks Range', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
            ]),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 12),
            label: const Text('Add', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
