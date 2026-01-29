import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class StepperHeader extends StatelessWidget {
  final int currentStep; // 0-3
  final ValueChanged<int>? onStepTap;

  const StepperHeader({
    super.key,
    required this.currentStep,
    this.onStepTap,
  });

  static const _labels = ['Basic Info', 'Questions', 'Assign Trainees', 'Publish'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final isCompleted = index < currentStep;
          final isActive = index == currentStep;
          return Expanded(
            child: GestureDetector(
              onTap: onStepTap != null ? () => onStepTap!(index) : null,
              child: Row(
                children: [
                  if (index > 0)
                    Expanded(
                      child: Container(
                        height: 1,
                        color: isCompleted || isActive
                            ? AppColors.primaryBlue
                            : AppColors.lightGrey,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive || isCompleted
                          ? AppColors.primaryBlue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isActive || isCompleted
                            ? AppColors.primaryBlue
                            : AppColors.lightGrey,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive || isCompleted
                                ? Colors.white
                                : AppColors.lightGrey,
                          ),
                          child: Center(
                            child: isCompleted
                                ? Icon(Icons.check,
                                    size: 10, color: AppColors.primaryBlue)
                                : Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: isActive
                                          ? AppColors.primaryBlue
                                          : AppColors.textGrey,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _labels[index],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: isActive || isCompleted
                                ? Colors.white
                                : AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index < 3)
                    Expanded(
                      child: Container(
                        height: 1,
                        color: isCompleted
                            ? AppColors.primaryBlue
                            : AppColors.lightGrey,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
