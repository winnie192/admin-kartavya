import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TrainerTraineeProgressScreen extends StatefulWidget {
  final void Function(String name) onTraineeDetail;

  const TrainerTraineeProgressScreen({super.key, required this.onTraineeDetail});

  @override
  State<TrainerTraineeProgressScreen> createState() => _TrainerTraineeProgressScreenState();
}

class _TrainerTraineeProgressScreenState extends State<TrainerTraineeProgressScreen> {
  final _trainees = const [
    _TraineeRow('Om', 'Padalkar', 100, 180, 109),
    _TraineeRow('Ankit', 'Pandey', 12, 150, 47),
    _TraineeRow('Siddhi', 'Auti', 24, 180, 38),
    _TraineeRow('Reetu', 'Kudia', 34, 180, 90),
    _TraineeRow('Rahul', 'Verma', 78, 150, 89),
    _TraineeRow('Anjali', 'Padalkar', 39, 180, 69),
    _TraineeRow('Anshuman', 'Sharma', 57, 180, 92),
    _TraineeRow('Sameer', 'Khan', 89, 150, 95),
    _TraineeRow('Kavita', 'Bhati', 25, 180, 107),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Search + filters
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    filled: true, fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.borderGrey)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.borderGrey)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Search', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildFilterChip('Business Segment'),
              const SizedBox(width: 8),
              _buildFilterChip('Department'),
              const SizedBox(width: 8),
              _buildFilterChip('Client'),
              const SizedBox(width: 8),
              _buildFilterChip('Program'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Open Training', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
                  child: Row(
                    children: [
                      _hCell('Select', flex: 1),
                      _hCell('Expand', flex: 1),
                      _hCell('First Name', flex: 2, hasFilter: true),
                      _hCell('Last Name', flex: 2, hasFilter: true),
                      _hCell('Courses Assign', flex: 2),
                      _hCell('Hours Assign', flex: 2),
                      _hCell('Hours Completed', flex: 2),
                      _hCell('Profile', flex: 1),
                    ],
                  ),
                ),
                // Rows
                ..._trainees.map((t) => _buildRow(t)),
                // Pagination
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Text('1-${_trainees.length} of 1',
                          style: const TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
                      const Spacer(),
                      _pageBtn(Icons.chevron_left),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
                        child: const Text('1/1', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      const SizedBox(width: 4),
                      _pageBtn(Icons.chevron_right),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _hCell(String label, {int flex = 1, bool hasFilter = false}) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.orange)),
          if (hasFilter) ...[
            const SizedBox(width: 4),
            Icon(Icons.filter_list, size: 12, color: AppColors.orange),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(_TraineeRow trainee) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey, width: 0.5))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Checkbox(value: false, onChanged: (_) {}, visualDensity: VisualDensity.compact),
          ),
          Expanded(
            flex: 1,
            child: Icon(Icons.open_in_full, size: 16, color: AppColors.textGrey),
          ),
          Expanded(flex: 2, child: Text(trainee.firstName, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
          Expanded(flex: 2, child: Text(trainee.lastName, style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
          Expanded(flex: 2, child: Text('${trainee.coursesAssign}', style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
          Expanded(flex: 2, child: Text('${trainee.hoursAssign}', style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
          Expanded(flex: 2, child: Text('${trainee.hoursCompleted}', style: const TextStyle(fontSize: 11, color: AppColors.textDark))),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => widget.onTraineeDetail(trainee.firstName),
              child: const Icon(Icons.person_outline, size: 18, color: AppColors.primaryBlue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageBtn(IconData icon) {
    return Container(
      width: 28, height: 28,
      decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(4)),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

class _TraineeRow {
  final String firstName, lastName;
  final int coursesAssign, hoursAssign, hoursCompleted;
  const _TraineeRow(this.firstName, this.lastName, this.coursesAssign, this.hoursAssign, this.hoursCompleted);
}
