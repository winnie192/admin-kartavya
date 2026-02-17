import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/pm_sidebar.dart';
import '../../widgets/pm_top_nav.dart';
import 'pm_dashboard.dart';
import 'pm_manage_lms_screen.dart';
import 'pm_user_detail_screen.dart';
import 'pm_requests_screen.dart';

class PmShell extends StatefulWidget {
  final int initialIndex;

  const PmShell({super.key, this.initialIndex = 0});

  @override
  State<PmShell> createState() => _PmShellState();
}

class _PmShellState extends State<PmShell> {
  late int _topNavIndex;

  // Sub-navigation state for Manage LMS
  // 0 = user list, 1 = user detail
  int _manageLmsSubView = 0;
  String _selectedUserName = '';

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
    setState(() {
      _topNavIndex = index;
      // Reset sub-navigation when switching top-level tabs
      _manageLmsSubView = 0;
    });
  }

  void _navigateToUserDetail(String userName) {
    setState(() {
      _manageLmsSubView = 1;
      _selectedUserName = userName;
    });
  }

  void _navigateBackToUserList() {
    setState(() {
      _manageLmsSubView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      drawer: isMobile ? const Drawer(child: PmSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Program Manager', style: TextStyle(fontSize: 16)),
            )
          : null,
      body: Padding(
        padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                if (!isMobile) const PmSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      PmTopNav(
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
        return const PmDashboard();
      case 1:
        return _buildManageLmsContent();
      case 2:
        return const PmRequestsScreen();
      default:
        return const Center(
          child: Text('Coming Soon',
              style: TextStyle(fontSize: 14, color: AppColors.textGrey)),
        );
    }
  }

  Widget _buildManageLmsContent() {
    switch (_manageLmsSubView) {
      case 1:
        return PmUserDetailScreen(
          userName: _selectedUserName,
          onBack: _navigateBackToUserList,
        );
      default:
        return PmManageLmsScreen(
          onUserTap: (name) => _navigateToUserDetail(name),
        );
    }
  }
}
