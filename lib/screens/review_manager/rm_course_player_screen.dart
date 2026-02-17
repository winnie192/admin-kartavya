import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class RmCoursePlayerScreen extends StatefulWidget {
  const RmCoursePlayerScreen({super.key});

  @override
  State<RmCoursePlayerScreen> createState() => _RmCoursePlayerScreenState();
}

class _RmCoursePlayerScreenState extends State<RmCoursePlayerScreen> {
  int _expandedSection = 0;
  double _seekValue = 0.15;

  final _sections = [
    _SectionData(
      'Section 01', 'Understanding the Fundamentals', const Color(0xFF666666),
      chapters: [
        _ChapterData('Chapter 01', 'Introduction to UI/UX', [
          _TopicData('Topic 01', 'What is UI and UX?', '12hrs:23m', Colors.green),
          _TopicData('Topic 02', 'Difference Between UI and UX', '12hrs:23m', Colors.green),
        ]),
        _ChapterData('Chapter 01a', 'User Research Basics', []),
        _ChapterData('Chapter 01b', 'Principles & Heuristics', []),
      ],
    ),
    _SectionData(
      'Section 02', 'UI Design & Visual Elements', const Color(0xFF8B8B00),
      chapters: [
        _ChapterData('Chapter 01', 'Interface Design Essentials', [
          _TopicData('Topic 01', 'UI Elements (Buttons, Forms, Menus)', '12hrs:23m', Colors.orange),
          _TopicData('Topic 02', 'UX Elements (User Research, User Stories, User Empathy, User Emotions)', '12hrs:23m', Colors.orange),
        ]),
        _ChapterData('Chapter 02', 'Wireframing & Prototyping', [
          _TopicData('Topic 01', 'Tools for Wireframing (Figma, Adobe XD)', '12hrs:23m', Colors.orange),
          _TopicData('Topic 02', 'Low Fidelity vs. High Fidelity', '12hrs:23m', Colors.orange),
          _TopicData('Topic 03', 'Building Reusable Components', '12hrs:23m', Colors.orange),
        ]),
      ],
    ),
    _SectionData(
      'Section 03', 'Exams & Assessment', const Color(0xFF4CAF50),
      chapters: [
        _ChapterData('Chapter 01', 'The Basics of UI/UX beginning', [
          _TopicData('Topic 01', 'Multiple Choice Quiz: Fundamentals', '12hrs:23m', Colors.orange),
          _TopicData('Topic 02', 'Case Study Questions', '12hrs:23m', Colors.red, hasLock: true),
        ]),
      ],
    ),
    _SectionData(
      'Section 04', 'Notes', const Color(0xFFE53935),
      chapters: [
        _ChapterData('Chapter 01', 'The UI/UX beginning', [
          _TopicData('Topic 01', 'Notes on how to start with ui/ux', '12hrs:23m', Colors.red, hasLock: true),
        ]),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Padding(
        padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(20),
          child: Container(
            color: AppColors.background,
            child: Column(
              children: [
                // Top bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: AppColors.topNavBg,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 12),
                      const Text('Course Preview',
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildVideoPlayer(),
                        _buildCourseInfo(),
                        _buildSectionAccordion(),
                        _buildBottomActions(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      color: Colors.black,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            // Video placeholder with AI image
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade900,
                    Colors.black,
                    Colors.blue.shade800,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.smart_toy_outlined, size: 64, color: Colors.blue.shade300),
                    const SizedBox(height: 8),
                    Text('AI Course Preview',
                        style: TextStyle(color: Colors.blue.shade200, fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            // Controls overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                  ),
                ),
                child: Column(
                  children: [
                    // Seek bar
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                        trackHeight: 3,
                        activeTrackColor: AppColors.primaryBlue,
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                        thumbColor: AppColors.primaryBlue,
                      ),
                      child: Slider(
                        value: _seekValue,
                        onChanged: (v) => setState(() => _seekValue = v),
                      ),
                    ),
                    // Control buttons
                    Row(
                      children: [
                        const Icon(Icons.play_arrow, color: Colors.white, size: 24),
                        const SizedBox(width: 12),
                        const Icon(Icons.skip_previous, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        const Icon(Icons.skip_next, color: Colors.white, size: 20),
                        const SizedBox(width: 12),
                        const Text('1:25 / 1:19:15',
                            style: TextStyle(color: Colors.white, fontSize: 11)),
                        const Spacer(),
                        const Icon(Icons.volume_up, color: Colors.white, size: 18),
                        const SizedBox(width: 12),
                        const Icon(Icons.settings, color: Colors.white, size: 18),
                        const SizedBox(width: 12),
                        const Icon(Icons.fullscreen, color: Colors.white, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Top right icons
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                children: [
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bookmark_border, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.picture_in_picture, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UI/UX for beginner with Gen AI (Get Ready For Future)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionAccordion() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: _sections.length,
        itemBuilder: (context, index) {
          final section = _sections[index];
          final isExpanded = _expandedSection == index;

          return Column(
            children: [
              // Section header
              InkWell(
                onTap: () => setState(() => _expandedSection = isExpanded ? -1 : index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: section.color,
                  child: Row(
                    children: [
                      Container(
                        width: 24, height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${section.id}: ${section.name}',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Review action icons
                      _reviewIcon(Icons.check_circle, Colors.green.shade300),
                      const SizedBox(width: 4),
                      _reviewIcon(Icons.cancel, Colors.red.shade300),
                      const SizedBox(width: 4),
                      _reviewIcon(Icons.flag, Colors.amber.shade300),
                      const SizedBox(width: 8),
                      Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.white, size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded content
              if (isExpanded)
                Container(
                  color: Colors.white,
                  child: Column(
                    children: section.chapters.map((ch) => _buildChapterRow(ch)).toList(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChapterRow(_ChapterData chapter) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Icon(Icons.check_circle, size: 18, color: AppColors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${chapter.id}: ${chapter.name}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark),
                ),
              ),
            ],
          ),
        ),
        ...chapter.topics.map((t) => _buildTopicRow(t)),
      ],
    );
  }

  Widget _buildTopicRow(_TopicData topic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 18, height: 18,
            decoration: BoxDecoration(
              color: topic.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.circle, size: 8, color: topic.color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${topic.id}: ${topic.name}',
              style: const TextStyle(fontSize: 11, color: AppColors.textDark),
            ),
          ),
          if (topic.hasLock) ...[
            const Icon(Icons.lock, size: 14, color: AppColors.textGrey),
            const SizedBox(width: 6),
          ],
          const Icon(Icons.schedule, size: 14, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.borderGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(topic.duration, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  Widget _reviewIcon(IconData icon, Color color) {
    return Container(
      width: 22, height: 22,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
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
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Save Draft', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Next', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _SectionData {
  final String id;
  final String name;
  final Color color;
  final List<_ChapterData> chapters;
  const _SectionData(this.id, this.name, this.color, {required this.chapters});
}

class _ChapterData {
  final String id;
  final String name;
  final List<_TopicData> topics;
  const _ChapterData(this.id, this.name, this.topics);
}

class _TopicData {
  final String id;
  final String name;
  final String duration;
  final Color color;
  final bool hasLock;
  const _TopicData(this.id, this.name, this.duration, this.color, {this.hasLock = false});
}
