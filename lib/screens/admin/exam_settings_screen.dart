import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ExamSettingsScreen extends StatefulWidget {
  const ExamSettingsScreen({super.key});

  @override
  State<ExamSettingsScreen> createState() => _ExamSettingsScreenState();
}

class _ExamSettingsScreenState extends State<ExamSettingsScreen> {
  final List<_AssessmentRow> _assessmentRows = [
    _AssessmentRow('Aspirant', '0 - 40'),
    _AssessmentRow('Performer', '41 - 60'),
    _AssessmentRow('Front Runner', '61 - 80'),
    _AssessmentRow('Achiever', '81 - 100'),
  ];

  final List<_GradingRow> _gradingRows = [];

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
          Row(children: [
            const Icon(Icons.description_outlined, size: 14, color: AppColors.textDark),
            const SizedBox(width: 6),
            const Text('Instructions (2)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          ]),
          const SizedBox(height: 10),
          _buildInstructionRow(1, 'All questions are mandatory.'),
          _buildInstructionRow(2, 'Each question carries equal marks.'),
          const SizedBox(height: 8),
          Row(children: [
            _addRemoveBtn(Icons.remove, AppColors.red),
            const SizedBox(width: 6),
            _addRemoveBtn(Icons.add, AppColors.green),
          ]),
        ],
      ),
    );
  }

  Widget _buildInstructionRow(int num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
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
      ]),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4)),
            child: Row(children: const [
              Expanded(flex: 2, child: Text('Question Type', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              Expanded(flex: 2, child: Text('Time (minutes)', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              Expanded(flex: 1, child: Text('Marks', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              SizedBox(width: 30),
            ]),
          ),
          ..._gradingRows.asMap().entries.map((e) => _buildGradingRowWidget(e.key)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => setState(() => _gradingRows.add(_GradingRow('', '', ''))),
            icon: const Icon(Icons.add, size: 12),
            label: const Text('Add', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildGradingRowWidget(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(children: [
        Expanded(flex: 2, child: _smallField('e.g. MCQ')),
        const SizedBox(width: 6),
        Expanded(flex: 2, child: _smallField('e.g. 30')),
        const SizedBox(width: 6),
        Expanded(flex: 1, child: _smallField('e.g. 10')),
        const SizedBox(width: 4),
        InkWell(
          onTap: () => setState(() => _gradingRows.removeAt(index)),
          child: Container(
            width: 20, height: 20,
            decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(3)),
            child: const Icon(Icons.remove, color: Colors.white, size: 14),
          ),
        ),
      ]),
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
            child: Row(children: const [
              Expanded(flex: 2, child: Text('Assessment Category', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              Expanded(flex: 2, child: Text('Marks Range', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey))),
              SizedBox(width: 30),
            ]),
          ),
          ..._assessmentRows.asMap().entries.map((e) => _buildAssessmentRowWidget(e.key, e.value)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => setState(() => _assessmentRows.add(_AssessmentRow('Other', ''))),
            icon: const Icon(Icons.add, size: 12),
            label: const Text('Add', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentRowWidget(int index, _AssessmentRow row) {
    final categoryColors = {
      'Aspirant': AppColors.red,
      'Performer': AppColors.orange,
      'Front Runner': AppColors.primaryBlue,
      'Achiever': AppColors.green,
      'Other': AppColors.grey,
    };
    final color = categoryColors[row.category] ?? AppColors.grey;

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: row.category,
                    isDense: true,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 10, color: AppColors.textDark),
                    items: ['Aspirant', 'Performer', 'Front Runner', 'Achiever', 'Other']
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _assessmentRows[index] = _AssessmentRow(v, row.marksRange));
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(flex: 2, child: _smallFieldWithValue(row.marksRange)),
        const SizedBox(width: 4),
        InkWell(
          onTap: () => setState(() => _assessmentRows.removeAt(index)),
          child: Container(
            width: 20, height: 20,
            decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(3)),
            child: const Icon(Icons.remove, color: Colors.white, size: 14),
          ),
        ),
      ]),
    );
  }

  Widget _smallField(String hint) {
    return SizedBox(
      height: 30,
      child: TextField(
        style: const TextStyle(fontSize: 10),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
        ),
      ),
    );
  }

  Widget _smallFieldWithValue(String value) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
      child: Align(alignment: Alignment.centerLeft, child: Text(value.isEmpty ? '-' : value, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
    );
  }
}

class _AssessmentRow {
  final String category, marksRange;
  _AssessmentRow(this.category, this.marksRange);
}

class _GradingRow {
  final String questionType, time, marks;
  _GradingRow(this.questionType, this.time, this.marks);
}
