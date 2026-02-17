import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class AuthorCoursePreviewScreen extends StatefulWidget {
  const AuthorCoursePreviewScreen({super.key});

  @override
  State<AuthorCoursePreviewScreen> createState() =>
      _AuthorCoursePreviewScreenState();
}

class _AuthorCoursePreviewScreenState
    extends State<AuthorCoursePreviewScreen> {
  int _contentTab = 0; // 0=Video, 1=Text, 2=File
  final Set<int> _expandedSections = {0};

  final _sections = const [
    _PreviewSection('Section 01', 'Introduction to Web Development',
        Color(0xFF4CAF50), [
      'Chapter 01: Getting Started',
      'Topic 01: Overview of Web Development',
    ]),
    _PreviewSection(
        'Section 02', 'Advanced Concepts', Color(0xFFFF9800), [
      'Chapter 01: Deep Dive into Frameworks',
      'Topic 01: React Basics',
      'Topic 02: Angular Basics',
    ]),
    _PreviewSection(
        'Section 03', 'Practical Projects', Color(0xFF9C27B0), [
      'Chapter 01: Building a Portfolio',
      'Topic 01: Project Setup',
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
        title: const Text('Course Preview', style: TextStyle(fontSize: 16)),
      ),
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildMainContent()),
        Container(width: 1, color: AppColors.borderGrey),
        SizedBox(width: 280, child: _buildSectionsSidebar()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMainContent(),
          const Divider(height: 1, color: AppColors.borderGrey),
          _buildSectionsSidebar(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video player area
        Container(
          height: 280,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0D1B2A),
                Color(0xFF1B2838),
                Color(0xFF0A1628),
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Decorative tech-themed background shapes
              CustomPaint(
                size: const Size(double.infinity, 280),
                painter: _VideoBackgroundPainter(),
              ),
              const Icon(Icons.play_circle_filled,
                  size: 56, color: Colors.white70),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  color: Colors.black54,
                  child: Row(
                    children: [
                      const Icon(Icons.play_arrow,
                          size: 18, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 3,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 5),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 10),
                            activeTrackColor: AppColors.primaryBlue,
                            inactiveTrackColor:
                                Colors.white.withValues(alpha: 0.3),
                            thumbColor: Colors.white,
                          ),
                          child: Slider(
                            value: 0.15,
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('1:25 / 9:15',
                          style:
                              TextStyle(fontSize: 10, color: Colors.white)),
                      const SizedBox(width: 8),
                      const Icon(Icons.fullscreen,
                          size: 18, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content tabs
        Container(
          color: Colors.white,
          child: Row(
            children: [
              _buildContentTab(0, 'Video'),
              _buildContentTab(1, 'Text'),
              _buildContentTab(2, 'File'),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.borderGrey),
        // Course title
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Introduction to Web Development',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark)),
              const SizedBox(height: 8),
              Text(
                _contentTab == 0
                    ? 'Watch the video to learn about web development fundamentals.'
                    : _contentTab == 1
                        ? 'This section covers the text content of the course material with detailed explanations and examples.'
                        : 'Download the course files and resources from this section.',
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentTab(int index, String label) {
    final isActive = _contentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _contentTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  isActive ? AppColors.primaryBlue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? AppColors.primaryBlue
                    : AppColors.textGrey)),
      ),
    );
  }

  Widget _buildSectionsSidebar() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _sections.length,
        itemBuilder: (_, i) => _buildSectionAccordion(i),
      ),
    );
  }

  Widget _buildSectionAccordion(int index) {
    final section = _sections[index];
    final isExpanded = _expandedSections.contains(index);

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() {
            if (isExpanded) {
              _expandedSections.remove(index);
            } else {
              _expandedSections.add(index);
            }
          }),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            color: section.color.withValues(alpha: 0.1),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: section.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(section.label,
                      style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(section.name,
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textDark)),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.textGrey,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...section.items.map((item) => Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 14, top: 6, bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      item.startsWith('Chapter')
                          ? Icons.folder_outlined
                          : Icons.play_circle_outline,
                      size: 12,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(item,
                          style: const TextStyle(
                              fontSize: 9, color: AppColors.textDark)),
                    ),
                  ],
                ),
              )),
        const Divider(height: 1, color: AppColors.borderGrey),
      ],
    );
  }
}

class _VideoBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Glowing blue circle (left-center)
    paint.color = const Color(0xFF2196F3).withValues(alpha: 0.08);
    canvas.drawCircle(
        Offset(size.width * 0.2, size.height * 0.5), 60, paint);

    // Smaller accent circle (right)
    paint.color = const Color(0xFF00BCD4).withValues(alpha: 0.06);
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.3), 45, paint);

    // Grid-like decorative lines
    paint
      ..color = const Color(0xFF2196F3).withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (double y = 40; y < size.height; y += 40) {
      canvas.drawLine(
          Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 40; x < size.width; x += 40) {
      canvas.drawLine(
          Offset(x, 0), Offset(x, size.height), paint);
    }

    // Tech node dots at intersections
    paint
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF2196F3).withValues(alpha: 0.12);
    for (double x = 80; x < size.width; x += 80) {
      for (double y = 80; y < size.height; y += 80) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }

    // Hexagonal accent shape
    paint.color = const Color(0xFF42A5F5).withValues(alpha: 0.06);
    final hex = Path();
    const cx = 0.7;
    const cy = 0.65;
    const r = 30.0;
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * 3.14159 / 180;
      final px = size.width * cx + r * _cos(angle);
      final py = size.height * cy + r * _sin(angle);
      if (i == 0) {
        hex.moveTo(px, py);
      } else {
        hex.lineTo(px, py);
      }
    }
    hex.close();
    canvas.drawPath(hex, paint);
  }

  double _cos(double radians) => math.cos(radians);
  double _sin(double radians) => math.sin(radians);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PreviewSection {
  final String label;
  final String name;
  final Color color;
  final List<String> items;
  const _PreviewSection(this.label, this.name, this.color, this.items);
}
