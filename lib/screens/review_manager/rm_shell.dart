import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/rm_sidebar.dart';
import '../../widgets/rm_top_nav.dart';
import 'rm_dashboard.dart';
import 'rm_course_review_screen.dart';

class RmShell extends StatefulWidget {
  final int initialIndex;

  const RmShell({super.key, this.initialIndex = 0});

  @override
  State<RmShell> createState() => _RmShellState();
}

class _RmShellState extends State<RmShell> {
  late int _topNavIndex;

  @override
  void initState() {
    super.initState();
    _topNavIndex = widget.initialIndex;
  }

  void _onTopNavTap(int index) {
    if (index == 2) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    setState(() => _topNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      drawer: isMobile ? const Drawer(child: RmSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Review Manager',
                  style: TextStyle(fontSize: 16)),
            )
          : null,
      body: Padding(
        padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius:
              isMobile ? BorderRadius.zero : BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius:
                  isMobile ? BorderRadius.zero : BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                if (!isMobile) const RmSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      RmTopNav(
                        selectedIndex: _topNavIndex,
                        onTap: _onTopNavTap,
                      ),
                      Expanded(child: _buildContent()),
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

  Widget _buildContent() {
    switch (_topNavIndex) {
      case 0:
        return const RmDashboard();
      case 1:
        return const RmCourseReviewScreen();
      default:
        return const Center(
          child: Text('Coming Soon',
              style: TextStyle(fontSize: 14, color: AppColors.textGrey)),
        );
    }
  }
}
