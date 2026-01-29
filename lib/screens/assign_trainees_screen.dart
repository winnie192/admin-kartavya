import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class AssignTraineesScreen extends StatefulWidget {
  const AssignTraineesScreen({super.key});

  @override
  State<AssignTraineesScreen> createState() => _AssignTraineesScreenState();
}

class _AssignTraineesScreenState extends State<AssignTraineesScreen> {
  final searchController = TextEditingController();
  final Set<int> selectedTrainees = {};

  final trainees = [
    _Trainee('Vimla Doliya', 'Software Engineering'),
    _Trainee('Ankit Pandey', 'Digital Marketing'),
    _Trainee('Divya Balakrishna Shetty', 'Project Manager'),
    _Trainee('Rachana Singh', 'Corporate Trainer'),
    _Trainee('Shital Patil', 'Product Head'),
    _Trainee('Om PadalKar', 'Data Analyst'),
    _Trainee('Shrey Saraki', 'Associate Analyst'),
    _Trainee('Priti Shinde', 'MCA Graduate'),
    _Trainee('Shweta Balotiya', 'Operations'),
    _Trainee('Anshuman Shah', 'Trainee'),
    _Trainee('Siddhi Auti', 'Trainee'),
    _Trainee('Rahul Genoliya', 'Electrical Engineer'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Assign Trainees',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          // Search bar & actions
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: isMobile ? double.infinity : 200,
                height: 34,
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(fontSize: 11),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, size: 16),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 32, minHeight: 0),
                    hintText: 'Search for trainees',
                    hintStyle:
                        const TextStyle(fontSize: 11, color: AppColors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < trainees.length; i++) {
                      selectedTrainees.add(i);
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: const Text('Enroll All',
                    style: TextStyle(
                        color: AppColors.primaryBlue, fontSize: 11)),
              ),
              Text(
                'Total Trainees: 120',
                style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
              ),
              Text(
                'Assigned Trainees: ${selectedTrainees.length}',
                style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  elevation: 0,
                ),
                child: const Text('Assign', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTraineeGrid(context),
        ],
      ),
    );
  }

  Widget _buildTraineeGrid(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossCount = isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 8,
        childAspectRatio: 3.8,
      ),
      itemCount: trainees.length,
      itemBuilder: (_, i) => _buildTraineeCard(i),
    );
  }

  Widget _buildTraineeCard(int index) {
    final trainee = trainees[index];
    final isSelected = selectedTrainees.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedTrainees.remove(index);
          } else {
            selectedTrainees.add(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.borderGrey,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? AppColors.primaryBlue.withValues(alpha: 0.05)
              : Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: isSelected,
                onChanged: (v) {
                  setState(() {
                    if (v!) {
                      selectedTrainees.add(index);
                    } else {
                      selectedTrainees.remove(index);
                    }
                  });
                },
                activeColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.lightGrey,
              child: Text(
                trainee.name[0],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    trainee.name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    trainee.role,
                    style: const TextStyle(
                      fontSize: 9,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Trainee {
  final String name;
  final String role;
  _Trainee(this.name, this.role);
}
