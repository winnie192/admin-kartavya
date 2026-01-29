import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/admin_sidebar.dart';

class CoursePlayScreen extends StatefulWidget {
  const CoursePlayScreen({super.key});

  @override
  State<CoursePlayScreen> createState() => _CoursePlayScreenState();
}

class _CoursePlayScreenState extends State<CoursePlayScreen> {
  int _expandedSection = 0;
  double _progress = 0.15; // 1:25 / 9:15

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
              title: const Text('Course Player', style: TextStyle(fontSize: 16)),
              leading: IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => Navigator.pop(context)),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
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
                        const Text('Course Player', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      ],
                    ),
                  ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video area
                      Expanded(
                        flex: 3,
                        child: _buildVideoPlayer(),
                      ),
                      // Sidebar - sections
                      if (!isMobile)
                        SizedBox(
                          width: 280,
                          child: _buildSectionList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            child: const Center(
              child: Icon(Icons.play_circle_fill, size: 64, color: Colors.white54),
            ),
          ),
        ),
        // Progress bar
        Container(
          color: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  activeTrackColor: AppColors.primaryBlue,
                  inactiveTrackColor: Colors.white24,
                  thumbColor: AppColors.primaryBlue,
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                ),
                child: Slider(
                  value: _progress,
                  onChanged: (v) => setState(() => _progress = v),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  const Text('1:25 / 9:15', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  const Spacer(),
                  const Icon(Icons.volume_up, color: Colors.white, size: 18),
                  const SizedBox(width: 12),
                  const Icon(Icons.settings, color: Colors.white, size: 18),
                  const SizedBox(width: 12),
                  const Icon(Icons.fullscreen, color: Colors.white, size: 18),
                ],
              ),
            ],
          ),
        ),
        // Title
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: const Text(
            'UI/UX for beginner with Gen AI (Get Ready For Future)',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionList() {
    final sections = [
      _SectionData('Section 01', 'Understanding the Fundamentals', [
        'Introduction to UX Design',
        'User Research Methods',
        'Wireframing Basics',
      ]),
      _SectionData('Section 02', 'UI Design & Visual Elements', [
        'Color Theory',
        'Typography in Design',
        'Layout & Grid Systems',
      ]),
      _SectionData('Section 03', 'Exams & Assessment', [
        'Mid-term Assessment',
        'Final Project',
      ]),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: AppColors.borderGrey)),
      ),
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, i) {
          final s = sections[i];
          final isExpanded = _expandedSection == i;
          return Column(
            children: [
              InkWell(
                onTap: () => setState(() => _expandedSection = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  color: isExpanded ? AppColors.lightBlue : Colors.white,
                  child: Row(
                    children: [
                      Icon(
                        isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                        size: 16,
                        color: AppColors.textDark,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.label, style: const TextStyle(fontSize: 9, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                            Text(s.title, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                ...s.topics.asMap().entries.map((e) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            e.key == 0 ? Icons.play_circle : Icons.lock_outline,
                            size: 14,
                            color: e.key == 0 ? AppColors.primaryBlue : AppColors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(e.value, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                          ),
                        ],
                      ),
                    )),
              const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}

class _SectionData {
  final String label, title;
  final List<String> topics;
  _SectionData(this.label, this.title, this.topics);
}
