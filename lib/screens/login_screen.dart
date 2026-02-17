import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/role_scope.dart'; // UserRole enum

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/kartavya_logo.png',
                width: 180,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Text(
                  'KARTAVYA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Learning Management System',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 40),
              const Text(
                'Select Your Role',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 28),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 516),
                child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _RoleCard(
                    role: UserRole.admin,
                    label: 'Admin',
                    icon: Icons.admin_panel_settings,
                    color: AppColors.primaryBlue,
                  ),
                  _RoleCard(
                    role: UserRole.trainee,
                    label: 'Trainee',
                    icon: Icons.school,
                    color: AppColors.green,
                  ),
                  _RoleCard(
                    role: UserRole.trainer,
                    label: 'Trainer',
                    icon: Icons.person,
                    color: AppColors.orange,
                  ),
                  _RoleCard(
                    role: UserRole.author,
                    label: 'Author',
                    icon: Icons.edit_note,
                    color: const Color(0xFF9C27B0),
                  ),
                  _RoleCard(
                    role: UserRole.programManager,
                    label: 'Program Manager',
                    icon: Icons.assignment_ind,
                    color: const Color(0xFF00BCD4),
                  ),
                  _RoleCard(
                    role: UserRole.reviewManager,
                    label: 'Review Manager',
                    icon: Icons.rate_review,
                    color: const Color(0xFF607D8B),
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final UserRole role;
  final String label;
  final IconData icon;
  final Color color;

  const _RoleCard({
    required this.role,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final String route;
        switch (role) {
          case UserRole.admin:
            route = '/admin';
            break;
          case UserRole.trainee:
            route = '/trainee';
            break;
          case UserRole.trainer:
            route = '/trainer';
            break;
          case UserRole.author:
            route = '/author';
            break;
          case UserRole.programManager:
            route = '/pm';
            break;
          case UserRole.reviewManager:
            route = '/review-manager';
            break;
        }
        Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
