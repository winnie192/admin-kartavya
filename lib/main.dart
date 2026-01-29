import 'package:flutter/material.dart';
import 'screens/admin/admin_shell.dart';
import 'screens/admin/course_play_screen.dart';
import 'screens/admin/create_course_screen.dart';
import 'screens/admin/create_user_screen.dart';
import 'screens/admin/exam_result_screen.dart';
import 'screens/admin/meeting_screen.dart';
import 'screens/create_exam_flow.dart';
import 'screens/dashboard_screen.dart';
import 'screens/related_exams_screen.dart';
import 'screens/take_test_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const ExamManagementApp());
}

class ExamManagementApp extends StatelessWidget {
  const ExamManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin - Kartavya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.primaryBlue,
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/');
    final path = uri.path;

    // Full-screen routes (no admin shell wrapper)
    switch (path) {
      case '/exams':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DashboardScreen(),
        );
      case '/exams/create':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CreateExamFlow(),
        );
      case '/exams/related':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RelatedExamsScreen(),
        );
      case '/exams/take-test':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const TakeTestScreen(),
        );
      case '/exams/result':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ExamResultScreen(),
        );
      case '/create-course':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CreateCourseScreen(),
        );
      case '/create-user':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CreateUserScreen(),
        );
      case '/create-guest':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CreateUserScreen(isGuest: true),
        );
      case '/course-player':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CoursePlayScreen(),
        );
      case '/meeting':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MeetingScreen(),
        );
    }

    // All other routes go through AdminShell
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => AdminShell(initialRoute: path),
    );
  }
}
