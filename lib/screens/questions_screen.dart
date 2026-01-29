import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  bool isGenerateMode = false;
  String selectedQuestionType = 'Single Choice';
  final promptController = TextEditingController();
  List<_Question> questions = [];

  final questionTypes = [
    'Single Choice',
    'Multiple Choice',
    'True or False',
    'Fill in the blank',
    'Short Answer',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create Questions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildModeTab('Generate Questions', true),
              const SizedBox(width: 8),
              _buildModeTab('Create Questions', false),
            ],
          ),
          const SizedBox(height: 16),
          if (isGenerateMode) _buildGenerateMode() else _buildCreateMode(),
        ],
      ),
    );
  }

  Widget _buildModeTab(String label, bool isGenerate) {
    final isActive = isGenerateMode == isGenerate;
    return GestureDetector(
      onTap: () => setState(() => isGenerateMode = isGenerate),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AppColors.primaryBlue : AppColors.borderGrey,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? Colors.white : AppColors.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildGenerateMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSubTab('Question Type'),
            const SizedBox(width: 8),
            _buildSubTab('Pre-define Prompt'),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              TextField(
                controller: promptController,
                maxLines: 4,
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  hintText:
                      'Type your prompt here or describe what kind of questions you want to generate...',
                  hintStyle: TextStyle(color: AppColors.grey, fontSize: 11),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send, color: AppColors.primaryBlue, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubTab(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, color: AppColors.textDark),
      ),
    );
  }

  Widget _buildCreateMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () => _addQuestion(),
          icon: const Icon(Icons.add, size: 14),
          label: const Text('Add Questions', style: TextStyle(fontSize: 11)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        const SizedBox(height: 14),
        if (questions.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Icon(Icons.quiz_outlined, size: 48, color: AppColors.lightGrey),
                  const SizedBox(height: 8),
                  const Text(
                    'No questions added yet',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 11),
                  ),
                ],
              ),
            ),
          )
        else
          ...questions.asMap().entries.map((entry) =>
              _buildQuestionCard(entry.key, entry.value)),
      ],
    );
  }

  Widget _buildQuestionCard(int index, _Question question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Question ${index + 1}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              const Text('Points : ',
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
              SizedBox(
                width: 30,
                child: TextField(
                  controller: TextEditingController(text: '2'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Question type dropdown
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderGrey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                isDense: true,
                value: question.type,
                items: questionTypes
                    .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t, style: const TextStyle(fontSize: 11))))
                    .toList(),
                onChanged: (v) => setState(() => question.type = v!),
                icon: const Icon(Icons.keyboard_arrow_down, size: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Question text
          SizedBox(
            height: 34,
            child: TextField(
              controller: TextEditingController(text: question.text),
              style: const TextStyle(fontSize: 11),
              decoration: InputDecoration(
                hintText: 'What is the capital of France?',
                hintStyle: const TextStyle(color: AppColors.grey, fontSize: 11),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: AppColors.borderGrey),
                ),
              ),
              onChanged: (v) => question.text = v,
            ),
          ),
          const SizedBox(height: 10),
          const Text('Answers',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          ...question.options.asMap().entries.map((opt) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Radio<int>(
                      value: opt.key,
                      groupValue: question.correctIndex,
                      onChanged: (v) =>
                          setState(() => question.correctIndex = v!),
                      activeColor: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: TextField(
                        controller: TextEditingController(text: opt.value),
                        style: const TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: AppColors.borderGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: AppColors.borderGrey),
                          ),
                        ),
                        onChanged: (v) => question.options[opt.key] = v,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        setState(() => question.options.removeAt(opt.key)),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close, size: 14, color: AppColors.red),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 6),
          OutlinedButton.icon(
            onPressed: () => setState(() => question.options.add('')),
            icon: const Icon(Icons.add, size: 12),
            label: const Text('Add Answers', style: TextStyle(fontSize: 11)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: const BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Solution (Optional)',
              style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(height: 6),
          TextField(
            maxLines: 2,
            style: const TextStyle(fontSize: 11),
            decoration: InputDecoration(
              hintText: 'Type your Suggestion here.',
              hintStyle: const TextStyle(color: AppColors.grey, fontSize: 11),
              contentPadding: const EdgeInsets.all(10),
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
        ],
      ),
    );
  }

  void _addQuestion() {
    setState(() {
      questions.add(_Question(
        type: 'Single Choice',
        text: '',
        options: ['Madrid', 'Berlin', 'Paris', 'Rome'],
        correctIndex: 2,
      ));
    });
  }
}

class _Question {
  String type;
  String text;
  List<String> options;
  int correctIndex;

  _Question({
    required this.type,
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}
