import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  int selectedTab = 0;
  final tabs = ['Profile', 'Courses', 'Task', 'Sessions', 'Exams', 'Schedule'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 12),
          _buildStatsRow(),
          const SizedBox(height: 12),
          _buildTabBar(),
          const SizedBox(height: 12),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.amber,
          child: const Text('A', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ankit Dharmnath Pandey',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 2),
            Row(
              children: [
                const Text('Trainee', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('Front Runner', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      _Stat('34', 'Enrolled Courses', AppColors.primaryBlue),
      _Stat('12', 'Completed Courses', AppColors.green),
      _Stat('21', 'Ongoing Courses', AppColors.orange),
      _Stat('21', 'Not Started', AppColors.grey),
      _Stat('21', 'Expired Courses', AppColors.red),
      _Stat('21', 'Hours Completed', AppColors.amber),
      _Stat('21', 'Certificates', AppColors.green),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stats.map((s) => Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: s.color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: s.color.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Text(s.value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: s.color)),
              const SizedBox(height: 2),
              Text(s.label, style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.asMap().entries.map((e) {
          final isActive = e.key == selectedTab;
          return GestureDetector(
            onTap: () => setState(() => selectedTab = e.key),
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
              ),
              child: Text(
                e.value,
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? Colors.white : AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0: return _buildProfileTab();
      case 1: return _buildCoursesTab();
      case 4: return _buildExamsTab();
      case 5: return _buildScheduleTab();
      default: return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text('${tabs[selectedTab]} content', style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        ),
      );
    }
  }

  Widget _buildProfileTab() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personal Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          _buildFieldRow('First Name', 'Ankit', 'Last Name', 'Pandey'),
          _buildFieldRow('Employee Code', 'KH3201', 'Email ID', 'ankitpandey@gmail.com'),
          _buildFieldRow('Contact Number', '987123569', 'User Type', 'Employee'),
          _buildFieldRow('Business Segment', 'Cipla_new', 'Department', 'Operations'),
          _buildFieldRow('Client', 'cipla_new_abc_222_345', 'Program', 'cipla_new_abc_222_345'),
          _buildFieldRow('Role Assign', 'Trainee', '', ''),
          const SizedBox(height: 14),
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

  Widget _buildFieldRow(String label1, String val1, String label2, String val2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: _buildField(label1, val1)),
          if (label2.isNotEmpty) ...[
            const SizedBox(width: 12),
            Expanded(child: _buildField(label2, val2)),
          ] else
            const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(value, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
        ),
      ],
    );
  }

  Widget _buildCoursesTab() {
    final courses = [
      ['Completed', 'Achiever', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m'],
      ['Ongoing', 'Pending', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m'],
      ['Not Started', 'Aspirant', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m'],
      ['Completed', 'Front Runner', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m'],
      ['Completed', 'Achiever', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m'],
      ['Ongoing', 'Front Runner', "Beginner's Guide to becoming a professional frontend developer", '04hrs:52m'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Total Courses : 24', style: TextStyle(fontSize: 10, color: AppColors.textDark)),
            const SizedBox(width: 10),
            const Text('Not Started : 120', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
            const SizedBox(width: 6),
            const Text('Ongoing : 125', style: TextStyle(fontSize: 9, color: AppColors.orange)),
            const SizedBox(width: 6),
            const Text('Completed : 25', style: TextStyle(fontSize: 9, color: AppColors.green)),
          ],
        ),
        const SizedBox(height: 10),
        ...courses.map((c) => _buildCourseCard(c[0], c[1], c[2], c[3])),
      ],
    );
  }

  Widget _buildCourseCard(String status, String grade, String title, String duration) {
    Color statusColor;
    switch (status) {
      case 'Completed': statusColor = AppColors.green; break;
      case 'Ongoing': statusColor = AppColors.orange; break;
      default: statusColor = AppColors.grey;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 40,
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
                      child: Text(status, style: TextStyle(fontSize: 7, color: statusColor, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
                      child: Text(grade, style: const TextStyle(fontSize: 7, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(title, style: const TextStyle(fontSize: 10, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
                Text(duration, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
              ],
            ),
          ),
          Column(
            children: [
              if (status == 'Completed')
                const Text('Certificate', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue)),
              const SizedBox(height: 4),
              const Text('View Course', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExamsTab() {
    final exams = [
      ['06 Dec 2023-12 Dec 2023', 'Ongoing', '45'],
      ['11 Apr 2025', 'Upcoming', '45'],
      ['26 Aug 2023 - 30 Aug 2023', 'Complete', '45'],
      ['20 Oct 2025 - 29 Oct 2025', 'Cancel', '45'],
      ['06 Dec 2023-12 Dec 2023', 'Upcoming', '45'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Total Exams : 24', style: TextStyle(fontSize: 10, color: AppColors.textDark)),
            const SizedBox(width: 8),
            const Text('Upcoming:05', style: TextStyle(fontSize: 9, color: AppColors.amber)),
            const SizedBox(width: 6),
            const Text('Completed:10', style: TextStyle(fontSize: 9, color: AppColors.green)),
            const SizedBox(width: 6),
            const Text('Ongoing:01', style: TextStyle(fontSize: 9, color: AppColors.primaryBlue)),
            const SizedBox(width: 6),
            const Text('Cancel:03', style: TextStyle(fontSize: 9, color: AppColors.red)),
          ],
        ),
        const SizedBox(height: 10),
        ...exams.map((e) => _buildExamCard(e[0], e[1], e[2])),
      ],
    );
  }

  Widget _buildExamCard(String date, String status, String duration) {
    Color statusColor;
    switch (status) {
      case 'Ongoing': statusColor = AppColors.statusOngoing; break;
      case 'Upcoming': statusColor = AppColors.statusUpcoming; break;
      case 'Complete': statusColor = AppColors.statusComplete; break;
      case 'Cancel': statusColor = AppColors.statusCancel; break;
      default: statusColor = AppColors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 40,
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
                  child: Text(status, style: TextStyle(fontSize: 7, color: statusColor, fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 3),
                Text('Duration - $duration min', style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
                const Text('Assess your skills in writing complex SQL queries..........', style: TextStyle(fontSize: 9, color: AppColors.textDark)),
              ],
            ),
          ),
          Column(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text('Preview Exam', style: TextStyle(fontSize: 7, color: AppColors.primaryBlue)),
              ),
              const SizedBox(height: 4),
              if (status == 'Complete')
                const Text('Result', style: TextStyle(fontSize: 8, color: AppColors.green))
              else
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    side: const BorderSide(color: AppColors.amber),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Text('Take Test', style: TextStyle(fontSize: 7, color: AppColors.amber)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('March 2025', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              _buildScheduleViewBtn('Day', false),
              _buildScheduleViewBtn('Week', false),
              _buildScheduleViewBtn('Month', true),
            ],
          ),
          const SizedBox(height: 10),
          // Day headers
          Row(
            children: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                .map((d) => Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
                        ),
                        child: Text(d, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500, color: AppColors.textGrey)),
                      ),
                    ))
                .toList(),
          ),
          // Calendar grid (3 weeks)
          ...List.generate(3, (week) => Row(
                children: List.generate(7, (day) {
                  final num = week * 7 + day + 1;
                  if (num > 21) return const Expanded(child: SizedBox(height: 50));
                  return Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderGrey, width: 0.5),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$num', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500)),
                          if (num % 3 == 0)
                            Text('01:00PM', style: TextStyle(fontSize: 6, color: AppColors.primaryBlue)),
                        ],
                      ),
                    ),
                  );
                }),
              )),
        ],
      ),
    );
  }

  Widget _buildScheduleViewBtn(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
      ),
      child: Text(label, style: TextStyle(fontSize: 8, color: isActive ? Colors.white : AppColors.textGrey)),
    );
  }
}

class _Stat {
  final String value, label;
  final Color color;
  _Stat(this.value, this.label, this.color);
}
