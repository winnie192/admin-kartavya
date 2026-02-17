import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';

class TraineeCoursePlayer extends StatefulWidget {
  const TraineeCoursePlayer({super.key});

  @override
  State<TraineeCoursePlayer> createState() => _TraineeCoursePlayerState();
}

class _TraineeCoursePlayerState extends State<TraineeCoursePlayer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isPlaying = false;
  double _seekPosition = 0.15;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title:
            const Text('Course Player', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVideoPlayer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'UI/UX for beginner with Gen AI (Get Ready For Future)',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 16),
                      _buildTabs(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(width: 1, color: AppColors.borderGrey),
        Expanded(flex: 1, child: _buildLecturesSidebar()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideoPlayer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'UI/UX for beginner with Gen AI (Get Ready For Future)',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                _buildTabs(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      height: 340,
      color: const Color(0xFF1A1A2E),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
              child: Icon(Icons.movie_outlined,
                  size: 60, color: Colors.white24)),
          GestureDetector(
            onTap: () => setState(() => _isPlaying = !_isPlaying),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7)
                  ],
                ),
              ),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6),
                      overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 12),
                      activeTrackColor: AppColors.primaryBlue,
                      inactiveTrackColor:
                          Colors.white.withValues(alpha: 0.3),
                      thumbColor: AppColors.primaryBlue,
                    ),
                    child: Slider(
                      value: _seekPosition,
                      onChanged: (v) =>
                          setState(() => _seekPosition = v),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('1:25',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 11)),
                      Row(
                        children: [
                          Icon(Icons.volume_up,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 12),
                          Icon(Icons.subtitles_outlined,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 12),
                          Icon(Icons.settings,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 12),
                          Icon(Icons.fullscreen,
                              color: Colors.white70, size: 16),
                        ],
                      ),
                      const Text('9:15',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: AppColors.textGrey,
          labelStyle: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 13),
          indicatorColor: AppColors.primaryBlue,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Lectures'),
            Tab(text: 'Details'),
            Tab(text: 'Notes'),
            Tab(text: 'Comments'),
            Tab(text: 'Group Chat'),
          ],
        ),
        SizedBox(
          height: 500,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildLecturesTab(),
              _buildDetailsTab(),
              _buildNotesTab(),
              _buildCommentsTab(),
              _buildGroupChatTab(),
            ],
          ),
        ),
      ],
    );
  }

  // =================== LECTURES TAB ===================
  Widget _buildLecturesTab() {
    return ListView(
      padding: const EdgeInsets.only(top: 12),
      children: [
        _SectionAccordion(
          title: 'Section 01 Understanding the Fundamentals',
          subtitle: '3 chapters, 8 topics',
          chapters: [
            _ChapterData('Chapter 01: Introduction to UI/UX', [
              'What is UX and UI?',
              'Difference Between UI and UX',
            ]),
            _ChapterData('Chapter 02: User Research Basics', [
              'Types of UX Research',
              'Creating User Personas',
              'Conducting Interviews and Surveys',
              'The Basics of UI/UX beginning',
              'The Basics of UI/UX beginning',
            ]),
            _ChapterData('Chapter 03: UX Principles & Heuristics', [
              'Common UX Mistakes',
            ]),
          ],
        ),
        _SectionAccordion(
          title: 'Section 02: UI Design & Visual Elements',
          subtitle: '2 chapters, 5 topics',
          chapters: [
            _ChapterData('Chapter 01: Interface Design Essentials', [
              'UI Elements (Buttons, Forms, Menus)',
              'Layout and Spacing',
            ]),
            _ChapterData('Chapter 02: Wireframing & Prototyping', [
              'Tools for Wireframing (Figma, Adobe XD)',
              'Low-Fidelity vs. High-Fidelity',
              'Building Reusable Components',
            ]),
          ],
        ),
        _SectionAccordion(
          title: 'Section 03: Exams & Assessment',
          subtitle: '1 chapter, 2 topics',
          chapters: [
            _ChapterData('Chapter 01: The Basics of UI/UX beginning', [
              'Multiple Choice Quiz: Fundamentals',
              'Case Study Questions',
            ]),
          ],
        ),
        _SectionAccordion(
          title: 'Section 04: Notes',
          subtitle: '1 chapter, 1 topic',
          chapters: [
            _ChapterData('Chapter 01: The UI/UX beginning', [
              'Notes on how to start with ui/ux',
            ]),
          ],
        ),
      ],
    );
  }

  // =================== DETAILS TAB ===================
  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow('Course Name',
              'UI/UX for beginner with Gen AI (Get Ready For Future)'),
          _detailRow('Description',
              'Learn core concepts of user-centered design'),
          _detailRow('Business Segment', 'Digital Solutions'),
          _detailRow('Department', 'ABC Corp'),
          _detailRow('Program', 'Design Onboarding'),
          _detailRow('Client', 'Product Innovation'),
          const SizedBox(height: 8),
          const Text('Attachment',
              style:
                  TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.description_outlined,
                  size: 14, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              const Text('Download Brochure.pdf',
                  style: TextStyle(
                      fontSize: 11, color: AppColors.primaryBlue)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _detailChip('Status', 'Ongoing', AppColors.primaryBlue),
              const SizedBox(width: 8),
              _detailChip('Outcome', 'Performer', AppColors.orange),
            ],
          ),
          const SizedBox(height: 8),
          _detailRow('Hours Assign', '06hr:00min'),
          _detailRow('Start Date', '12 Jan 2025'),
          _detailRow('Expiry Date', '30 June 2025'),
          const SizedBox(height: 8),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  minimumSize: Size.zero,
                ),
                child: const Text('Requests',
                    style: TextStyle(fontSize: 11)),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  minimumSize: Size.zero,
                ),
                child: const Text('Certificate',
                    style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Participants section
          Row(
            children: [
              const Text('Participants(10)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const Spacer(),
              // Stacked avatars
              SizedBox(
                width: 80,
                height: 28,
                child: Stack(
                  children: List.generate(4, (i) => Positioned(
                    left: i * 18.0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: [AppColors.primaryBlue, AppColors.orange, AppColors.green, AppColors.red][i],
                      child: const Icon(Icons.person, size: 14, color: Colors.white),
                    ),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Participant list with checkboxes
          for (final p in _participants)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(
                    p.isPresent ? Icons.check_box : Icons.check_box_outline_blank,
                    size: 18,
                    color: p.isPresent ? AppColors.primaryBlue : AppColors.grey,
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.lightBlue,
                    child: const Icon(Icons.person, size: 12, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(p.name, style: const TextStyle(fontSize: 11)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              _detailChip('Present', '7', AppColors.green),
              const SizedBox(width: 8),
              _detailChip('Absent', '3', AppColors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textGrey)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _detailChip(String label, String value, Color color) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ',
              style: TextStyle(fontSize: 10, color: color)),
          Text(value,
              style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // =================== NOTES TAB ===================
  Widget _buildNotesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Take quick notes to remember what you have learned',
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          const Text(
              'Notes can help you to retain whatever you learn in courses for a longer period of time',
              style:
                  TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(height: 16),
          // Add note area
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Start Typing your notes here',
                    hintStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Row(
                  children: [
                    const Text('02:35',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.textGrey)),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Cancel',
                          style: TextStyle(fontSize: 11)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        minimumSize: Size.zero,
                      ),
                      child: const Text('Add Note',
                          style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Toolbar
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Filter by Videos',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textGrey)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down,
                        size: 16, color: AppColors.textGrey),
                  ],
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Add Note',
                    style: TextStyle(fontSize: 11)),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 14),
                label: const Text('Download',
                    style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Existing notes
          _noteCard(
            '02:35',
            'What is UX and UI?',
            'UI/UX stands for User Interface and User Experience, and they are two closely related aspects of designing digital products like websites, apps, or software. The UI is the design of the order button, color scheme, and icons. The UX is how easily you can search for food, place an order, and get updates. UI is about how the product looks. It focuses on: Visual Design: Colors, fonts, but',
          ),
          const SizedBox(height: 10),
          _noteCard(
            '02:35',
            'Difference between UI and UX',
            'UI/UX stands for User Interface and User Experience, and they are two closely related aspects of designing digital products like websites, apps, or software. The UI is the design of the order button, color scheme, and icons. The UX is how easily you can search for food, place an order, and get updates.',
          ),
        ],
      ),
    );
  }

  Widget _noteCard(String time, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(time,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.primaryBlue)),
              ),
              const Spacer(),
              const Icon(Icons.edit_outlined,
                  size: 14, color: AppColors.textGrey),
              const SizedBox(width: 8),
              const Icon(Icons.delete_outline,
                  size: 14, color: AppColors.red),
            ],
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(body,
              style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textGrey,
                  height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          const Text('Read More',
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // =================== COMMENTS TAB ===================
  Widget _buildCommentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add comment
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add Your Comment',
                    hintStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.borderGrey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                ),
                child:
                    const Text('Add', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // FAQ section
          const Text('Frequently Ask Questions',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _faqItem(
              '1. What is the difference between UI and UX?',
              'UI (User Interface) is about how a product looks — the visual elements like buttons, icons, and layout. UX (User Experience) is about how the product works and feels — the overall journey and usability for the user.'),
          _faqItem('2. Why is UI/UX important?',
              'A good UI/UX: Increases user satisfaction, Reduces confusion and frustration, Enhances brand value and trust, Increases conversions and customer retention.'),
          _faqItem('3. Do UI/UX designers need to code?',
              'Not necessarily. Many UI/UX designers don\'t code, especially those focused on research or visuals. However, understanding HTML, CSS, JavaScript or frameworks like React can help communicate better with developers.'),
          _faqItem('4. What tools do UI/UX designers use most often?',
              'Figma (UI design, prototyping), Adobe XD, Sketch (Mac only), Miro (Brainstorming), Balsamiq (Wireframing), InVision (Prototyping), Notion (Research & documentation).'),
          _faqItem('5. What is the UX design process?',
              'Research → Define (user needs, problems) → Ideate (solutions) → Wireframe & prototype → Test with users → Implement → Iterate based on feedback.'),
          const SizedBox(height: 20),
          // User reviews
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Reviews',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              TextButton(
                onPressed: () => _showRatingDialog(),
                child: const Text('Read More',
                    style: TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _reviewCard('Roshan Pro Max', 'UIUX Designer',
              'Perfect for quick prototyping! The designs are professional and work seamlessly with my workflow.', 5),
          _reviewCard('The Heart of Logos', 'Logo Designer',
              'Amazing work! The color schemes are vibrant, and the icons fit perfectly with all my projects.', 5),
          _reviewCard('Roshni Bhide', '3D Designer',
              'I was blown away by how complete this UI Kit is. It has everything I need, from assets to components.', 4),
          _reviewCard('Subhujeeta Gosh', 'Information Analyst',
              'The quality of the design is top-notch, and I love how organized the files are. It\'s easy to find what I need.', 5),
          _reviewCard('Komal Naval', 'Data Analyst',
              'This kit exceeded my expectations! The components are versatile and make implementation much easier.', 5),
          _reviewCard('Yashoda Anchan', 'Team Leader',
              'Amazing work! The color schemes are vibrant, and the icons fit perfectly with all my projects.', 4),
        ],
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding:
          const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      title: Text(question,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600)),
      children: [
        Text(answer,
            style: const TextStyle(
                fontSize: 11,
                color: AppColors.textGrey,
                height: 1.5)),
      ],
    );
  }

  Widget _reviewCard(String name, String role, String review, int stars) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person,
                  size: 18, color: AppColors.primaryBlue),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600)),
                Text(role,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(height: 2),
                Row(
                  children: List.generate(5, (i) => Icon(
                    i < stars ? Icons.star : Icons.star_border,
                    size: 14,
                    color: Colors.amber,
                  )),
                ),
                const SizedBox(height: 4),
                Text(review,
                    style: const TextStyle(
                        fontSize: 11, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog() {
    int rating = 0;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Rate the course',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => GestureDetector(
                    onTap: () => setDialogState(() => rating = i + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        i < rating ? Icons.star : Icons.star_border,
                        size: 32,
                        color: Colors.amber,
                      ),
                    ),
                  )),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Submit feedback', style: TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =================== GROUP CHAT TAB ===================
  Widget _buildGroupChatTab() {
    return Column(
      children: [
        // Chat header
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.borderGrey)),
          ),
          child: const Row(
            children: [
              Text('Group Chat',
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              Spacer(),
              Text('Group',
                  style: TextStyle(
                      fontSize: 11, color: AppColors.primaryBlue)),
              SizedBox(width: 16),
              Text('Personal',
                  style: TextStyle(
                      fontSize: 11, color: AppColors.textGrey)),
            ],
          ),
        ),
        // Messages
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _chatDateHeader('Today'),
              _chatBubble("I'll be there in 2 mins", false),
              _chatBubble('just ideas for next time', false),
              _chatBubble('woohoooo', true),
              _chatBubble('Haha oh man', false),
              _chatBubble("Haha that's terrifying", true),
              _chatBubble('omg, this is amazing', false),
              _chatBubble('perfect!', true),
              _chatBubble('Wow, this is really epic', false),
              _chatBubble('How are you?', true),
            ],
          ),
        ),
        // Message input
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColors.borderGrey)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: AppColors.borderGrey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send,
                    color: Colors.white, size: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chatDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.borderGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(date,
              style: const TextStyle(
                  fontSize: 10, color: AppColors.textGrey)),
        ),
      ),
    );
  }

  Widget _chatBubble(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.primaryBlue
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe
                ? const Radius.circular(12)
                : const Radius.circular(4),
            bottomRight: isMe
                ? const Radius.circular(4)
                : const Radius.circular(12),
          ),
          border: isMe
              ? null
              : Border.all(color: AppColors.borderGrey),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 12,
            color: isMe ? Colors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }

  Widget _buildLecturesSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.borderGrey)),
          ),
          child: const Text('Course Content',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600)),
        ),
        Expanded(child: _buildLecturesTab()),
      ],
    );
  }
}

