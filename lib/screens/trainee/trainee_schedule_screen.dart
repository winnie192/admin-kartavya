import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TraineeScheduleScreen extends StatefulWidget {
  const TraineeScheduleScreen({super.key});

  @override
  State<TraineeScheduleScreen> createState() => _TraineeScheduleScreenState();
}

class _TraineeScheduleScreenState extends State<TraineeScheduleScreen> {
  bool _isCalendarView = true;
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.calendar_month, size: 18, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              const Text('My Schedule',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const Spacer(),
              // View toggle
              TextButton(
                onPressed: () => setState(() => _isCalendarView = !_isCalendarView),
                child: Text(
                  _isCalendarView ? 'Detail View' : 'Calendar View',
                  style: const TextStyle(fontSize: 12, color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_isCalendarView) _buildCalendarView() else _buildDetailView(),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    return Column(
      children: [
        // Month nav + Day/Week/Month
        Row(
          children: [
            const Icon(Icons.chevron_left, size: 20, color: AppColors.textGrey),
            const Text(' March 2025 ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textGrey),
            const Spacer(),
            _dateChip('27-03-2025'),
            const SizedBox(width: 8),
            _viewTab('Day'),
            _viewTab('Week'),
            _viewTab('Month', active: true),
          ],
        ),
        const SizedBox(height: 16),
        // Calendar grid
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderGrey),
          ),
          child: Column(
            children: [
              // Day headers
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.borderGrey)),
                ),
                child: Row(
                  children: [
                    for (final day in [
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday',
                      'Sunday'
                    ])
                      Expanded(
                        child: Center(
                          child: Text(day,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textGrey)),
                        ),
                      ),
                  ],
                ),
              ),
              // Calendar weeks (simplified 4-week grid)
              for (int week = 0; week < 5; week++)
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColors.borderGrey)),
                  ),
                  child: Row(
                    children: [
                      for (int day = 0; day < 7; day++)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: day < 6
                                  ? const Border(
                                      right: BorderSide(
                                          color: AppColors.borderGrey))
                                  : null,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: _buildCalendarCell(week, day),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCell(int week, int day) {
    // Calculate date number (March 2025 starts on Saturday -> offset 5)
    final dateNum = week * 7 + day - 4; // offset for March 2025
    if (dateNum < 1 || dateNum > 31) {
      return const SizedBox.shrink();
    }

    // Sample time slots for some dates
    final slots = _calendarSlots[dateNum] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$dateNum',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        for (final slot in slots.take(3))
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding:
                const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            decoration: BoxDecoration(
              color: slot.$2.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(slot.$1,
                style: TextStyle(fontSize: 7, color: slot.$2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
      ],
    );
  }

  Widget _buildDetailView() {
    return Column(
      children: [
        // Filter tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final f in [
                'All',
                'Upcoming',
                'Complete',
                'Pending',
                'Ongoing',
                'Reschedule',
                'Cancel'
              ]) ...[
                _filterTab(f),
                const SizedBox(width: 6),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _dateChip('From  20-03-2025'),
            const SizedBox(width: 8),
            _dateChip('To  27-03-2025'),
          ],
        ),
        const SizedBox(height: 16),
        // Schedule list
        ..._detailSchedule.map((s) => _ScheduleDetailItem(schedule: s)),
      ],
    );
  }

  Widget _filterTab(String label) {
    final isActive = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryBlue.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color:
                  isActive ? AppColors.primaryBlue : AppColors.borderGrey),
        ),
        child: Text(label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? AppColors.primaryBlue : AppColors.textGrey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            )),
      ),
    );
  }

  Widget _dateChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }

  Widget _viewTab(String label, {bool active = false}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
          color: active ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: active ? AppColors.primaryBlue : AppColors.borderGrey),
        ),
        child: Text(label,
            style: TextStyle(
              fontSize: 11,
              color: active ? Colors.white : AppColors.textGrey,
            )),
      ),
    );
  }
}

