import 'package:flutter/material.dart';
import 'screens/admin/admin_shell.dart';
import 'screens/admin/course_play_screen.dart';
import 'screens/admin/create_course_screen.dart';
import 'screens/admin/create_user_screen.dart';
import 'screens/admin/exam_result_screen.dart';
import 'screens/admin/meeting_screen.dart';
import 'screens/create_exam_flow.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/related_exams_screen.dart';
import 'screens/take_test_screen.dart';
import 'screens/trainee/trainee_shell.dart';
import 'screens/trainee/trainee_course_player.dart';
import 'screens/trainee/trainee_take_test_screen.dart';
import 'screens/trainee/trainee_exam_result_screen.dart';
import 'screens/trainer/trainer_shell.dart';
import 'screens/trainer/trainer_course_detail_screen.dart';
import 'screens/trainer/trainer_trainee_detail_screen.dart';
import 'screens/trainer/trainer_task_detail_screen.dart';
import 'screens/trainer/trainer_exam_summary_screen.dart';
import 'screens/author/author_shell.dart';
import 'screens/author/author_create_course_screen.dart';
import 'screens/author/author_course_preview_screen.dart';
import 'screens/author/author_preview_submit_screen.dart';
import 'screens/pm/pm_shell.dart';
import 'screens/pm/pm_course_review_screen.dart';
import 'screens/pm/pm_exam_detail_screen.dart';
import 'screens/pm/pm_notifications_screen.dart';
import 'screens/review_manager/rm_shell.dart';
import 'screens/review_manager/rm_course_detail_screen.dart';
import 'screens/review_manager/rm_course_player_screen.dart';
import 'utils/app_colors.dart';
import 'utils/role_scope.dart';

void main() {
  runApp(const ExamManagementApp());
}

class ExamManagementApp extends StatefulWidget {
  const ExamManagementApp({super.key});

  @override
  State<ExamManagementApp> createState() => _ExamManagementAppState();
}

class _ExamManagementAppState extends State<ExamManagementApp> {
  UserRole _currentRole = UserRole.admin;

  @override
  Widget build(BuildContext context) {
    return RoleScope(
      role: _currentRole,
      onRoleChanged: (role) => setState(() => _currentRole = role),
      child: MaterialApp(
        title: 'Kartavya LMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: AppColors.primaryBlue,
          useMaterial3: true,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: AppColors.background,
        ),
        initialRoute: '/login',
        onGenerateRoute: _onGenerateRoute,
        onGenerateInitialRoutes: (String initialRoute) {
          return [
            _onGenerateRoute(RouteSettings(name: initialRoute))!,
          ];
        },
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '/login');
    final path = uri.path;

    // Login
    if (path == '/login') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginScreen(),
      );
    }

    // Full-screen routes (no shell wrapper)
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

    // Trainee routes
    if (path == '/trainee') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TraineeShell(initialIndex: 0),
      );
    }
    if (path == '/trainee/courses') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TraineeShell(initialIndex: 1),
      );
    }
    if (path == '/trainee/course-player') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TraineeCoursePlayer(),
      );
    }
    if (path == '/trainee/take-test') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TraineeTakeTestScreen(),
      );
    }
    if (path == '/trainee/exam-result') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TraineeExamResultScreen(),
      );
    }

    // Trainer routes
    if (path == '/trainer') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerShell(initialIndex: 0),
      );
    }
    if (path == '/trainer/courses') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerShell(initialIndex: 1),
      );
    }
    if (path == '/trainer/exams') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerShell(initialIndex: 2),
      );
    }
    if (path == '/trainer/requests') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerShell(initialIndex: 3),
      );
    }
    if (path == '/trainer/my-schedule') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerShell(initialIndex: 4),
      );
    }
    if (path == '/trainer/trainee-progress') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerShell(initialIndex: 5),
      );
    }
    if (path == '/trainer/course-detail') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerCourseDetailScreen(),
      );
    }
    if (path == '/trainer/trainee-detail') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerTraineeDetailScreen(),
      );
    }
    if (path == '/trainer/task-detail') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerTaskDetailScreen(),
      );
    }
    if (path == '/trainer/exam-summary') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TrainerExamSummaryScreen(),
      );
    }

    // Admin routes (also used for /author, /pm)
    if (path.startsWith('/admin')) {
      final adminPath = path.replaceFirst('/admin', '');
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AdminShell(initialRoute: adminPath.isEmpty ? '/' : adminPath),
      );
    }

    // Author routes
    if (path == '/author') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthorShell(initialIndex: 0),
      );
    }
    if (path == '/author/manage-course') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthorShell(initialIndex: 1),
      );
    }
    if (path == '/author/feedback') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthorShell(initialIndex: 2),
      );
    }
    if (path == '/author/create-course') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthorCreateCourseScreen(),
      );
    }
    if (path == '/author/course-preview') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthorCoursePreviewScreen(),
      );
    }
    if (path == '/author/preview-submit') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AuthorPreviewSubmitScreen(),
      );
    }

    // PM routes
    if (path == '/pm') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PmShell(initialIndex: 0),
      );
    }
    if (path == '/pm/manage-lms') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PmShell(initialIndex: 1),
      );
    }
    if (path == '/pm/requests') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PmShell(initialIndex: 2),
      );
    }
    if (path == '/pm/course-review') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PmCourseReviewScreen(),
      );
    }
    if (path == '/pm/exam-detail') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PmExamDetailScreen(),
      );
    }
    if (path == '/pm/notifications') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(body: PmNotificationsScreen()),
      );
    }

    // Review Manager routes
    if (path == '/review-manager') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const RmShell(initialIndex: 0),
      );
    }
    if (path == '/review-manager/course-review') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const RmShell(initialIndex: 1),
      );
    }
    if (path == '/review-manager/course-detail') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const RmCourseDetailScreen(),
      );
    }
    if (path == '/review-manager/course-player') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const RmCoursePlayerScreen(),
      );
    }

    // Fallback: login screen
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const LoginScreen(),
    );
  }
}
