import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TraineeTakeTestScreen extends StatefulWidget {
  const TraineeTakeTestScreen({super.key});

  @override
  State<TraineeTakeTestScreen> createState() => _TraineeTakeTestScreenState();
}

class _TraineeTakeTestScreenState extends State<TraineeTakeTestScreen> {
  bool _started = false;
  int _currentQuestion = 0;
  int? _selectedOption;
  final Set<int> _selectedCheckboxes = {};
  final _textAnswer = TextEditingController();
  final _blankAnswers = [TextEditingController(), TextEditingController(), TextEditingController()];

  @override
  void dispose() {
    _textAnswer.dispose();
    for (final c in _blankAnswers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_started) return _buildPreScreen();
    return _buildTestScreen();
  }

  // Exam pre-screen with parameters and instructions
  Widget _buildPreScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title: const Text('Exam', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(28),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 8)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: AppColors.orange),
                  const SizedBox(width: 6),
                  const Text('06 Dec 2023 - 12 Dec 2023',
                      style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Ongoing',
                        style: TextStyle(fontSize: 10, color: AppColors.orange, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.timer_outlined, size: 14, color: AppColors.textGrey),
                  const SizedBox(width: 4),
                  const Text('Duration - 45 min',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Assess your skills in writing complex SQL queries, joins, and stored procedures.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4),
              ),
              const SizedBox(height: 20),
              const Text('Exam Parameter',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
              const SizedBox(height: 10),
              _paramRow('Total Questions', '15'),
              _paramRow('Total Time', '45 min'),
              _paramRow('Total Marks', '100'),
              const SizedBox(height: 12),
              const Text('Passing %',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              _passingRow('Aspirant', '0-49', AppColors.primaryBlue),
              _passingRow('Performer', '50-64', AppColors.orange),
              _passingRow('Front Runner', '65-99', const Color(0xFF9C27B0)),
              _passingRow('Achiever', '100', AppColors.green),
              const SizedBox(height: 20),
              const Text('Instruction',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
              const SizedBox(height: 8),
              ..._instructions.map((i) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 12)),
                        Expanded(child: Text(i, style: const TextStyle(fontSize: 11, height: 1.4))),
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () => setState(() => _started = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text('Take Test', style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paramRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label - ', style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _passingRow(String label, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('$label : $range', style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }

  // Active test screen
  Widget _buildTestScreen() {
    final q = _questions[_currentQuestion];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Top bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            color: AppColors.topNavBg,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Text('Question ${_currentQuestion + 1}/${_questions.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.red.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text('Time left : 29 min 30 sec',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Question content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 6)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_currentQuestion + 1}/${_questions.length}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (_currentQuestion + 1) / _questions.length,
                        minHeight: 4,
                        backgroundColor: AppColors.borderGrey,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      q.question,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    if (q.type == 'mcq') _buildMCQ(q),
                    if (q.type == 'truefalse') _buildTrueFalse(q),
                    if (q.type == 'written') _buildWritten(),
                    if (q.type == 'fillblank') _buildFillBlank(),
                    if (q.type == 'multiple_selection') _buildMultipleSelection(q),
                  ],
                ),
              ),
            ),
          ),
          // Bottom navigation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            color: Colors.white,
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: _currentQuestion > 0
                      ? () => setState(() {
                            _currentQuestion--;
                            _selectedOption = null;
                            _selectedCheckboxes.clear();
                          })
                      : null,
                  child: const Text('Previous', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _currentQuestion < _questions.length - 1
                      ? () => setState(() {
                            _currentQuestion++;
                            _selectedOption = null;
                            _selectedCheckboxes.clear();
                          })
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 12)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _showSubmitDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit Test', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMCQ(_QuestionData q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose answer',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
        const SizedBox(height: 10),
        for (int i = 0; i < q.options.length; i++)
          RadioListTile<int>(
            value: i,
            groupValue: _selectedOption,
            onChanged: (v) => setState(() => _selectedOption = v),
            title: Text(q.options[i], style: const TextStyle(fontSize: 12)),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }

  Widget _buildTrueFalse(_QuestionData q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose answer',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
        const SizedBox(height: 10),
        RadioListTile<int>(
          value: 0,
          groupValue: _selectedOption,
          onChanged: (v) => setState(() => _selectedOption = v),
          title: const Text('True', style: TextStyle(fontSize: 12)),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: _selectedOption,
          onChanged: (v) => setState(() => _selectedOption = v),
          title: const Text('False', style: TextStyle(fontSize: 12)),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildWritten() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Write answer',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
        const SizedBox(height: 10),
        TextField(
          controller: _textAnswer,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: 'Write your answer here',
            hintStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderGrey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFillBlank() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Add answer',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
        const SizedBox(height: 10),
        for (int i = 0; i < 3; i++) ...[
          Text('Blank ${i + 1}.',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          TextField(
            controller: _blankAnswers[i],
            decoration: InputDecoration(
              hintText: 'Write your answer here',
              hintStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderGrey),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _buildMultipleSelection(_QuestionData q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose answer',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
        const SizedBox(height: 10),
        for (int i = 0; i < q.options.length; i++)
          CheckboxListTile(
            value: _selectedCheckboxes.contains(i),
            onChanged: (v) => setState(() {
              if (v == true) {
                _selectedCheckboxes.add(i);
              } else {
                _selectedCheckboxes.remove(i);
              }
            }),
            title: Text(q.options[i], style: const TextStyle(fontSize: 12)),
            dense: true,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
          ),
      ],
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.help_outline, size: 40, color: AppColors.orange),
            const SizedBox(height: 12),
            const Text('Questions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text('20', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Attempt', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text('18', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            const Text(
              'Some questions are still unanswered.\nAre you sure you want to submit your exam now?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textGrey, height: 1.4),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pushReplacementNamed(context, '/trainee/exam-result');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text('Submit Test', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionData {
  final String question;
  final String type;
  final List<String> options;

  const _QuestionData({required this.question, required this.type, this.options = const []});
}

const _questions = [
  _QuestionData(
    question:
        'Guy Bailey, Roy Hackett and Paul Stephenson made history in 1963, as part of a protest against a bus company that refused to employ black and Asian drivers in which UK city?',
    type: 'mcq',
    options: ['London', 'Liverpool', 'Edinburgh', 'Canary Wharf'],
  ),
  _QuestionData(
    question:
        'In User-Centered Design (UCD), the needs, wants, and limitations of end users are considered at every stage of the design process to create a user-friendly product.',
    type: 'truefalse',
  ),
  _QuestionData(
    question: 'Explain the importance of user personas in the UX design process.',
    type: 'written',
  ),
  _QuestionData(
    question:
        'Which of the following best describes the purpose of wireframes in the UI/UX process?',
    type: 'multiple_selection',
    options: [
      'To test final colors and typography',
      'To explore multiple branding options',
      'To create a basic visual structure for a webpage or app before final design',
      'To develop backend logic and server connections',
    ],
  ),
  _QuestionData(
    question:
        'In the design thinking process, the stages typically include ______, ______, and ______, which help teams understand users, explore solutions, and implement the best outcomes.',
    type: 'fillblank',
  ),
];

const _instructions = [
  'All questions are mandatory.',
  'Each question carries equal marks.',
  'You cannot go back once the question is answered (if navigation is disabled).',
  'Do not close or refresh the browser during the exam.',
  'The timer will begin once you click Start Exam.',
  'Submit your exam before the timer ends. Unsubmitted answers will not be saved.',
];
