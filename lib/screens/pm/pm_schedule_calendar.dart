import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class PmScheduleCalendar extends StatefulWidget {
  const PmScheduleCalendar({super.key});

  @override
  State<PmScheduleCalendar> createState() => _PmScheduleCalendarState();
}

class _PmScheduleCalendarState extends State<PmScheduleCalendar> {
  int _viewMode = 2; // 0=Day, 1=Week, 2=Month

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          if (_viewMode == 2) _buildMonthView(),
          if (_viewMode == 1) _buildWeekView(),
          if (_viewMode == 0) _buildDayView(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('March 2025', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 2),
            Text('27-03-2025', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
          ],
        ),
        const Spacer(),
        _buildViewToggle('Day', 0),
        const SizedBox(width: 4),
        _buildViewToggle('Week', 1),
        const SizedBox(width: 4),
        _buildViewToggle('Month', 2),
      ],
    );
  }

  Widget _buildViewToggle(String label, int mode) {
    final isActive = _viewMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
        ),
        child: Text(label, style: TextStyle(fontSize: 9, color: isActive ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildMonthView() {
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    // Sample events per day
    final events = <int, List<_CalEvent>>{
      3: [_CalEvent('01:00PM - 04:30PM', AppColors.primaryBlue)],
      5: [_CalEvent('8:00AM - 10:00AM', AppColors.orange)],
      8: [_CalEvent('09:00AM - 12:00PM', AppColors.green)],
      12: [_CalEvent('01:00PM - 04:30PM', AppColors.primaryBlue), _CalEvent('8:00AM - 10:00AM', AppColors.orange)],
      15: [_CalEvent('09:00AM - 01:00PM', AppColors.green)],
      18: [_CalEvent('01:00PM - 04:30PM', AppColors.primaryBlue)],
      22: [_CalEvent('8:00AM - 10:00AM', AppColors.orange)],
      25: [_CalEvent('09:00AM - 12:00PM', AppColors.green), _CalEvent('01:00PM - 04:00PM', AppColors.primaryBlue)],
      28: [_CalEvent('8:00AM - 10:00AM', AppColors.orange)],
    };

    return Column(
      children: [
        // Day headers
        Row(
          children: dayNames.map((d) => Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
              child: Text(d, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
            ),
          )).toList(),
        ),
        // Calendar grid (5 weeks for March)
        ...List.generate(5, (week) => Row(
          children: List.generate(7, (day) {
            final num = week * 7 + day + 1;
            if (num > 31) return Expanded(child: Container(height: 54, decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey, width: 0.3))));
            final dayEvents = events[num];
            return Expanded(
              child: Container(
                height: 54,
                decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey, width: 0.3)),
                padding: const EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$num', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500, color: num == 27 ? AppColors.primaryBlue : AppColors.textDark)),
                    if (dayEvents != null)
                      ...dayEvents.take(2).map((e) => Container(
                        margin: const EdgeInsets.only(top: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                        decoration: BoxDecoration(color: e.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(2)),
                        child: Text(e.label, style: TextStyle(fontSize: 5, color: e.color, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                      ))
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('NA', style: TextStyle(fontSize: 6, color: AppColors.textGrey.withValues(alpha: 0.4))),
                      ),
                  ],
                ),
              ),
            );
          }),
        )),
      ],
    );
  }

  Widget _buildWeekView() {
    final days = [
      _WeekDay('Mon', '24', []),
      _WeekDay('Tue', '25', [_SlotEvent('Morning', '09:00AM - 01:00PM', 'Meeting: Curriculum Review Discussion', AppColors.primaryBlue)]),
      _WeekDay('Wed', '26', [_SlotEvent('Afternoon', '01:00PM - 04:00PM', 'Session: Advanced JavaScript', AppColors.orange)]),
      _WeekDay('Thu', '27', [_SlotEvent('Morning', '09:00AM - 01:00PM', 'Session: Database Management & SQL Optimization', AppColors.green)]),
      _WeekDay('Fri', '28', []),
      _WeekDay('Sat', '29', [_SlotEvent('Morning', '09:00AM - 01:00PM', 'Meeting: Quarterly Review', AppColors.primaryBlue)]),
      _WeekDay('Sun', '30', []),
    ];

    return Column(
      children: [
        // Day headers
        Row(
          children: days.map((d) => Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
              child: Column(
                children: [
                  Text(d.name, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
                  Text(d.date, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: d.date == '27' ? AppColors.primaryBlue : AppColors.textDark)),
                ],
              ),
            ),
          )).toList(),
        ),
        // Morning slot row
        _buildSlotRow('Morning Slot', '9:00AM - 1:00PM', days, 'Morning'),
        // Afternoon slot row
        _buildSlotRow('Afternoon Slot', '1:00PM - 4:00PM', days, 'Afternoon'),
      ],
    );
  }

  Widget _buildSlotRow(String slotLabel, String timeRange, List<_WeekDay> days, String slotType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text('$slotLabel ($timeRange)', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
        ),
        Row(
          children: days.map((d) {
            final event = d.events.where((e) => e.slot == slotType).firstOrNull;
            return Expanded(
              child: Container(
                height: 60,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: event != null ? event.color.withValues(alpha: 0.08) : AppColors.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.borderGrey, width: 0.5),
                ),
                padding: const EdgeInsets.all(3),
                child: event != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.time, style: TextStyle(fontSize: 5, color: event.color, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(event.title, style: TextStyle(fontSize: 6, color: event.color), maxLines: 3, overflow: TextOverflow.ellipsis),
                        ],
                      )
                    : Center(child: Text('NA', style: TextStyle(fontSize: 7, color: AppColors.textGrey.withValues(alpha: 0.4)))),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDayView() {
    final date = '15th March 2025, Monday';
    final events = [
      _SlotEvent('Morning', '09:00AM - 11:00AM', 'Meeting: Curriculum Review Discussion', AppColors.primaryBlue),
      _SlotEvent('Morning', '11:30AM - 01:00PM', 'Session: Advanced JavaScript', AppColors.orange),
      _SlotEvent('Afternoon', '02:00PM - 03:30PM', 'Session: Database Management & SQL Optimization', AppColors.green),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6)),
          child: Text(date, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
        ),
        const SizedBox(height: 12),
        const Text('Morning Slot (9:00AM - 1:00PM)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
        const SizedBox(height: 6),
        ...events.where((e) => e.slot == 'Morning').map((e) => _buildDayEventCard(e)),
        const SizedBox(height: 12),
        const Text('Afternoon Slot (1:00PM - 4:00PM)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textGrey)),
        const SizedBox(height: 6),
        ...events.where((e) => e.slot == 'Afternoon').map((e) => _buildDayEventCard(e)),
      ],
    );
  }

  Widget _buildDayEventCard(_SlotEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: event.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: event.color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.time, style: TextStyle(fontSize: 9, color: event.color, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(event.title, style: TextStyle(fontSize: 11, color: event.color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _CalEvent {
  final String label;
  final Color color;
  const _CalEvent(this.label, this.color);
}

class _WeekDay {
  final String name, date;
  final List<_SlotEvent> events;
  const _WeekDay(this.name, this.date, this.events);
}

class _SlotEvent {
  final String slot, time, title;
  final Color color;
  const _SlotEvent(this.slot, this.time, this.title, this.color);
}
