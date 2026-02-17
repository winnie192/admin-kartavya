import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthorDiscussionChat extends StatefulWidget {
  const AuthorDiscussionChat({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const SizedBox(
          width: 360,
          height: 440,
          child: AuthorDiscussionChat(),
        ),
      ),
    );
  }

  @override
  State<AuthorDiscussionChat> createState() => _AuthorDiscussionChatState();
}

class _AuthorDiscussionChatState extends State<AuthorDiscussionChat> {
  final _controller = TextEditingController();

  final _messages = <_ChatMessage>[
    _ChatMessage('omg, this is amazing', false),
    _ChatMessage('perfect', false),
    _ChatMessage("I'll be there in 2 mins", true),
    _ChatMessage('Wow, this is really epic', false),
    _ChatMessage('just ideas for next time', true),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Text('R',
                      style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 8),
                const Text('Rahul Sharma',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('Trainee',
                      style: TextStyle(fontSize: 8, color: Colors.white)),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert,
                      size: 16, color: Colors.white),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                        value: 'clear',
                        child:
                            Text('Clear chat', style: TextStyle(fontSize: 11))),
                    const PopupMenuItem(
                        value: 'close',
                        child: Text('Close', style: TextStyle(fontSize: 11))),
                  ],
                  onSelected: (v) {
                    if (v == 'close') Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          // Messages
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  const Center(
                    child: Text('Today',
                        style:
                            TextStyle(fontSize: 9, color: AppColors.textGrey)),
                  ),
                  const SizedBox(height: 8),
                  ..._messages.map((m) => _buildBubble(m.text, m.isSent)),
                ],
              ),
            ),
          ),
          // Quick replies
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 6,
              children: ['Awesome', 'really all good', 'Good that\'s working']
                  .map((t) => ActionChip(
                        label: Text(t, style: const TextStyle(fontSize: 9)),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: AppColors.background,
                        onPressed: () {
                          setState(() {
                            _messages.add(_ChatMessage(t, true));
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 4),
          // Input
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 11),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: const TextStyle(
                            fontSize: 10, color: AppColors.grey),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: AppColors.borderGrey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: AppColors.borderGrey)),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => _sendMessage(_controller.text),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send,
                        size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text.trim(), true));
      _controller.clear();
    });
  }

  Widget _buildBubble(String text, bool isSent) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 240),
        decoration: BoxDecoration(
          color:
              isSent ? AppColors.primaryBlue : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 10,
                color: isSent ? Colors.white : AppColors.textDark)),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isSent;
  _ChatMessage(this.text, this.isSent);
}
