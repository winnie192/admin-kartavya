import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/trainer_sidebar.dart';
import '../../widgets/trainer_top_nav.dart';
import 'trainer_dashboard.dart';
import 'trainer_courses_screen.dart';
import 'trainer_exams_screen.dart';
import 'trainer_requests_screen.dart';
import 'trainer_my_schedule_screen.dart';
import 'trainer_trainee_progress_screen.dart';

class TrainerShell extends StatefulWidget {
  final int initialIndex;

  const TrainerShell({super.key, this.initialIndex = 0});

  @override
  State<TrainerShell> createState() => _TrainerShellState();
}

class _TrainerShellState extends State<TrainerShell> {
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
      drawer: isMobile ? const Drawer(child: TrainerSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Trainer', style: TextStyle(fontSize: 16)),
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
                if (!isMobile) const TrainerSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      TrainerTopNav(
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
        return const TrainerDashboard();
      case 1:
        return TrainerCoursesScreen(
          onCourseDetail: (courseName) {
            Navigator.pushNamed(context, '/trainer/course-detail');
          },
        );
      case 2:
        return const TrainerExamsScreen();
      case 3:
        return const TrainerRequestsScreen();
      case 4:
        return const TrainerMyScheduleScreen();
      case 5:
        return TrainerTraineeProgressScreen(
          onTraineeDetail: (name) {
            Navigator.pushNamed(context, '/trainer/trainee-detail');
          },
        );
      default:
        return const Center(
          child: Text('Coming Soon',
              style: TextStyle(fontSize: 14, color: AppColors.textGrey)),
        );
    }
  }
}
