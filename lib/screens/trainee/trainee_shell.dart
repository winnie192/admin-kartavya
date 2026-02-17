import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/trainee_sidebar.dart';
import '../../widgets/trainee_top_nav.dart';
import 'trainee_dashboard.dart';
import 'trainee_courses_screen.dart';
import 'trainee_tasks_screen.dart';
import 'trainee_sessions_screen.dart';
import 'trainee_exams_screen.dart';
import 'trainee_schedule_screen.dart';

class TraineeShell extends StatefulWidget {
  final int initialIndex;

  const TraineeShell({super.key, this.initialIndex = 0});

  @override
  State<TraineeShell> createState() => _TraineeShellState();
}

class _TraineeShellState extends State<TraineeShell> {
  late int _topNavIndex;

  @override
  void initState() {
    super.initState();
    _topNavIndex = widget.initialIndex;
  }

  void _onTopNavTap(int index) {
    if (index == 6) {
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
      drawer: isMobile ? const Drawer(child: TraineeSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Trainee', style: TextStyle(fontSize: 16)),
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
                if (!isMobile) const TraineeSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      TraineeTopNav(
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
        return const TraineeDashboard();
      case 1:
        return const TraineeCoursesScreen();
      case 2:
        return const TraineeTasksScreen();
      case 3:
        return const TraineeSessionsScreen();
      case 4:
        return const TraineeExamsScreen();
      case 5:
        return const TraineeScheduleScreen();
      default:
        return const Center(
          child: Text('Coming Soon',
              style: TextStyle(fontSize: 14, color: AppColors.textGrey)),
        );
    }
  }
}
