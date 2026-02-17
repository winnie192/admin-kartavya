import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/admin_sidebar.dart';
import '../../widgets/top_nav_bar.dart';
import 'admin_dashboard.dart';
import 'administration_screen.dart';
import 'manage_user_screen.dart';
import 'manage_guest_screen.dart';
import 'manage_course_screen.dart';
import 'user_detail_screen.dart';
import 'trainee_progress_screen.dart';
import 'request_received_screen.dart';
import 'certificates_screen.dart';
import 'exam_settings_screen.dart';
import 'review_manager_screen.dart';
import 'task_detail_screen.dart';

class AdminShell extends StatefulWidget {
  final String initialRoute;

  const AdminShell({super.key, this.initialRoute = '/'});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  late int topNavIndex;
  late String? _subScreen;

  @override
  void initState() {
    super.initState();
    _applyRoute(widget.initialRoute);
  }

  @override
  void didUpdateWidget(AdminShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRoute != widget.initialRoute) {
      _applyRoute(widget.initialRoute);
    }
  }

  void _applyRoute(String route) {
    if (route.startsWith('/administration')) {
      topNavIndex = 1;
      final sub = route.replaceFirst('/administration', '');
      _subScreen = _subScreenFromPath(sub);
    } else if (route == '/addon-module') {
      topNavIndex = 2;
      _subScreen = null;
    } else if (route == '/change-role') {
      topNavIndex = 3;
      _subScreen = null;
    } else {
      topNavIndex = 0;
      _subScreen = null;
    }
  }

  String? _subScreenFromPath(String sub) {
    if (sub.isEmpty || sub == '/') return null;
    switch (sub) {
      case '/manage-user':
        return 'Manage User';
      case '/manage-guest':
        return 'Manage Guest';
      case '/manage-course':
        return 'Manage Course';
      case '/user-detail':
        return 'User Detail';
      case '/guest-detail':
        return 'Guest Detail';
      case '/trainee-progress':
        return 'Trainee Progress';
      case '/request-received':
        return 'Request Received';
      case '/certificates':
        return 'Certificates';
      case '/manage-certificates':
        return 'Manage Certificates';
      case '/exam-settings':
        return 'Exam Settings';
      case '/review-manager':
        return 'Review Manager';
      case '/task-detail':
        return 'Task Detail';
      default:
        return null;
    }
  }

  void _onTopNavTap(int index) {
    if (index == 3) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    setState(() {
      topNavIndex = index;
      _subScreen = null;
    });
  }

  void _pushSubScreen(String screen) {
    setState(() {
      _subScreen = screen;
    });
  }

  void _popScreen() {
    setState(() {
      _subScreen = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      drawer: isMobile ? const Drawer(child: AdminSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Admin', style: TextStyle(fontSize: 16)),
            )
          : null,
      body: Padding(
        padding: isMobile
            ? EdgeInsets.zero
            : const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
        child: ClipRRect(
          borderRadius: isMobile
              ? BorderRadius.zero
              : BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: isMobile
                  ? BorderRadius.zero
                  : BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                if (!isMobile) const AdminSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      TopNavBar(
                        selectedIndex: topNavIndex,
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
    switch (topNavIndex) {
      case 0:
        return const AdminDashboard();
      case 1:
        return _buildAdministrationContent();
      default:
        return Center(
          child: Text(
            topNavIndex == 2 ? 'Add On Module' : 'Change Role',
            style: const TextStyle(fontSize: 14, color: AppColors.textGrey),
          ),
        );
    }
  }

  Widget _buildAdministrationContent() {
    if (_subScreen == null) {
      return AdministrationScreen(onModuleTap: (id) {
        if (id == 'Exams') {
          Navigator.pushNamed(context, '/exams');
        } else {
          _pushSubScreen(id);
        }
      });
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              InkWell(
                onTap: _popScreen,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderGrey),
                  ),
                  child: const Icon(Icons.arrow_back,
                      size: 14, color: AppColors.textDark),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _subScreen!,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark),
              ),
            ],
          ),
        ),
        Expanded(child: _buildSubScreen()),
      ],
    );
  }

  Widget _buildSubScreen() {
    switch (_subScreen) {
      case 'Manage Course':
        return const ManageCourseScreen();
      case 'Manage User':
        return ManageUserScreen(
          onUserTap: () => _pushSubScreen('User Detail'),
        );
      case 'Manage Guest':
        return ManageGuestScreen(
          onGuestTap: () => _pushSubScreen('Guest Detail'),
        );
      case 'User Detail':
      case 'Guest Detail':
        return const UserDetailScreen();
      case 'Trainee Progress':
        return TraineeProgressScreen(
          onTraineeTap: () => _pushSubScreen('User Detail'),
        );
      case 'Request Received':
        return const RequestReceivedScreen();
      case 'Certificates':
        return const CertificatesScreen();
      case 'Manage Certificates':
        return const CertificatesScreen();
      case 'Exam Settings':
        return const ExamSettingsScreen();
      case 'Review Manager':
        return const ReviewManagerScreen();
      case 'Task Detail':
        return const TaskDetailScreen();
      default:
        return Center(
          child: Text(
            _subScreen ?? '',
            style: const TextStyle(fontSize: 14, color: AppColors.textGrey),
          ),
        );
    }
  }
}
