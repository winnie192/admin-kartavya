import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class RmCourseDetailScreen extends StatefulWidget {
  const RmCourseDetailScreen({super.key});

  @override
  State<RmCourseDetailScreen> createState() => _RmCourseDetailScreenState();
}

class _RmCourseDetailScreenState extends State<RmCourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentStep = 0;

  final _commentController = TextEditingController();

  // Per-field review states: 0=none, 1=comment, 2=approved, 3=rejected
  final Map<String, int> _fieldStates = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() => _currentStep = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Course Review', style: TextStyle(fontSize: 16)),
            )
          : null,
      body: Padding(
        padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(20),
          child: Container(
            color: AppColors.background,
            child: Row(
              children: [
                // Sidebar
                if (!isMobile) _buildSidebar(),
                // Main content
                Expanded(
                  child: Column(
                    children: [
                      // Stepper tabs
                      _buildStepperHeader(),
                      // Tab content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildBasicInfoTab(),
                            _buildCurriculumTab(),
                            _buildCoverPageTab(),
                            _buildCopyrightTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      decoration: const BoxDecoration(color: AppColors.darkSidebar),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              'assets/images/kartavya_logo.png',
              width: 140,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Text(
                'KARTAVYA',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: const BoxDecoration(color: AppColors.amber, shape: BoxShape.circle),
                  child: const Center(child: Text('\u{1F44B}', style: TextStyle(fontSize: 16))),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Review Manager',
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Profile completion status',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 9)),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.0,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      valueColor: const AlwaysStoppedAnimation(AppColors.amber),
                      minHeight: 4,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('0%', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 9)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildSidebarItem(Icons.link, 'LMS Link'),
          const SizedBox(height: 4),
          _buildSidebarItem(Icons.build_outlined, 'Tool Kit'),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperHeader() {
    final steps = [
      _StepInfo('Basic Information', Icons.spa_outlined),
      _StepInfo('Curriculum', Icons.play_circle_outline),
      _StepInfo('Cover Page', Icons.description_outlined),
      _StepInfo('Copyright & Submit', Icons.gavel_outlined),
    ];

    return Container(
      color: Colors.white,
      child: Row(
        children: List.generate(steps.length, (i) {
          final isActive = _currentStep == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? AppColors.orange : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      steps[i].icon,
                      size: 16,
                      color: isActive ? AppColors.textDark : AppColors.textGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      steps[i].label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                        color: isActive ? AppColors.textDark : AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── BASIC INFORMATION TAB ───
  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _buildReviewField('Business Segment', 'Cipla', 'business_segment')),
                const SizedBox(width: 16),
                Expanded(child: _buildReviewField('Department', 'Operations', 'department')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildReviewField('Program', 'Cipla_New_Corner...', 'program')),
                const SizedBox(width: 16),
                Expanded(child: _buildReviewField('Customer', 'Cipla', 'customer')),
              ],
            ),
            const SizedBox(height: 16),
            _buildReviewField(
              'Course Title',
              'MIT Introduction to Computer Science and Programming in Python - MIT OpenCourseWare',
              'course_title',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildReviewField('Course Language', 'English', 'course_language')),
                const SizedBox(width: 16),
                Expanded(child: _buildReviewField('Course Level', 'Intermediate', 'course_level')),
                const SizedBox(width: 16),
                Expanded(child: _buildReviewField('Learning Flow', 'SOP\'s', 'learning_flow')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildReviewField('What learning you gain from course ?', 'Policy', 'learning_gain')),
                const SizedBox(width: 16),
                Expanded(child: _buildReviewField('Certificate', 'Yes', 'certificate')),
                const SizedBox(width: 16),
                Expanded(child: _buildReviewField('Duration', '12hrs:23mins', 'duration')),
              ],
            ),
            const SizedBox(height: 16),
            _buildSuggestionsField(),
            const SizedBox(height: 24),
            _buildBottomActions(showSaveDraft: true, showNext: false),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewField(String label, String value, String fieldKey) {
    final state = _fieldStates[fieldKey] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF9FAFB),
          ),
          child: Text(value, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
        ),
        const SizedBox(height: 6),
        _buildFieldActionIcons(fieldKey, state),
      ],
    );
  }

  Widget _buildFieldActionIcons(String fieldKey, int state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _fieldActionIcon(
          Icons.chat_bubble_outline,
          const Color(0xFF9E9E9E),
          state == 1,
          () => setState(() => _fieldStates[fieldKey] = state == 1 ? 0 : 1),
        ),
        const SizedBox(width: 6),
        _fieldActionIcon(
          Icons.check_circle,
          const Color(0xFF4CAF50),
          state == 2,
          () => setState(() => _fieldStates[fieldKey] = state == 2 ? 0 : 2),
        ),
        const SizedBox(width: 6),
        _fieldActionIcon(
          Icons.cancel,
          const Color(0xFFE53935),
          state == 3,
          () => setState(() => _fieldStates[fieldKey] = state == 3 ? 0 : 3),
        ),
      ],
    );
  }

  Widget _fieldActionIcon(IconData icon, Color color, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Icon(
        icon,
        size: 22,
        color: isActive ? color : color.withValues(alpha: 0.35),
      ),
    );
  }

  // Curriculum uses check, X, comment order (matching Figma)
  Widget _buildCurriculumActionIcons(String fieldKey) {
    final state = _fieldStates[fieldKey] ?? 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _fieldActionIcon(Icons.check_circle, const Color(0xFF4CAF50), state == 2,
            () => setState(() => _fieldStates[fieldKey] = state == 2 ? 0 : 2)),
        const SizedBox(width: 4),
        _fieldActionIcon(Icons.cancel, const Color(0xFFE53935), state == 3,
            () => setState(() => _fieldStates[fieldKey] = state == 3 ? 0 : 3)),
        const SizedBox(width: 4),
        _fieldActionIcon(Icons.chat_bubble_outline, const Color(0xFF9E9E9E), state == 1,
            () => setState(() => _fieldStates[fieldKey] = state == 1 ? 0 : 1)),
      ],
    );
  }

  Widget _buildSuggestionsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Do you want to take suggestions?',
                style: TextStyle(fontSize: 12, color: AppColors.textDark)),
            const SizedBox(width: 12),
            _buildFieldActionIcons('suggestions', _fieldStates['suggestions'] ?? 0),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: true,
              onChanged: (_) {},
              activeColor: AppColors.amber,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const Text('Yes', style: TextStyle(fontSize: 12)),
            const SizedBox(width: 16),
            Radio<bool>(
              value: false,
              groupValue: true,
              onChanged: (_) {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const Text('No', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  // ─── CURRICULUM TAB ───
  Widget _buildCurriculumTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildSection('Section 01', 'Introduction to Web Development', [
              _ChapterData('Chapter 01', 'Getting Started with Web Technologies', [
                _TopicData('02hr:12m', 'Topic 01', 'Overview of Web Development'),
                _TopicData('02hr:12m', 'Topic 02', 'Tools and Setup for Beginners'),
              ]),
              _ChapterData('Chapter 02', 'Getting Started with Web Technologies', [
                _TopicData('02hr:12m', 'Topic 01', 'Overview of Web Development'),
              ]),
            ]),
            const SizedBox(height: 12),
            _buildSection('Section 02', 'Introduction to Web Development', [
              _ChapterData('Chapter 01', 'Getting Started with Web Technologies', [
                _TopicData('02hr:12m', 'Topic 01', 'Overview of Web Development'),
                _TopicData('02hr:12m', 'Topic 02', 'Tools and Setup for Beginners'),
              ]),
            ]),
            const SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/review-manager/course-player');
                  },
                  icon: const Icon(Icons.play_circle_outline, size: 18),
                  label: const Text('Play Course', style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildBottomActions(showSaveDraft: true, showNext: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String sectionId, String sectionName, List<_ChapterData> chapters) {
    return Column(
      children: [
        // Section header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.menu, size: 16, color: AppColors.textGrey),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.textGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(sectionId, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(sectionName, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
              ),
              _buildCurriculumActionIcons('section_$sectionId'),
            ],
          ),
        ),
        // Chapters
        ...chapters.map((ch) => _buildChapter(ch, sectionId)),
      ],
    );
  }

  Widget _buildChapter(_ChapterData chapter, String sectionId) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 24, top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              const Icon(Icons.menu, size: 14, color: AppColors.textGrey),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.textGrey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(chapter.id, style: const TextStyle(fontSize: 9, color: AppColors.textDark, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(chapter.name, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
              ),
              _buildCurriculumActionIcons('${sectionId}_${chapter.id}'),
            ],
          ),
        ),
        // Topics
        ...chapter.topics.map((t) => _buildTopic(t, sectionId, chapter.id)),
      ],
    );
  }

  Widget _buildTopic(_TopicData topic, String sectionId, String chapterId) {
    final key = '${sectionId}_${chapterId}_${topic.id}';
    return Container(
      margin: const EdgeInsets.only(left: 48, top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.schedule, size: 14, color: AppColors.orange),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(topic.duration, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          Text('${topic.id} : ', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          Expanded(
            child: Text(topic.name, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
          ),
          _buildCurriculumActionIcons(key),
        ],
      ),
    );
  }

  // ─── COVER PAGE TAB ───
  Widget _buildCoverPageTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Video
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cover Video', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                      const SizedBox(height: 8),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderGrey, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF9FAFB),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_circle_outline, size: 36, color: AppColors.textGrey),
                              SizedBox(height: 6),
                              Text('Upload trailer video', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue,
                          side: const BorderSide(color: AppColors.primaryBlue),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Text('Upload Video', style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Cover Image
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cover Image', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                      const SizedBox(height: 8),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderGrey, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF9FAFB),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.description_outlined, size: 36, color: AppColors.textGrey),
                              SizedBox(height: 6),
                              Text('Upload image in png,jpg formate.', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.upload, size: 14),
                        label: const Text('Upload Image', style: TextStyle(fontSize: 11)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.orange,
                          side: const BorderSide(color: AppColors.orange),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildFieldActionIcons('cover_media', _fieldStates['cover_media'] ?? 0),
            const SizedBox(height: 20),
            _buildTextAreaField('Course Description', 'Enter course description...', 'course_desc'),
            const SizedBox(height: 16),
            _buildPrerequisiteField('System pre-requisite(s)', 'system_prereq'),
            const SizedBox(height: 16),
            _buildPrerequisiteField('Course pre-requisite(s)', 'course_prereq'),
            const SizedBox(height: 24),
            _buildBottomActions(showSaveDraft: true, showNext: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTextAreaField(String label, String hint, String fieldKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
            const SizedBox(width: 8),
            _buildFieldActionIcons(fieldKey, _fieldStates[fieldKey] ?? 0),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 11, color: AppColors.textGrey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(12),
          ),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPrerequisiteField(String label, String fieldKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
            const SizedBox(width: 8),
            _buildFieldActionIcons(fieldKey, _fieldStates[fieldKey] ?? 0),
          ],
        ),
        const SizedBox(height: 6),
        // Items
        for (int i = 0; i < 2; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderGrey),
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF9FAFB),
                    ),
                    child: Text('Pre-requisite item ${i + 1}', style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(4)),
                    child: const Icon(Icons.remove, size: 14, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(4)),
                    child: const Icon(Icons.add, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ─── COPYRIGHT & SUBMIT TAB ───
  Widget _buildCopyrightTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Copyrights section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF93C5FD).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Copyrights', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (_) {}, activeColor: AppColors.primaryBlue, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                      const Text('This course belong to KHPL', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (_) {}, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                      const Text('External Sources', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Please mention the name of external source',
                      hintStyle: const TextStyle(fontSize: 11),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Terms and Conditions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF93C5FD).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Terms and Conditions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(value: true, onChanged: (_) {}, activeColor: AppColors.primaryBlue, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                      const Expanded(
                        child: Text(
                          'By submitting a course to the platform, you (the author) affirm that you own all rights to the course content or have obtained all necessary permissions to use third party materials.',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(value: true, onChanged: (_) {}, activeColor: AppColors.primaryBlue, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                      const Expanded(
                        child: Text(
                          'Content must not contain plagiarized, defamatory, obscene, or illegal content.',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Action icons row
            Row(
              children: [
                _fieldActionIcon(Icons.chat_bubble_outline, const Color(0xFF607D8B), false, () {}),
                const SizedBox(width: 8),
                _fieldActionIcon(Icons.check_circle_outline, AppColors.green, false, () {}),
                const SizedBox(width: 8),
                _fieldActionIcon(Icons.cancel_outlined, AppColors.red, false, () {}),
              ],
            ),
            const SizedBox(height: 16),
            // Add Comment
            const Text(
              'Add Comment(if Any)(You can add comment or suggestion for overall course)',
              style: TextStyle(fontSize: 11, color: AppColors.textGrey),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write your comment here',
                hintStyle: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(12),
              ),
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 24),
            _buildBottomActions(showSaveDraft: true, showSubmit: true),
          ],
        ),
      ),
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to submit?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
            const SizedBox(height: 12),
            const Text(
              'Once you submit the review, the Project Manager will be able to view it.\nPlease confirm if you want to proceed.',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  child: const Text('No', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  child: const Text('Yes', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── BOTTOM ACTIONS ───
  Widget _buildBottomActions({bool showSaveDraft = false, bool showNext = false, bool showSubmit = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.red,
            side: const BorderSide(color: AppColors.red),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Cancel', style: TextStyle(fontSize: 12)),
        ),
        if (showSaveDraft) ...[
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF78909C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Save Draft', style: TextStyle(fontSize: 12)),
          ),
        ],
        if (showNext) ...[
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (_currentStep < 3) {
                _tabController.animateTo(_currentStep + 1);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Next', style: TextStyle(fontSize: 12)),
          ),
        ],
        if (showSubmit) ...[
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _showSubmitDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Submit', style: TextStyle(fontSize: 12)),
          ),
        ],
      ],
    );
  }
}

class _StepInfo {
  final String label;
  final IconData icon;
  const _StepInfo(this.label, this.icon);
}

class _ChapterData {
  final String id;
  final String name;
  final List<_TopicData> topics;
  const _ChapterData(this.id, this.name, this.topics);
}

class _TopicData {
  final String duration;
  final String id;
  final String name;
  const _TopicData(this.duration, this.id, this.name);
}
