import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  String? selectedProgram;
  String? selectedCourse;
  final titleController = TextEditingController(text: 'UI/UX Beginner Exam');
  final descController = TextEditingController(text: 'UI/UX Beginner Exam');
  bool certificateYes = true;
  List<String> instructions = [
    'All questions are mandatory.',
    'Each question carries equal marks.',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Information',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdownRow(context),
          const SizedBox(height: 14),
          _buildTextField('Exam Title', titleController),
          const SizedBox(height: 14),
          _buildTextArea('Exam Description', descController),
          const SizedBox(height: 14),
          _buildCertificateToggle(),
          const SizedBox(height: 14),
          _buildInstructions(),
          const SizedBox(height: 14),
          _buildPassingCriteria(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    if (isMobile) {
      return Column(
        children: [
          _buildDropdown('Select Program', selectedProgram, (v) {
            setState(() => selectedProgram = v);
          }),
          const SizedBox(height: 12),
          _buildDropdown('Select Course', selectedCourse, (v) {
            setState(() => selectedCourse = v);
          }),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: _buildDropdown('Select Program', selectedProgram, (v) {
            setState(() => selectedProgram = v);
          }),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDropdown('Select Course', selectedCourse, (v) {
            setState(() => selectedCourse = v);
          }),
        ),
      ],
    );
  }

  Widget _buildDropdown(
      String label, String? value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark)),
        const SizedBox(height: 6),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              isDense: true,
              hint: Text(label,
                  style: const TextStyle(fontSize: 12, color: AppColors.grey)),
              value: value,
              items: ['Option 1', 'Option 2', 'Option 3']
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 12))))
                  .toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark)),
        const SizedBox(height: 6),
        SizedBox(
          height: 38,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 2,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCertificateToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Certificate',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark)),
        const SizedBox(height: 4),
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Radio<bool>(
                value: true,
                groupValue: certificateYes,
                onChanged: (v) => setState(() => certificateYes = v!),
                activeColor: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(width: 4),
            const Text('Yes', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 20),
            SizedBox(
              width: 24,
              height: 24,
              child: Radio<bool>(
                value: false,
                groupValue: certificateYes,
                onChanged: (v) => setState(() => certificateYes = v!),
                activeColor: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(width: 4),
            const Text('No', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.description_outlined,
                size: 14, color: AppColors.textDark),
            const SizedBox(width: 6),
            Text(
              'Instructions  (${instructions.length})',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...instructions.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  child: Text('${entry.key + 1}.',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textDark)),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: TextField(
                      controller: TextEditingController(text: entry.value),
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: AppColors.borderGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: AppColors.borderGrey),
                        ),
                      ),
                      onChanged: (v) => instructions[entry.key] = v,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 4),
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => instructions.add('')),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Icon(Icons.remove, color: Colors.white, size: 14),
              ),
            ),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () => setState(() => instructions.add('')),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPassingCriteria() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Passing Criteria %',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildCriteriaBox('0 - 49', 'Aspirant', AppColors.red),
            const SizedBox(width: 6),
            _buildCriteriaBox('50 - 64', 'Performer', AppColors.orange),
            const SizedBox(width: 6),
            _buildCriteriaBox('65 - 99', 'Front Runner', AppColors.primaryBlue),
            const SizedBox(width: 6),
            _buildCriteriaBox('100', 'Achiever', AppColors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildCriteriaBox(String range, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderGrey),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(range,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style:
                    const TextStyle(fontSize: 9, color: AppColors.textGrey)),
          ],
        ),
      ),
    );
  }
}
