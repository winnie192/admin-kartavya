import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

/// Accept Request dialog
void showPmAcceptDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: AppColors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_outline, color: AppColors.green, size: 28),
            ),
            const SizedBox(height: 12),
            const Text('Accept Request', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 8),
            const Text(
              'You are on the way to accept the request. Are you sure you want to accept it?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: AppColors.textGrey),
            ),
            const SizedBox(height: 6),
            const Text('Yes accept request...', style: TextStyle(fontSize: 10, color: AppColors.green, fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), elevation: 0),
                  child: const Text('Yes', style: TextStyle(fontSize: 10)),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.borderGrey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                  child: const Text('No', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/// Reject Request dialog
void showPmRejectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(color: AppColors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.close, color: AppColors.red, size: 18),
                ),
                const SizedBox(width: 8),
                const Text('Reject Request', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Please provide comments to help the manager understand the rejection.',
                style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
            const SizedBox(height: 10),
            const Text('Reason for rejection?', style: TextStyle(fontSize: 10, color: AppColors.textDark, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            TextField(
              maxLines: 4,
              style: const TextStyle(fontSize: 10),
              decoration: InputDecoration(
                hintText: 'Enter reason for rejection...',
                hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                  child: const Text('Send', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/// Discussion dialog (chat panel)
void showPmDiscussionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const SizedBox(width: 360, height: 440, child: _DiscussionChat()),
    ),
  );
}

class _DiscussionChat extends StatefulWidget {
  const _DiscussionChat();

  @override
  State<_DiscussionChat> createState() => _DiscussionChatState();
}

class _DiscussionChatState extends State<_DiscussionChat> {
  final _controller = TextEditingController();
  final _messages = <_ChatMsg>[
    _ChatMsg('Hi, I have a question about this request', false),
    _ChatMsg('Sure, what would you like to know?', true),
    _ChatMsg('Can we extend the deadline by one week?', false),
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
                const CircleAvatar(radius: 14, backgroundColor: Colors.white, child: Text('N', style: TextStyle(fontSize: 11, color: AppColors.primaryBlue, fontWeight: FontWeight.w600))),
                const SizedBox(width: 8),
                const Text('Niloy Deb', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                  child: const Text('Author', style: TextStyle(fontSize: 8, color: Colors.white)),
                ),
                const Spacer(),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: Colors.white)),
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
                  const Center(child: Text('Today', style: TextStyle(fontSize: 9, color: AppColors.textGrey))),
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
              children: ['Sounds good', 'Let me check', 'I\'ll get back to you']
                  .map((t) => ActionChip(
                        label: Text(t, style: const TextStyle(fontSize: 9)),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: AppColors.background,
                        onPressed: () => setState(() => _messages.add(_ChatMsg(t, true))),
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
                        hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.borderGrey)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      ),
                      onSubmitted: _send,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => _send(_controller.text),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 30, height: 30,
                    decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
                    child: const Icon(Icons.send, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _send(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMsg(text.trim(), true));
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
          color: isSent ? AppColors.primaryBlue : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text, style: TextStyle(fontSize: 10, color: isSent ? Colors.white : AppColors.textDark)),
      ),
    );
  }
}

class _ChatMsg {
  final String text;
  final bool isSent;
  _ChatMsg(this.text, this.isSent);
}
