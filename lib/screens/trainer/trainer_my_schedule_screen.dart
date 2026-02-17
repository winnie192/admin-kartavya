import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TrainerMyScheduleScreen extends StatefulWidget {
  const TrainerMyScheduleScreen({super.key});

  @override
  State<TrainerMyScheduleScreen> createState() => _TrainerMyScheduleScreenState();
}

class _TrainerMyScheduleScreenState extends State<TrainerMyScheduleScreen> {
  bool _isDetailView = false;
  int _viewMode = 2; // 0=Day, 1=Week, 2=Month
  String _selectedFilter = 'All';

  // Event data per day (day number → list of colored time slots)
  final Map<int, List<_CalendarEvent>> _events = {
    1: [_CalendarEvent('01:00PM - 04:30PM', const Color(0xFF4CAF50)), _CalendarEvent('8:00AM - 10:00AM', const Color(0xFF2196F3))],
    2: [_CalendarEvent('02:00PM - 04:30PM', const Color(0xFFE53935)), _CalendarEvent('07:00AM - 11:30AM', const Color(0xFF4CAF50)), _CalendarEvent('01:00PM - 02:00PM', const Color(0xFFFF9800))],
    3: [_CalendarEvent('01:00PM - 04:30PM', const Color(0xFF2196F3)), _CalendarEvent('8:00AM - 10:00AM', const Color(0xFF4CAF50))],
    4: [_CalendarEvent('01:00PM - 02:00PM', const Color(0xFFE53935)), _CalendarEvent('01:00PM - 04:30PM', const Color(0xFF2196F3)), _CalendarEvent('8:00AM - 10:00AM', const Color(0xFF4CAF50))],
    5: [_CalendarEvent('01:00PM - 04:30PM', const Color(0xFF2196F3)), _CalendarEvent('07:00AM - 11:30AM', const Color(0xFF4CAF50)), _CalendarEvent('8:00AM - 10:00AM', const Color(0xFFFF9800)), _CalendarEvent('01:00PM - 02:00PM', const Color(0xFFE53935)), _CalendarEvent('02:00PM - 04:30PM', const Color(0xFF9C27B0))],
    6: [_CalendarEvent('01:00PM - 04:30PM', const Color(0xFF2196F3)), _CalendarEvent('07:00AM - 11:30AM', const Color(0xFF4CAF50))],
    8: [_CalendarEvent('01:00PM - 04:30PM', const Color(0xFF2196F3))],
    9: [_CalendarEvent('07:00AM - 11:30AM', const Color(0xFF4CAF50)), _CalendarEvent('8:00AM - 10:00AM', const Color(0xFF2196F3))],
    11: [_CalendarEvent('01:00PM - 02:00PM', const Color(0xFFE53935))],
    12: [_CalendarEvent('01:00PM - 04:30PM', const Color(0xFF2196F3)), _CalendarEvent('01:00PM - 04:30PM', const Color(0xFF4CAF50))],
    13: [_CalendarEvent('02:00PM - 04:30PM', const Color(0xFFE53935)), _CalendarEvent('07:00AM - 11:30AM', const Color(0xFF4CAF50))],
    14: [_CalendarEvent('01:00PM - 02:00PM', const Color(0xFFE53935))],
    16: [_CalendarEvent('02:00PM - 04:30PM', const Color(0xFF2196F3))],
    17: [_CalendarEvent('01:00PM - 04:30PM', const Color(0xFFE53935)), _CalendarEvent('8:00AM - 10:00AM', const Color(0xFF4CAF50))],
    18: [_CalendarEvent('01:00PM - 02:00PM', const Color(0xFFE53935)), _CalendarEvent('01:00PM - 04:30PM', const Color(0xFF2196F3))],
    19: [_CalendarEvent('07:00AM - 11:30AM', const Color(0xFF4CAF50)), _CalendarEvent('8:00AM - 10:00AM', const Color(0xFF2196F3))],
    20: [_CalendarEvent('07:00AM - 11:30AM', const Color(0xFF4CAF50))],
    21: [_CalendarEvent('01:00PM - 02:00PM', const Color(0xFFE53935)), _CalendarEvent('01:00PM - 02:00PM', const Color(0xFF2196F3))],
  };