class _Participant {
  final String name;
  final bool isPresent;
  const _Participant(this.name, this.isPresent);
}

const _participants = [
  _Participant('Divya Liberty', true),
  _Participant('Barsena Singh', true),
  _Participant('Phil Okrais', true),
  _Participant('Om Padolay', false),
  _Participant('Amit Pandey', true),
  _Participant('Preeth Moibahar', true),
  _Participant('Satish Avit', false),
  _Participant('Shreya Panday', true),
  _Participant('Komal Navel', true),
  _Participant('Khan Cis', false),
];

class _ChapterData {
  final String title;
  final List<String> topics;
  const _ChapterData(this.title, this.topics);
}

class _SectionAccordion extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<_ChapterData> chapters;

  const _SectionAccordion({
    required this.title,
    required this.subtitle,
    required this.chapters,
  });

  @override
  State<_SectionAccordion> createState() => _SectionAccordionState();
}

class _SectionAccordionState extends State<_SectionAccordion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    size: 20,
                    color: AppColors.textGrey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(widget.subtitle,
                            style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textGrey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            ...widget.chapters
                .map((ch) => _ChapterAccordion(chapter: ch)),
        ],
      ),
    );
  }
}

class _ChapterAccordion extends StatefulWidget {
  final _ChapterData chapter;
  const _ChapterAccordion({required this.chapter});

  @override
  State<_ChapterAccordion> createState() =>
      _ChapterAccordionState();
}

class _ChapterAccordionState extends State<_ChapterAccordion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 40, right: 14, top: 8, bottom: 8),
            child: Row(
              children: [
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  size: 18,
                  color: AppColors.textGrey,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(widget.chapter.title,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
        if (_expanded)
          ...widget.chapter.topics.map((topic) => Padding(
                padding: const EdgeInsets.only(
                    left: 72, right: 14, top: 4, bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.play_circle_outline,
                        size: 14, color: AppColors.primaryBlue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(topic,
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textDark)),
                    ),
                    const Text('12hrs:23m',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textGrey)),
                  ],
                ),
              )),
      ],
    );
  }
}
