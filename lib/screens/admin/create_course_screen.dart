import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/admin_sidebar.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  int currentStep = 0; // 0=Basic Info, 1=Curriculum, 2=Cover Page, 3=Copyright & Submit
  final tabs = ['Basic Information', 'Curriculum', 'Cover Page', 'Copyright & Submit'];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const Drawer(child: AdminSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Create Course', style: TextStyle(fontSize: 16)),
              leading: IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => Navigator.pop(context)),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const AdminSidebar(),
          Expanded(
            child: Padding(
              padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(16),
                  boxShadow: isMobile ? [] : [BoxShadow(color: AppColors.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Column(
                  children: [
                    if (!isMobile)
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.borderGrey)),
                              child: const Icon(Icons.arrow_back, size: 14, color: AppColors.textDark),
                            ),
                          ),
                        ),
                      ),
                    // Tab bar
                    _buildTabBar(),
                    const Divider(height: 1, color: AppColors.borderGrey),
                    // Content
                    Expanded(
                      child: currentStep == 0
                          ? _buildBasicInfo()
                          : currentStep == 1
                              ? _buildCurriculum()
                              : currentStep == 2
                                  ? _buildCoverPage()
                                  : _buildCopyrightSubmit(),
                    ),
                    // Bottom actions
                    _buildBottomActions(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: tabs.asMap().entries.map((e) {
          final isActive = e.key == currentStep;
          return GestureDetector(
            onTap: () => setState(() => currentStep = e.key),
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
              ),
              child: Text(e.value, style: TextStyle(fontSize: 10, color: isActive ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.w500)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Basic Information', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 16),
          _buildRow([_buildDropdown('Business Segment'), _buildDropdown('Program')]),
          const SizedBox(height: 12),
          _buildRow([_buildDropdown('Profile'), _buildDropdown('Cate., New_Course...')]),
          const SizedBox(height: 12),
          _buildTextField('Course Title', 'MIT Introduction to Computer Science and Pr...'),
          const SizedBox(height: 12),
          _buildTextArea('Course Description', 'Description...'),
          const SizedBox(height: 12),
          _buildRow([_buildDropdown('Course Language'), _buildDropdown('Course Level')]),
          const SizedBox(height: 12),
          _buildRow([_buildDropdown('Learning Flow'), _buildTextField2('Duration', '04hrs:52min')]),
          const SizedBox(height: 12),
          _buildRow([_buildCertificateToggle(), const SizedBox()]),
        ],
      ),
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Row(
      children: children.map((c) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: c))).toList(),
    );
  }

  Widget _buildDropdown(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        const SizedBox(height: 4),
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              Expanded(child: Text(label, style: const TextStyle(fontSize: 10, color: AppColors.grey))),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textGrey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        const SizedBox(height: 4),
        SizedBox(
          height: 34,
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: hint, hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField2(String label, String hint) {
    return _buildTextField(label, hint);
  }

  Widget _buildTextArea(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        const SizedBox(height: 4),
        TextField(
          maxLines: 2,
          style: const TextStyle(fontSize: 10),
          decoration: InputDecoration(
            hintText: hint, hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
          ),
        ),
      ],
    );
  }

  Widget _buildCertificateToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Certificate', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        const SizedBox(height: 4),
        Row(children: [
          SizedBox(width: 20, height: 20, child: Radio<bool>(value: false, groupValue: false, onChanged: (_) {}, activeColor: AppColors.primaryBlue)),
          const SizedBox(width: 4),
          const Text('No', style: TextStyle(fontSize: 10)),
        ]),
      ],
    );
  }

  Widget _buildCurriculum() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Curriculum', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 16),
          _buildSection('Section 01 :', 'Introduction to Web Development', [
            _buildChapter('Chapter 01 :', 'Getting Started with Web Technologies', [
              _buildTopic('EditView', 'Topic 01 :', 'Overview of Web Development'),
            ]),
          ]),
          const SizedBox(height: 10),
          _buildSection('Section 02 :', 'Introduction to Web Development', [
            _buildChapter('Chapter 01 :', 'Getting Started with Web Technologies', [
              _buildTopic('EditView', 'Topic 01 :', 'Overview of Web Development'),
              _buildTopic('EditView', 'Topic 02 :', 'Tools and Setup for Beginners'),
            ]),
          ]),
          const SizedBox(height: 16),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow, size: 12),
                label: const Text('Play Course', style: TextStyle(fontSize: 10)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.red,
                  side: const BorderSide(color: AppColors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String label, String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryBlue.withValues(alpha: 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
              child: Text(label, style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
          ]),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildChapter(String label, String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(4)),
              child: Text(label, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
          ]),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTopic(String action, String label, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, bottom: 4),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.circular(3)),
          child: Text(action, style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(3)),
          child: Text(label, style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 6),
        Text(title, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
      ]),
    );
  }

  Widget _buildCoverPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cover Page', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 16),
          // Cover Video
          const Text('Cover Video', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('Upload trailer video', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(height: 6),
          _uploadBox('Upload Video', Icons.videocam),
          const SizedBox(height: 16),
          // Cover Image
          const Text('Cover Image', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('Upload image in png, jpg format.', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(height: 6),
          _uploadBox('Upload Image', Icons.image),
          const SizedBox(height: 16),
          // Course Description
          _buildTextArea('Course Descriptions', 'Enter your course description'),
          const SizedBox(height: 16),
          // System pre-requisite
          const Text('System pre-requisite(2)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 6),
          _numberedField('01', 'Enter guidelines...'),
          const SizedBox(height: 6),
          _numberedField('02', 'Enter guidelines...'),
          const SizedBox(height: 16),
          // Course pre-requisite
          const Text('Course pre-requisite(1)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 6),
          _numberedField('01', 'Enter guidelines...'),
        ],
      ),
    );
  }

  Widget _uploadBox(String label, IconData icon) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.background,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.primaryBlue),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue)),
          ],
        ),
      ),
    );
  }

  Widget _numberedField(String number, String hint) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
          child: Center(child: Text(number, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, fontWeight: FontWeight.w500))),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
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
          ),
        ),
      ],
    );
  }

  Widget _buildCopyrightSubmit() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Terms and Conditions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 16),
          const Text('Copyrights', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 8),
          const Text(
            'By submitting a course to the platform, you (the author) affirm that you own all rights to the course content or have obtained all necessary permissions to use third-party materials.',
            style: TextStyle(fontSize: 9, color: AppColors.textGrey),
          ),
          const SizedBox(height: 6),
          const Text(
            'Courses must not contain plagiarized, defamatory, obscene, or illegal content.',
            style: TextStyle(fontSize: 9, color: AppColors.textGrey),
          ),
          const SizedBox(height: 16),
          // External sources
          const Text('Please mention the name of external source', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Row(
            children: [
              SizedBox(width: 20, height: 20, child: Radio<int>(value: 0, groupValue: 0, onChanged: (_) {}, activeColor: AppColors.primaryBlue)),
              const SizedBox(width: 4),
              const Text('This course belong to KHPL', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 20, height: 20, child: Radio<int>(value: 1, groupValue: 0, onChanged: (_) {}, activeColor: AppColors.primaryBlue)),
              const SizedBox(width: 4),
              const Text('External Sources', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 16),
          // Comment
          const Text('Add Comment(if Any)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('(You can add comment or suggestion for overall course)', style: TextStyle(fontSize: 8, color: AppColors.textGrey)),
          const SizedBox(height: 6),
          _buildTextArea('', 'Write your comment here'),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.borderGrey))),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), elevation: 0),
            child: const Text('Cancel', style: TextStyle(fontSize: 11)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), elevation: 0),
            child: const Text('Save Draft', style: TextStyle(fontSize: 11)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              if (currentStep < 3) setState(() => currentStep++);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8), elevation: 0),
            child: Text(currentStep == 3 ? 'Submit' : 'Next', style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
