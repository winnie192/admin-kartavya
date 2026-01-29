import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ManageCourseScreen extends StatelessWidget {
  const ManageCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(context),
          const SizedBox(height: 12),
          _buildCourseTable(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180, height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 14),
                  prefixIconConstraints: const BoxConstraints(minWidth: 30),
                  hintText: 'Search ...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.borderGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
              child: const Text('Search', style: TextStyle(fontSize: 10)),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/create-course');
              },
              icon: const Icon(Icons.add, size: 12),
              label: const Text('New Course', style: TextStyle(fontSize: 10)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildFilterChip('Business Segment'),
            _buildFilterChip('Department'),
            _buildFilterChip('Client'),
            _buildFilterChip('Program'),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderGrey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseTable() {
    final courses = [
      ['The new course for the coders of future....', '21hrs:32mins', '312', 'Published'],
      ['UI/UX Designs for Beginners with Generative', '104hrs:53mins', '109', 'Rejected'],
      ['Natural Language Processing (NLP) with AI', '11hrs:02mins', '0', 'Approved'],
      ['MIT Introduction to Computer Science and Pr', '01hrs:09mins', '12', 'Inactive'],
      ['Software Testing - Manual Testing, Automatio', '29hrs:56mins', '0', 'Under Review'],
      ['The new course for the coders of future....', '21hrs:32mins', '312', 'Published'],
      ['The new course for the coders of future....', '21hrs:32mins', '312', 'Published'],
      ['UI/UX Designs for Beginners with Generative', '104hrs:53mins', '109', 'Rejected'],
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.borderGrey)),
            ),
            child: Row(
              children: [
                _headerCell('Select', width: 35),
                _headerCell('Info', width: 20),
                _headerCell('Course Name', flex: 3),
                _headerCell('Duration', flex: 2),
                _headerCell('Learners', flex: 1),
                _headerCell('Status', flex: 2),
                _headerCell('People Involved', flex: 2),
                _headerCell('Action', flex: 1),
              ],
            ),
          ),
          ...courses.map((c) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5)),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Checkbox(
                        value: false, onChanged: (_) {},
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: 20, child: Icon(Icons.info_outline, size: 12, color: AppColors.textGrey)),
                    Expanded(flex: 3, child: Text(c[0], style: const TextStyle(fontSize: 9, color: AppColors.textDark), overflow: TextOverflow.ellipsis)),
                    Expanded(flex: 2, child: Text(c[1], style: const TextStyle(fontSize: 9, color: AppColors.textGrey))),
                    Expanded(flex: 1, child: Text(c[2], style: const TextStyle(fontSize: 9, color: AppColors.textDark))),
                    Expanded(flex: 2, child: _statusBadge(c[3])),
                    Expanded(flex: 2, child: _buildPeopleInvolved()),
                    Expanded(flex: 1, child: const Icon(Icons.more_vert, size: 14, color: AppColors.textGrey)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text('1-6  of  1', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                const Spacer(),
                const Icon(Icons.chevron_left, size: 14, color: AppColors.textGrey),
                const Text('1/1', style: TextStyle(fontSize: 9)),
                const Icon(Icons.chevron_right, size: 14, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _headerCell(String text, {double? width, int flex = 1}) {
    final child = Text(text, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey));
    if (width != null) return SizedBox(width: width, child: child);
    return Expanded(flex: flex, child: child);
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'Published': color = AppColors.statusPublished; break;
      case 'Rejected': color = AppColors.statusRejected; break;
      case 'Approved': color = AppColors.statusApproved; break;
      case 'Inactive': color = AppColors.statusInactive; break;
      case 'Under Review': color = AppColors.statusUnderReview; break;
      default: color = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildPeopleInvolved() {
    return Row(
      children: [
        _roleDot('PM', AppColors.red),
        _roleDot('A', AppColors.amber),
        _roleDot('T', AppColors.primaryBlue),
      ],
    );
  }

  Widget _roleDot(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      width: 14, height: 14,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(child: Text(label, style: const TextStyle(fontSize: 6, color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }
}