// Sample calendar slot data
const Map<int, List<(String, Color)>> _calendarSlots = {
  1: [
    ('01:00PM - 04:30PM', AppColors.orange),
    ('8:00AM - 10:00AM', AppColors.green),
  ],
  2: [
    ('02:00PM - 04:30PM', AppColors.orange),
    ('07:00AM - 11:30AM', AppColors.primaryBlue),
    ('01:00PM - 02:00PM', AppColors.red),
  ],
  3: [
    ('01:00PM - 04:30PM', AppColors.orange),
    ('8:00AM - 10:00AM', AppColors.green),
  ],
  4: [
    ('01:00PM - 02:00PM', AppColors.red),
    ('01:00PM - 04:30PM', AppColors.orange),
    ('8:00AM - 10:00AM', AppColors.green),
  ],
  5: [
    ('01:00PM - 04:30PM', AppColors.orange),
    ('07:00AM - 11:30AM', AppColors.primaryBlue),
    ('8:00AM - 10:00AM', AppColors.green),
  ],
  8: [
    ('01:00PM - 04:30PM', AppColors.orange),
    ('8:00AM - 10:00AM', AppColors.green),
  ],
  12: [
    ('01:00PM - 04:30PM', AppColors.orange),
    ('8:00AM - 10:00AM', AppColors.green),
  ],
  15: [
    ('01:00PM - 04:30PM', AppColors.orange),
    ('8:00AM - 10:00AM', AppColors.green),
  ],
};

class _ScheduleData {
  final String time;
  final String date;
  final String title;
  final Color color;

  const _ScheduleData({
    required this.time,
    required this.date,
    required this.title,
    required this.color,
  });
}

const _detailSchedule = [
  _ScheduleData(
    time: '09:00AM - 10:00PM',
    date: '20-03-2025',
    title: 'Meeting: Curriculum Review Discussion',
    color: AppColors.orange,
  ),
  _ScheduleData(
    time: '10:00AM - 11:00PM',
    date: '20-03-2025',
    title: 'Session: Curriculum Review Discussion',
    color: AppColors.green,
  ),
  _ScheduleData(
    time: '09:00AM - 10:00PM',
    date: '22-03-2025',
    title: 'Meeting: Curriculum Review Discussion',
    color: AppColors.orange,
  ),
  _ScheduleData(
    time: '09:00AM - 10:00PM',
    date: '22-03-2025',
    title: 'Meeting: Curriculum Review Discussion',
    color: AppColors.red,
  ),
  _ScheduleData(
    time: '09:00AM - 10:00PM',
    date: '22-03-2025',
    title: 'Meeting: Curriculum Review Discussion',
    color: AppColors.orange,
  ),
  _ScheduleData(
    time: '11:00AM - 12:30PM',
    date: '25-03-2025',
    title: 'Session: Curriculum Review Discussion',
    color: AppColors.green,
  ),
  _ScheduleData(
    time: '10:00AM - 11:00PM',
    date: '25-03-2025',
    title: 'Session: Curriculum Review Discussion',
    color: AppColors.primaryBlue,
  ),
  _ScheduleData(
    time: '11:00AM - 12:30PM',
    date: '26-03-2025',
    title: 'Session: Curriculum Review Discussion',
    color: AppColors.green,
  ),
  _ScheduleData(
    time: '10:00AM - 11:00PM',
    date: '26-03-2025',
    title: 'Session: Curriculum Review Discussion',
    color: AppColors.primaryBlue,
  ),
  _ScheduleData(
    time: '09:00AM - 10:00PM',
    date: '27-03-2025',
    title: 'Meeting: Curriculum Review Discussion',
    color: AppColors.orange,
  ),
];

class _ScheduleDetailItem extends StatelessWidget {
  final _ScheduleData schedule;

  const _ScheduleDetailItem({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: schedule.color.withValues(alpha: 0.15),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 14, color: schedule.color),
          const SizedBox(width: 6),
          Text(schedule.time,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600, color: schedule.color)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(schedule.title,
                style: const TextStyle(fontSize: 11)),
          ),
          Text(schedule.date,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
