import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/author_sidebar.dart';
import '../../widgets/author_top_nav.dart';
import 'author_dashboard.dart';
import 'author_manage_course_screen.dart';
import 'author_feedback_screen.dart';

class AuthorShell extends StatefulWidget {
  final int initialIndex;

  const AuthorShell({super.key, this.initialIndex = 0});

  @override
  State<AuthorShell> createState() => _AuthorShellState();
}

class _AuthorShellState extends State<AuthorShell> {
  late int _topNavIndex;

  @override
  void initState() {
    super.initState();
    _topNavIndex = widget.initialIndex;
  }

  void _onTopNavTap(int index) {
    if (index == 3) {
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
      drawer: isMobile ? const Drawer(child: AuthorSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Author', style: TextStyle(fontSize: 16)),
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
                if (!isMobile) const AuthorSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      AuthorTopNav(
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
        return const AuthorDashboard();
      case 1:
        return const AuthorManageCourseScreen();
      case 2:
        return const AuthorFeedbackScreen();
      default:
        return const Center(
          child: Text('Coming Soon',
              style: TextStyle(fontSize: 14, color: AppColors.textGrey)),
        );
    }
  }
}