  final _detailItems = const [
    _DetailItem('09:00AM - 10:00PM', 'Session:', 'Curriculum Review Discussion', Color(0xFF4CAF50)),
    _DetailItem('10:00AM - 11:00PM', 'Meeting:', 'Curriculum Review Discussion', Color(0xFFFF9800)),
    _DetailItem('09:00AM - 10:00PM', 'Session:', 'Curriculum Review Discussion', Color(0xFF2196F3)),
    _DetailItem('09:00AM - 10:00PM', 'Meeting:', 'Curriculum Review Discussion', Color(0xFFE53935)),
    _DetailItem('09:00AM - 10:00PM', 'Session:', 'Curriculum Review Discussion', Color(0xFF4CAF50)),
    _DetailItem('11:00AM - 12:30PM', 'Session:', 'Curriculum Review Discussion', Color(0xFFFF9800)),
    _DetailItem('10:00AM - 11:00PM', 'Session:', 'Curriculum Review Discussion', Color(0xFF2196F3)),
    _DetailItem('11:00AM - 12:30PM', 'Session:', 'Curriculum Review Discussion', Color(0xFF9C27B0)),
    _DetailItem('10:00AM - 11:00PM', 'Session:', 'Curriculum Review Discussion', Color(0xFF4CAF50)),
    _DetailItem('09:00AM - 10:00PM', 'Meeting:', 'Curriculum Review Discussion', Color(0xFFE53935)),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar
          Row(
            children: [
              // Detail View toggle
              Row(
                children: [
                  Checkbox(
                    value: _isDetailView,
                    onChanged: (v) => setState(() => _isDetailView = v ?? false),
                    visualDensity: VisualDensity.compact,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _isDetailView = !_isDetailView),
                    child: const Text('Detail View', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                  ),
                ],
              ),
              const Spacer(),
              // Date
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: AppColors.textGrey),
                    const SizedBox(width: 6),
                    const Text('27-03-2025', style: TextStyle(fontSize: 11, color: AppColors.textDark)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // View mode toggle
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _viewBtn('Day', 0),
                    _viewBtn('Week', 1),
                    _viewBtn('Month', 2),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Create Schedule', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _isDetailView
              ? _buildDetailView()
              : _viewMode == 0
                  ? _buildDayView()
                  : _viewMode == 1
                      ? _buildWeekView()
                      : _buildCalendarView(),
        ],
      ),
    );
  }

  Widget _viewBtn(String label, int index) {
    final isActive = _viewMode == index;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 11, color: isActive ? Colors.white : AppColors.textDark, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left, size: 20, color: AppColors.primaryBlue)),
              const Text('March 2025 ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
              const Icon(Icons.chevron_right, size: 16, color: AppColors.primaryBlue),
            ],
          ),
          const SizedBox(height: 8),
          // Day headers
          Row(
            children: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                .map((d) => Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withValues(alpha: 0.05),
                          border: Border.all(color: AppColors.borderGrey, width: 0.5),
                        ),
                        child: Center(child: Text(d, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark))),
                      ),
                    ))
                .toList(),
          ),
          // Calendar grid (March 2025 starts on Saturday, day 1)
          // Week rows: pre-pad with blanks for Mon-Fri (5 blanks for March 2025 starting on Saturday)
          _buildWeekRow([-1, -1, -1, -1, -1, 1, 2]),
          _buildWeekRow([3, 4, 5, 6, 7, 8, 9]),
          _buildWeekRow([10, 11, 12, 13, 14, 15, 16]),
          _buildWeekRow([17, 18, 19, 20, 21, 22, 23]),
          _buildWeekRow([24, 25, 26, 27, 28, 29, 30]),
          _buildWeekRow([31, -1, -1, -1, -1, -1, -1]),
        ],
      ),
    );
  }

  Widget _buildWeekRow(List<int> days) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: days.map((day) {
        if (day == -1) {
          return Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 80),
              decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey, width: 0.5)),
            ),
          );
        }
        final dayEvents = _events[day] ?? [];
        return Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 80),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey, width: 0.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$day', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 2),
                if (dayEvents.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('NA', style: TextStyle(fontSize: 8, color: AppColors.textGrey)),
                  )
                else
                  ...dayEvents.take(4).map((e) => Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                          color: e.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.schedule, size: 7, color: e.color),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Text(e.timeRange,
                                  style: TextStyle(fontSize: 7, color: e.color, fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      )),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeekView() {
    // Week of March 24-30, 2025
    final weekDays = [
      {'label': 'Monday', 'date': '24', 'day': 24},
      {'label': 'Tuesday', 'date': '25', 'day': 25},
      {'label': 'Wednesday', 'date': '26', 'day': 26},
      {'label': 'Thursday', 'date': '27', 'day': 27},
      {'label': 'Friday', 'date': '28', 'day': 28},
      {'label': 'Saturday', 'date': '29', 'day': 29},
      {'label': 'Sunday', 'date': '30', 'day': 30},
    ];

    final morningEvents = <int, List<_WeekEvent>>{
      24: [_WeekEvent('Session: Advanced JavaScript', '09:00AM - 11:00AM', const Color(0xFF2196F3))],
      25: [_WeekEvent('Meeting: Curriculum Review Discussion', '09:00AM - 10:00AM', const Color(0xFF4CAF50))],
      26: [_WeekEvent('Session: Database Management', '10:00AM - 12:00PM', const Color(0xFFFF9800))],
      27: [_WeekEvent('Meeting: Curriculum Review Discussion', '09:00AM - 10:00AM', const Color(0xFF4CAF50)), _WeekEvent('Session: React Basics', '10:30AM - 12:00PM', const Color(0xFF2196F3))],
      28: [_WeekEvent('Session: Advanced JavaScript', '09:00AM - 11:00AM', const Color(0xFF9C27B0))],
    };
    final afternoonEvents = <int, List<_WeekEvent>>{
      24: [_WeekEvent('Session: Database Management & SQL Optimization', '01:00PM - 03:00PM', const Color(0xFF4CAF50))],
      25: [_WeekEvent('Meeting: Sprint Planning', '02:00PM - 03:30PM', const Color(0xFFE53935))],
      27: [_WeekEvent('Session: Flutter State Management', '01:00PM - 03:00PM', const Color(0xFF2196F3))],
      29: [_WeekEvent('Meeting: Curriculum Review Discussion', '01:00PM - 02:00PM', const Color(0xFFFF9800))],
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left, size: 20, color: AppColors.primaryBlue)),
              const Text('March 2025', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
              const Icon(Icons.chevron_right, size: 16, color: AppColors.primaryBlue),
            ],
          ),
          const SizedBox(height: 8),
          // Day headers with dates
          Row(
            children: weekDays.map((d) => Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.05),
                  border: Border.all(color: AppColors.borderGrey, width: 0.5),
                ),
                child: Column(
                  children: [
                    Text(d['label'] as String, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    Text(d['date'] as String, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  ],
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: 4),
          // Morning Slot label
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            color: const Color(0xFFFFF8E1),
            child: const Text('Morning Slot  9:00AM - 1:00PM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          // Morning events row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weekDays.map((d) {
              final day = d['day'] as int;
              final events = morningEvents[day] ?? [];
              return Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 80),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey, width: 0.5)),
                  child: events.isEmpty
                      ? const Center(child: Text('NA', style: TextStyle(fontSize: 8, color: AppColors.textGrey)))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: events.map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: e.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.title, style: TextStyle(fontSize: 7, color: e.color, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 1),
                                Text(e.time, style: TextStyle(fontSize: 6, color: e.color)),
                              ],
                            ),
                          )).toList(),
                        ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 4),
          // Afternoon Slot label
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            color: const Color(0xFFE8F5E9),
            child: const Text('Afternoon Slot  1:00PM - 4:00PM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          // Afternoon events row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weekDays.map((d) {
              final day = d['day'] as int;
              final events = afternoonEvents[day] ?? [];
              return Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 80),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey, width: 0.5)),
                  child: events.isEmpty
                      ? const Center(child: Text('NA', style: TextStyle(fontSize: 8, color: AppColors.textGrey)))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: events.map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: e.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.title, style: TextStyle(fontSize: 7, color: e.color, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 1),
                                Text(e.time, style: TextStyle(fontSize: 6, color: e.color)),
                              ],
                            ),
                          )).toList(),
                        ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayView() {
    // Day view for March 27, 2025 (Thursday)
    final daySlots = [
      _DaySlot('08:00AM', '09:00AM', 'Session: Advanced JavaScript Concepts', const Color(0xFF2196F3)),
      _DaySlot('09:00AM', '10:00AM', 'Meeting: Curriculum Review Discussion', const Color(0xFF4CAF50)),
      _DaySlot('10:00AM', '11:00AM', 'Session: React Fundamentals Workshop', const Color(0xFFFF9800)),
      _DaySlot('11:00AM', '12:00PM', 'Session: Database Management & SQL Optimization', const Color(0xFF9C27B0)),
      _DaySlot('01:00PM', '02:00PM', 'Meeting: Sprint Planning & Review', const Color(0xFFE53935)),
      _DaySlot('02:00PM', '03:30PM', 'Session: Flutter State Management', const Color(0xFF2196F3)),
      _DaySlot('03:30PM', '04:30PM', 'Session: Cloud Infrastructure Basics', const Color(0xFF4CAF50)),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left, size: 20, color: AppColors.primaryBlue)),
              const Text('27th March 2025, Thursday', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
              const Icon(Icons.chevron_right, size: 16, color: AppColors.primaryBlue),
            ],
          ),
          const SizedBox(height: 12),
          // Morning Slot
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            color: const Color(0xFFFFF8E1),
            child: const Text('Morning Slot', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          const SizedBox(height: 4),
          ...daySlots.where((s) => !s.start.contains('PM') || s.start == '12:00PM').map((slot) => Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: slot.color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border(left: BorderSide(color: slot.color, width: 4)),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 14, color: slot.color),
                const SizedBox(width: 8),
                Text('${slot.start} - ${slot.end}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: slot.color)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(slot.title, style: const TextStyle(fontSize: 11, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          )),
          const SizedBox(height: 8),
          // Afternoon Slot
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            color: const Color(0xFFE8F5E9),
            child: const Text('Afternoon Slot', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          const SizedBox(height: 4),
          ...daySlots.where((s) => s.start.contains('PM') && s.start != '12:00PM').map((slot) => Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: slot.color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border(left: BorderSide(color: slot.color, width: 4)),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 14, color: slot.color),
                const SizedBox(width: 8),
                Text('${slot.start} - ${slot.end}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: slot.color)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(slot.title, style: const TextStyle(fontSize: 11, color: AppColors.textDark), overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDetailView() {
    final filters = ['All', 'Upcoming', 'Complete', 'Priority', 'Reschedule', 'Cancel'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter tabs + date range
          Row(
            children: [
              ...filters.map((f) {
                final isActive = _selectedFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedFilter = f),
                    child: Text(f,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                          color: isActive ? AppColors.primaryBlue : AppColors.textGrey,
                        )),
                  ),
                );
              }),
              const Spacer(),
              const Text('From', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(width: 4),
              _buildDateChip('20-03-2025'),
              const SizedBox(width: 8),
              const Text('To', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(width: 4),
              _buildDateChip('27-03-2025'),
            ],
          ),
          const SizedBox(height: 16),
          // Detail list
          ..._detailItems.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(left: BorderSide(color: item.color, width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 12, color: item.color),
                        const SizedBox(width: 6),
                        Text(item.timeRange, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textDark)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: '${item.type} ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: item.color)),
                          TextSpan(text: item.description, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 11, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(date, style: const TextStyle(fontSize: 10, color: AppColors.textDark)),
        ],
      ),
    );
  }
}

class _CalendarEvent {
  final String timeRange;
  final Color color;
  const _CalendarEvent(this.timeRange, this.color);
}

class _DetailItem {
  final String timeRange, type, description;
  final Color color;
  const _DetailItem(this.timeRange, this.type, this.description, this.color);
}

class _WeekEvent {
  final String title, time;
  final Color color;
  const _WeekEvent(this.title, this.time, this.color);
}

class _DaySlot {
  final String start, end, title;
  final Color color;
  const _DaySlot(this.start, this.end, this.title, this.color);
}
