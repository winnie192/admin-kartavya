import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'trainee_certificate_preview_screen.dart';

class TraineeExamResultScreen extends StatefulWidget {
  const TraineeExamResultScreen({super.key});

  @override
  State<TraineeExamResultScreen> createState() =>
      _TraineeExamResultScreenState();
}

class _TraineeExamResultScreenState extends State<TraineeExamResultScreen> {
  bool _showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title:
            const Text('Exam Result', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _showAnswers ? _buildAnswersView() : _buildResultView(),
      ),
    );
  }

  Widget _buildResultView() {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.cardShadow, blurRadius: 8)
          ],
        ),
        child: Column(
          children: [
            const Icon(Icons.emoji_events,
                size: 60, color: AppColors.amber),
            const SizedBox(height: 16),
            // Exam Summary
            const Text('Exam Summary',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue)),
            const SizedBox(height: 16),
            _summaryRow('Exam Name',
                'Assess your skills in writing complex SQL queries, joins, and stored procedures.'),
            _summaryRow('Duration', '45 Mins'),
            _summaryRow('Attempt Date', '12 July 2025'),
            _summaryRow('Exam Dates', '01 June 2025  -  19 July 2025'),
            _summaryRow('Total Questions', '100'),
            _summaryRow('Attempted Questions', '18'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 160,
                  child: Text('Unattempted Questions',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textGrey)),
                ),
                Text('02',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red)),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            // Performance Summary
            const Text('Performance Summary',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue)),
            const SizedBox(height: 20),
            const Text('78/100',
                style: TextStyle(
                    fontSize: 36, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('Front Runner',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9C27B0),
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 16),
            const Text('🎉 Congratulations !!! 🎉',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const Text('🏆 Achievement Unlocked !!!',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.amber)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () =>
                      setState(() => _showAnswers = true),
                  child: const Text('View Answers',
                      style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const TraineeCertificatePreviewScreen(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('View Certificate',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textGrey)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswersView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () =>
                  setState(() => _showAnswers = false),
              icon: const Icon(Icons.arrow_back, size: 20),
            ),
            const Text('Answer Review',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 16),
        // Question 1 - Correct
        _answerCard(
          number: 1,
          isCorrect: true,
          question:
              'Which of the following are programming languages?',
          options: ['Python', 'HTML', 'CSS', 'JAVA'],
          selectedIndices: [0, 3],
          correctIndices: [0, 3],
        ),
        const SizedBox(height: 16),
        // Question 2 - Correct (written)
        _writtenAnswerCard(
          number: 2,
          isCorrect: true,
          question: 'What does the acronym "HTTP" stand for?',
          answer: 'HTTP stand for hyper text markup language.',
        ),
        const SizedBox(height: 16),
        // Question 3 - Incorrect
        _answerCard(
          number: 3,
          isCorrect: false,
          question:
              'In the context of project management, which of the following best describes the primary purpose of a Gantt chart?',
          options: [
            'It is used to allocate financial resources across departments in an organization.',
            'It helps in tracking team attendance and individual performance metrics.',
            'It visually represents a project schedule, showing tasks, durations, and dependencies over time.',
            'It is a tool used to manage customer feedback and support tickets.',
          ],
          selectedIndices: [0],
          correctIndices: [2],
        ),
      ],
    );
  }

  Widget _answerCard({
    required int number,
    required bool isCorrect,
    required String question,
    required List<String> options,
    required List<int> selectedIndices,
    required List<int> correctIndices,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Question $number',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (isCorrect ? AppColors.green : AppColors.red)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isCorrect ? 'Correct' : 'Incorrect',
                  style: TextStyle(
                    fontSize: 10,
                    color: isCorrect ? AppColors.green : AppColors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(question,
              style: const TextStyle(fontSize: 12, height: 1.4)),
          const SizedBox(height: 12),
          for (int i = 0; i < options.length; i++)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: correctIndices.contains(i)
                    ? AppColors.green.withValues(alpha: 0.08)
                    : (selectedIndices.contains(i) && !correctIndices.contains(i))
                        ? AppColors.red.withValues(alpha: 0.08)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: correctIndices.contains(i)
                      ? AppColors.green.withValues(alpha: 0.3)
                      : (selectedIndices.contains(i) && !correctIndices.contains(i))
                          ? AppColors.red.withValues(alpha: 0.3)
                          : AppColors.borderGrey,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    correctIndices.contains(i)
                        ? Icons.check_circle
                        : (selectedIndices.contains(i)
                            ? Icons.cancel
                            : Icons.radio_button_unchecked),
                    size: 16,
                    color: correctIndices.contains(i)
                        ? AppColors.green
                        : (selectedIndices.contains(i)
                            ? AppColors.red
                            : AppColors.borderGrey),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(options[i],
                        style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _writtenAnswerCard({
    required int number,
    required bool isCorrect,
    required String question,
    required String answer,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Question $number',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Correct',
                    style: TextStyle(
                        fontSize: 10,
                        color: AppColors.green,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(question,
              style: const TextStyle(fontSize: 12, height: 1.4)),
          const SizedBox(height: 8),
          const Text('Answer',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey)),
          const SizedBox(height: 4),
          Text(answer, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
