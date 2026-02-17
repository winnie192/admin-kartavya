import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class DiscussionWidget extends StatefulWidget {
  final String requestTitle;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const DiscussionWidget({
    super.key,
    this.requestTitle = 'Request Discussion',
    this.onAccept,
    this.onReject,
  });

  @override
  State<DiscussionWidget> createState() => _DiscussionWidgetState();
}

class _DiscussionWidgetState extends State<DiscussionWidget> {
  final _replyController = TextEditingController();
  final List<_ChatMessage> _messages = [
    _ChatMessage('Niloy Deb', 'I have submitted the course deletion request for MIT Introduction to CS. Please review.', '10:30 AM', false),
    _ChatMessage('Ankit Pandey', 'Can you provide the reason for deletion? There are active learners enrolled.', '10:45 AM', true),
    _ChatMessage('Niloy Deb', 'The course content is outdated and needs to be replaced with an updated version.', '11:02 AM', false),
    _ChatMessage('Ankit Pandey', 'Understood. I will review the request and get back to you.', '11:15 AM', true),
  ];

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_replyController.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage('You', _replyController.text.trim(), 'Just now', true));
      _replyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.primaryBlue),
                const SizedBox(width: 6),
                Text(widget.requestTitle, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                _actionButton('Accept', AppColors.green, Icons.check, () => _showAcceptDialog(context)),
                const SizedBox(width: 6),
                _actionButton('Reject', AppColors.red, Icons.close, () => _showRejectDialog(context)),
                const SizedBox(width: 6),
                _actionButton('Discussion', AppColors.primaryBlue, Icons.chat, null),
              ],
            ),
          ),
          // Messages
          Container(
            height: 280,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, i) => _buildMessageBubble(_messages[i]),
            ),
          ),
          // Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.borderGrey))),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 32,
                    child: TextField(
                      controller: _replyController,
                      style: const TextStyle(fontSize: 10),
                      decoration: InputDecoration(
                        hintText: 'Write me a reply...',
                        hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.borderGrey)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.borderGrey)),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: _sendMessage,
                  child: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(16)),
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

  Widget _buildMessageBubble(_ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: msg.isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!msg.isSelf) ...[
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.amber,
              child: Text(msg.sender[0], style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: msg.isSelf ? AppColors.primaryBlue.withValues(alpha: 0.08) : AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: msg.isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(msg.sender, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      const SizedBox(width: 6),
                      Text(msg.time, style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(msg.text, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                ],
              ),
            ),
          ),
          if (msg.isSelf) ...[
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.primaryBlue,
              child: Text(msg.sender[0], style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _actionButton(String label, Color color, IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 10, color: Colors.white),
          const SizedBox(width: 3),
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }

  void _showAcceptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline, size: 32, color: AppColors.green),
              const SizedBox(height: 10),
              const Text('Accept Request', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 6),
              const Text('Are you sure you want to accept this request?', style: TextStyle(fontSize: 10, color: AppColors.textGrey), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), elevation: 0),
                    child: const Text('No', style: TextStyle(fontSize: 10)),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onAccept?.call();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), elevation: 0),
                    child: const Text('Yes', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    final reasonController = TextEditingController();
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
              const Text('Reject Request', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 10),
              const Text('Reason', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
              const SizedBox(height: 4),
              TextField(
                controller: reasonController,
                maxLines: 4,
                style: const TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  hintText: 'Enter reason for rejection...',
                  hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onReject?.call();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), elevation: 0),
                    child: const Text('Submit', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String sender, text, time;
  final bool isSelf;
  _ChatMessage(this.sender, this.text, this.time, this.isSelf);
}
