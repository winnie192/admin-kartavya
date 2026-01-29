import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/admin_sidebar.dart';

class TakeTestScreen extends StatefulWidget {
  const TakeTestScreen({super.key});

  @override
  State<TakeTestScreen> createState() => _TakeTestScreenState();
}

class _TakeTestScreenState extends State<TakeTestScreen> {
  int _currentQuestion = 0;
  final Map<int, dynamic> _answers = {};

  final _questions = [
    _Question(
      'Which of the following are programming languages?',
      'Multiple Choice',
      ['Python', 'HTML', 'CSS', 'JAVA'],
    ),
    _Question(
      'What does the acronym "HTTP" stand for?',
      'Short Answer',
      [],
    ),
    _Question(
      'In the context of project management, which of the following best describes the primary purpose of a Gantt chart?',
      'Single Choice',
      [
        'It is used to allocate financial resources across departments in an organization.',
        'It helps in tracking team attendance and individual performance metrics.',
        'It visually represents a project schedule, showing tasks, durations, and dependencies over time.',
        'It is a tool used to manage customer feedback and support tickets.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const Drawer(child: AdminSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Take Test', style: TextStyle(fontSize: 16)),
              leading: IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => Navigator.pop(context)),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                if (!isMobile)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.borderGrey)),
                            child: const Icon(Icons.arrow_back, size: 14, color: AppColors.textDark),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Exam Preview', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                        const Spacer(),
                        // Timer
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            children: const [
                              Icon(Icons.timer, size: 14, color: AppColors.red),
                              SizedBox(width: 4),
                              Text('44:32', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Questions
                      Expanded(
                        flex: 3,
                        child: _buildQuestionArea(),
                      ),
                      // Question nav sidebar
                      if (!isMobile)
                        SizedBox(
                          width: 200,
                          child: _buildQuestionNav(),
                        ),
                    ],
                  ),
                ),
                // Bottom actions
                _buildBottomBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionArea() {
    final q = _questions[_currentQuestion];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentQuestion + 1}',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 8),
            Text(q.text, style: const TextStyle(fontSize: 12, color: AppColors.textDark, fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            if (q.type == 'Short Answer')
              TextField(
                maxLines: 3,
                style: const TextStyle(fontSize: 11),
                decoration: InputDecoration(
                  hintText: 'Enter your answer here',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                ),
              )
            else
              ...q.options.asMap().entries.map((e) {
                final isSelected = q.type == 'Multiple Choice'
                    ? (_answers[_currentQuestion] as List<int>?)?.contains(e.key) ?? false
                    : _answers[_currentQuestion] == e.key;
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (q.type == 'Multiple Choice') {
                        final list = (_answers[_currentQuestion] as List<int>?) ?? [];
                        if (list.contains(e.key)) {
                          list.remove(e.key);
                        } else {
                          list.add(e.key);
                        }
                        _answers[_currentQuestion] = list;
                      } else {
                        _answers[_currentQuestion] = e.key;
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.borderGrey),
                      color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.05) : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: q.type == 'Multiple Choice' ? BoxShape.rectangle : BoxShape.circle,
                            borderRadius: q.type == 'Multiple Choice' ? BorderRadius.circular(3) : null,
                            border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.grey, width: 1.5),
                            color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                          ),
                          child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(e.value, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: AppColors.borderGrey)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Questions', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_questions.length, (i) {
              final isCurrent = i == _currentQuestion;
              final isAnswered = _answers.containsKey(i);
              return GestureDetector(
                onTap: () => setState(() => _currentQuestion = i),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent
                        ? AppColors.primaryBlue
                        : isAnswered
                            ? AppColors.green
                            : Colors.white,
                    border: Border.all(
                      color: isCurrent ? AppColors.primaryBlue : isAnswered ? AppColors.green : AppColors.borderGrey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Q.${i + 1}',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: isCurrent || isAnswered ? Colors.white : AppColors.textDark,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          // Legend
          _legend(AppColors.green, 'Answered'),
          _legend(AppColors.primaryBlue, 'Current'),
          _legend(AppColors.borderGrey, 'Unanswered'),
        ],
      ),
    );
  }

  Widget _legend(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.borderGrey))),
      child: Row(
        children: [
          if (_currentQuestion > 0)
            OutlinedButton(
              onPressed: () => setState(() => _currentQuestion--),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textDark,
                side: const BorderSide(color: AppColors.borderGrey),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
              child: const Text('Previous', style: TextStyle(fontSize: 10)),
            ),
          const Spacer(),
          if (_currentQuestion < _questions.length - 1)
            ElevatedButton(
              onPressed: () => setState(() => _currentQuestion++),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                elevation: 0,
              ),
              child: const Text('Next', style: TextStyle(fontSize: 10)),
            )
          else
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                elevation: 0,
              ),
              child: const Text('Submit', style: TextStyle(fontSize: 10)),
            ),
        ],
      ),
    );
  }
}

class _Question {
  final String text, type;
  final List<String> options;
  _Question(this.text, this.type, this.options);
}
