import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/stepper_header.dart';
import '../widgets/bottom_actions.dart';
import 'basic_info_screen.dart';
import 'questions_screen.dart';
import 'assign_trainees_screen.dart';
import 'publish_screen.dart';

class CreateExamFlow extends StatefulWidget {
  const CreateExamFlow({super.key});

  @override
  State<CreateExamFlow> createState() => _CreateExamFlowState();
}

class _CreateExamFlowState extends State<CreateExamFlow> {
  int currentStep = 0;

  final screens = const [
    BasicInfoScreen(),
    QuestionsScreen(),
    AssignTraineesScreen(),
    PublishScreen(),
  ];

  void _next() {
    if (currentStep < 3) {
      setState(() => currentStep++);
    }
  }

  void _onStepTap(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isLastStep = currentStep == 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const Drawer(child: AdminSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Create Exam', style: TextStyle(fontSize: 16)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const AdminSidebar(),
          Expanded(
            child: Padding(
              padding: isMobile
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: isMobile
                      ? BorderRadius.zero
                      : BorderRadius.circular(16),
                  boxShadow: isMobile
                      ? []
                      : [
                          BoxShadow(
                            color: AppColors.cardShadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Column(
                  children: [
                    // Back button row (desktop)
                    if (!isMobile)
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.borderGrey),
                              ),
                              child: const Icon(Icons.arrow_back,
                                  size: 14, color: AppColors.textDark),
                            ),
                          ),
                        ),
                      ),
                    // Stepper
                    StepperHeader(
                      currentStep: currentStep,
                      onStepTap: _onStepTap,
                    ),
                    const Divider(height: 1, color: AppColors.borderGrey),
                    // Content
                    Expanded(child: screens[currentStep]),
                    // Bottom actions
                    BottomActions(
                      onCancel: () => Navigator.pop(context),
                      onSaveDraft: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved as draft')),
                        );
                      },
                      onNext: isLastStep
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Exam Published!'),
                                  content: const Text(
                                      'Your exam has been published successfully.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : _next,
                      nextLabel: isLastStep ? 'Publish' : 'Next',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
