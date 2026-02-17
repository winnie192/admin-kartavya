import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class AuthorCreateCourseScreen extends StatefulWidget {
  const AuthorCreateCourseScreen({super.key});

  @override
  State<AuthorCreateCourseScreen> createState() =>
      _AuthorCreateCourseScreenState();
}

class _AuthorCreateCourseScreenState extends State<AuthorCreateCourseScreen> {
  int _currentStep = 0;
  final _steps = [
    'Basic Information',
    'Curriculum',
    'Cover Page',
    'Preview & Submit',
  ];
  bool _suggestionsYes = true;
  int _copyrightSource = 0; // 0=KHPL, 1=External
  bool _termsAccepted1 = true;
  bool _termsAccepted2 = false;

  // Curriculum state
  final List<_SectionData> _sections = [
    _SectionData('Introduction to Web Development', [
      _ChapterData('Getting Started with Web Technologies', [
        _TopicData('Topic 01', 'Overview of Web Development', '02hr:12m'),
      ]),
    ]),
    _SectionData('Advanced Concepts', [
      _ChapterData('Deep Dive into Frameworks', [
        _TopicData('Topic 01', 'Overview of Web Development', '01hr:30m'),
        _TopicData('Topic 02', 'Tools and Setup for Beginners', '02hr:00m'),
      ]),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: isMobile ? AppColors.darkSidebar : Colors.white,
        foregroundColor: isMobile ? Colors.white : AppColors.textDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create Course', style: TextStyle(fontSize: 16)),
      ),
      body: Column(
        children: [
          // Stepper header
          _buildStepperHeader(),
          const Divider(height: 1, color: AppColors.borderGrey),
          // Content
          Expanded(child: _buildStepContent()),
          // Bottom actions
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildStepperHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            return Expanded(
              child: Container(
                height: 2,
                color: (i ~/ 2) < _currentStep
                    ? AppColors.primaryBlue
                    : AppColors.borderGrey,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isActive = stepIndex == _currentStep;
          final isCompleted = stepIndex < _currentStep;
          return GestureDetector(
            onTap: () => setState(() => _currentStep = stepIndex),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive || isCompleted
                        ? AppColors.primaryBlue
                        : Colors.white,
                    border: Border.all(
                      color: isActive || isCompleted
                          ? AppColors.primaryBlue
                          : AppColors.borderGrey,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check,
                            size: 14, color: Colors.white)
                        : Text('${stepIndex + 1}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isActive
                                    ? Colors.white
                                    : AppColors.textGrey)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(_steps[stepIndex],
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w400,
                        color: isActive
                            ? AppColors.primaryBlue
                            : AppColors.textGrey)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfo();
      case 1:
        return _buildCurriculum();
      case 2:
        return _buildCoverPage();
      case 3:
        return _buildCopyrightSubmit();
      default:
        return const SizedBox();
    }
  }

  // ─── Step 1: Basic Information ───

  Widget _buildBasicInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Basic Information',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 16),
          _buildRow([
            _buildDropdown('Business Segment'),
            _buildDropdown('Department'),
          ]),
          const SizedBox(height: 12),
          _buildRow([
            _buildDropdown('Client'),
            _buildDropdown('Program'),
          ]),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.red,
                  side: const BorderSide(color: AppColors.red),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
                child: const Text('View Related Course',
                    style: TextStyle(fontSize: 10)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 0,
                ),
                child:
                    const Text('Create New', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTextField('Course Title', 'Enter course title'),
          const SizedBox(height: 12),
          _buildRow([
            _buildDropdown('Course Language'),
            _buildDropdown('Course Level'),
          ]),
          const SizedBox(height: 12),
          _buildRow([
            _buildDropdown('Learning Flow'),
            const SizedBox(),
          ]),
          const SizedBox(height: 12),
          _buildRow([
            _buildTextField(
                'What learning you gain from course?', 'Describe learnings'),
            _buildDropdown('Certificate'),
          ]),
          const SizedBox(height: 12),
          _buildTextField('Duration', '04hrs:52min'),
          const SizedBox(height: 16),
          const Text('Do you want to take suggestions?',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Radio<bool>(
                    value: true,
                    groupValue: _suggestionsYes,
                    onChanged: (v) =>
                        setState(() => _suggestionsYes = v ?? true),
                    activeColor: AppColors.primaryBlue),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.comment, size: 12, color: AppColors.green),
              const SizedBox(width: 2),
              const Text('Yes', style: TextStyle(fontSize: 10)),
              const SizedBox(width: 16),
              SizedBox(
                width: 20,
                height: 20,
                child: Radio<bool>(
                    value: false,
                    groupValue: _suggestionsYes,
                    onChanged: (v) =>
                        setState(() => _suggestionsYes = v ?? false),
                    activeColor: AppColors.primaryBlue),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.close, size: 12, color: AppColors.red),
              const SizedBox(width: 2),
              const Text('No', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Step 2: Curriculum ───

  Widget _buildCurriculum() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Curriculum',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 16),
          ...List.generate(_sections.length, (si) => _buildSectionItem(si)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _sections
                      .add(_SectionData('New Section', [_ChapterData('New Chapter', [])]));
                });
              },
              icon: const Icon(Icons.add, size: 14),
              label:
                  const Text('Add Section', style: TextStyle(fontSize: 11)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, '/author/course-preview'),
            icon: const Icon(Icons.play_arrow, size: 14),
            label:
                const Text('Play Course', style: TextStyle(fontSize: 10)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: const BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionItem(int sectionIndex) {
    final section = _sections[sectionIndex];
    final sectionNum =
        (sectionIndex + 1).toString().padLeft(2, '0');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border:
            Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryBlue.withValues(alpha: 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(sectionNum,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: TextField(
                    controller:
                        TextEditingController(text: section.name),
                    style: const TextStyle(fontSize: 10),
                    decoration: InputDecoration(
                      hintText: 'Type section name',
                      hintStyle: const TextStyle(
                          fontSize: 10, color: AppColors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: AppColors.borderGrey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: AppColors.borderGrey)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  setState(() {
                    section.chapters
                        .add(_ChapterData('New Chapter', []));
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.add,
                      size: 14, color: AppColors.green),
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  setState(() => _sections.removeAt(sectionIndex));
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.delete,
                      size: 14, color: AppColors.red),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...List.generate(section.chapters.length,
              (ci) => _buildChapterItem(sectionIndex, ci)),
        ],
      ),
    );
  }

  Widget _buildChapterItem(int sectionIndex, int chapterIndex) {
    final chapter = _sections[sectionIndex].chapters[chapterIndex];
    final chapterNum =
        (chapterIndex + 1).toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(chapterNum,
                    style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 28,
                  child: TextField(
                    controller:
                        TextEditingController(text: chapter.name),
                    style: const TextStyle(fontSize: 10),
                    decoration: InputDecoration(
                      hintText: 'Type chapter name',
                      hintStyle: const TextStyle(
                          fontSize: 10, color: AppColors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: AppColors.borderGrey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                              color: AppColors.borderGrey)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  setState(() {
                    chapter.topics.add(_TopicData(
                        'Topic ${chapter.topics.length + 1}',
                        'New Topic',
                        '00hr:00m'));
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.add,
                      size: 12, color: AppColors.green),
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  setState(() =>
                      _sections[sectionIndex].chapters.removeAt(chapterIndex));
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.delete,
                      size: 12, color: AppColors.red),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...List.generate(chapter.topics.length,
              (ti) => _buildTopicItem(sectionIndex, chapterIndex, ti)),
        ],
      ),
    );
  }

  Widget _buildTopicItem(
      int sectionIndex, int chapterIndex, int topicIndex) {
    final topic =
        _sections[sectionIndex].chapters[chapterIndex].topics[topicIndex];

    return Padding(
      padding: const EdgeInsets.only(left: 32, bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.access_time, size: 10, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(topic.duration,
              style:
                  const TextStyle(fontSize: 8, color: AppColors.textGrey)),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(topic.label,
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(topic.name,
                style: const TextStyle(
                    fontSize: 9, color: AppColors.textDark)),
          ),
          InkWell(
            onTap: () {},
            child: const Icon(Icons.edit,
                size: 12, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () {
              setState(() => _sections[sectionIndex]
                  .chapters[chapterIndex]
                  .topics
                  .removeAt(topicIndex));
            },
            child: const Icon(Icons.delete, size: 12, color: AppColors.red),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.flag, size: 12, color: AppColors.amber),
          const SizedBox(width: 4),
          const Icon(Icons.check_circle,
              size: 12, color: AppColors.green),
          const SizedBox(width: 2),
          const Icon(Icons.cancel, size: 12, color: AppColors.red),
        ],
      ),
    );
  }

  // ─── Step 3: Cover Page ───

  Widget _buildCoverPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cover Page',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 16),
          // Cover Video
          const Text('Cover Video',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('Upload trailer video',
              style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(height: 6),
          _buildUploadBox(Icons.play_circle_outline, 'Upload Video',
              AppColors.primaryBlue),
          const SizedBox(height: 16),
          // Cover Image
          const Text('Cover Image',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          const Text('Upload image & drag drop file...',
              style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
          const SizedBox(height: 6),
          _buildUploadBox(
              Icons.description_outlined, 'Upload Image', AppColors.orange),
          const SizedBox(height: 16),
          // Course Description
          _buildTextArea('Course Description', 'Enter course description'),
          const SizedBox(height: 16),
          // System pre-requisite
          const Text('System pre-requisite(s)',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          _buildNumberedField('01', 'Enter system pre-requisite...'),
          const SizedBox(height: 6),
          _buildNumberedField('02', 'Enter system pre-requisite...'),
          const SizedBox(height: 16),
          // Course pre-requisite
          const Text('Course pre-requisite(s)',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          _buildNumberedField('01', 'Enter course pre-requisite...'),
          const SizedBox(height: 16),
          // Guideline
          _buildTextField(
              'Guideline to run course(s)', 'Enter guidelines'),
        ],
      ),
    );
  }

  Widget _buildUploadBox(
      IconData icon, String label, Color accentColor) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.borderGrey, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.background,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: accentColor),
            const SizedBox(height: 4),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: accentColor,
                side: BorderSide(color: accentColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
              ),
              child: Text(label, style: const TextStyle(fontSize: 9)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberedField(String number, String hint) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(number,
                style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w500)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 30,
            child: TextField(
              style: const TextStyle(fontSize: 10),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(fontSize: 10, color: AppColors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: AppColors.borderGrey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: AppColors.borderGrey)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Step 4: Copyright & Submit ───

  Widget _buildCopyrightSubmit() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Copyrights section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Copyrights',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _copyrightSource == 0,
                        onChanged: (v) =>
                            setState(() => _copyrightSource = 0),
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('This course belong to KHPL',
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _copyrightSource == 1,
                        onChanged: (v) =>
                            setState(() => _copyrightSource = 1),
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('External Sources',
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
                if (_copyrightSource == 1) ...[
                  const SizedBox(height: 8),
                  _buildTextField('Please mention the name of external source',
                      'Enter source name'),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Terms and Conditions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Terms and Conditions',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _termsAccepted1,
                        onChanged: (v) =>
                            setState(() => _termsAccepted1 = v ?? false),
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'By submitting a course to the platform, you (the author) affirm that you own all rights to the course content or have obtained all necessary permissions to use third-party materials.',
                        style: TextStyle(fontSize: 9, color: AppColors.textGrey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _termsAccepted2,
                        onChanged: (v) =>
                            setState(() => _termsAccepted2 = v ?? false),
                        activeColor: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Courses must not contain plagiarized, defamatory, obscene, or illegal content.',
                        style: TextStyle(fontSize: 9, color: AppColors.textGrey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _circleAction(Icons.chat, AppColors.primaryBlue),
              const SizedBox(width: 12),
              _circleAction(Icons.check, AppColors.green),
              const SizedBox(width: 12),
              _circleAction(Icons.close, AppColors.red),
            ],
          ),
          const SizedBox(height: 16),
          // Comment area
          const Text('Add Comment(if Any)',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          _buildTextArea('', 'Write your comment here'),
        ],
      ),
    );
  }

  Widget _circleAction(IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.1),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  // ─── Bottom Actions ───

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.borderGrey)),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              elevation: 0,
            ),
            child: const Text('Cancel', style: TextStyle(fontSize: 11)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.amber,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              elevation: 0,
            ),
            child:
                const Text('Save Draft', style: TextStyle(fontSize: 11)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              if (_currentStep < 3) {
                setState(() => _currentStep++);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              elevation: 0,
            ),
            child: Text(_currentStep == 3 ? 'Submit' : 'Next',
                style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  // ─── Shared Helpers ───

  Widget _buildRow(List<Widget> children) {
    return Row(
      children: children
          .map((c) => Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: c)))
          .toList(),
    );
  }

  Widget _buildDropdown(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark)),
        const SizedBox(height: 4),
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.grey)),
              ),
              const Icon(Icons.keyboard_arrow_down,
                  size: 16, color: AppColors.textGrey),
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
        if (label.isNotEmpty)
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
        if (label.isNotEmpty) const SizedBox(height: 4),
        SizedBox(
          height: 34,
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
        if (label.isNotEmpty) const SizedBox(height: 4),
        TextField(
          maxLines: 3,
          style: const TextStyle(fontSize: 10),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(fontSize: 10, color: AppColors.grey),
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    const BorderSide(color: AppColors.borderGrey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    const BorderSide(color: AppColors.borderGrey)),
          ),
        ),
      ],
    );
  }
}

class _SectionData {
  String name;
  final List<_ChapterData> chapters;
  _SectionData(this.name, this.chapters);
}

class _ChapterData {
  String name;
  final List<_TopicData> topics;
  _ChapterData(this.name, this.topics);
}

class _TopicData {
  final String label;
  final String name;
  final String duration;
  _TopicData(this.label, this.name, this.duration);
}
