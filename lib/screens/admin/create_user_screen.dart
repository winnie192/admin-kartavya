import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/admin_sidebar.dart';

class CreateUserScreen extends StatefulWidget {
  final bool isGuest;
  const CreateUserScreen({super.key, this.isGuest = false});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final title = widget.isGuest ? 'Add Guest' : 'Create User';

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const Drawer(child: AdminSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: Text(title, style: const TextStyle(fontSize: 16)),
              leading: IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => Navigator.pop(context)),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const AdminSidebar(),
          Expanded(
            child: Padding(
              padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(16),
                  boxShadow: isMobile ? [] : [BoxShadow(color: AppColors.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Column(
                  children: [
                    if (!isMobile)
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 16, right: 12),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.borderGrey)),
                                child: const Icon(Icons.arrow_back, size: 14, color: AppColors.textDark),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                          ],
                        ),
                      ),
                    const Divider(height: 20, color: AppColors.borderGrey),
                    Expanded(child: _buildForm()),
                    _buildBottomActions(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar & name header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.amber,
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isGuest ? 'New Guest' : 'New User',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                  if (widget.isGuest)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(color: AppColors.amber.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                      child: const Text('Guest', style: TextStyle(fontSize: 8, color: AppColors.amber, fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Personal Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          _buildFieldRow3('First Name', 'Last Name', 'Employee Code'),
          const SizedBox(height: 10),
          _buildFieldRow3('Email ID', 'Contact Number', 'User Type'),
          const SizedBox(height: 10),
          _buildFieldRow3('Business Segment', 'Department', 'Client'),
          const SizedBox(height: 10),
          if (widget.isGuest) ...[
            _buildFieldRow3('Program', 'Role Assign', 'Start Date'),
            const SizedBox(height: 10),
            _buildFieldRow2('End Date', 'Hours Assign'),
          ] else ...[
            _buildFieldRow2('Program', 'Role Assign'),
          ],
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text('View Access Details', style: TextStyle(fontSize: 10, color: AppColors.primaryBlue)),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldRow3(String l1, String l2, String l3) {
    return Row(
      children: [
        Expanded(child: _buildField(l1)),
        const SizedBox(width: 10),
        Expanded(child: _buildField(l2)),
        const SizedBox(width: 10),
        Expanded(child: _buildField(l3)),
      ],
    );
  }

  Widget _buildFieldRow2(String l1, String l2) {
    return Row(
      children: [
        Expanded(child: _buildField(l1)),
        const SizedBox(width: 10),
        Expanded(child: _buildField(l2)),
        const SizedBox(width: 10),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _buildField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 3),
        Container(
          width: double.infinity,
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextField(
              style: const TextStyle(fontSize: 10, color: AppColors.textDark),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.borderGrey))),
      child: Row(
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.primaryBlue, fontSize: 11)),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.isGuest ? 'Guest added' : 'User created')));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              elevation: 0,
            ),
            child: Text(widget.isGuest ? 'Add Guest' : 'Create', style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
