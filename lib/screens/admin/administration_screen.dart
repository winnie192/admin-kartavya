import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AdministrationScreen extends StatelessWidget {
  final ValueChanged<String> onModuleTap;

  const AdministrationScreen({super.key, required this.onModuleTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModuleGrid(),
        ],
      ),
    );
  }

  Widget _buildModuleGrid() {
    final modules = [
      _Module('Manage Course', 'Manage Course', Icons.menu_book, AppColors.primaryBlue),
      _Module('Manage User', 'Manage User', Icons.people, AppColors.orange),
      _Module('Manage Guest', 'Manage Guest', Icons.person_add, AppColors.green),
      _Module('Trainee Progress', 'Track Trainee Progress', Icons.trending_up, AppColors.amber),
      _Module('Request Received', 'Request Received', Icons.inbox, AppColors.red),
      _Module('Exams', 'Manage Exams', Icons.assignment, AppColors.primaryBlue),
      _Module('Certificates', 'Manage Certificates', Icons.card_membership, AppColors.green),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: modules.map((m) => _buildModuleCard(m)).toList(),
    );
  }

  Widget _buildModuleCard(_Module module) {
    return GestureDetector(
      onTap: () => onModuleTap(module.id),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: module.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(module.icon, color: module.color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              module.id,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              module.subtitle,
              style: const TextStyle(fontSize: 9, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}

class _Module {
  final String id;
  final String subtitle;
  final IconData icon;
  final Color color;
  _Module(this.id, this.subtitle, this.icon, this.color);
}
