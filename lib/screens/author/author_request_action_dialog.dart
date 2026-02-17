import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AuthorRequestActionDialog {
  /// Accept Request dialog
  static Future<void> showAccept(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Accept Request',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.green)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to accept this request?',
              style: TextStyle(fontSize: 11, color: AppColors.textDark),
            ),
            SizedBox(height: 8),
            Text(
              'Do you want to be redirected to the course to submit course first?',
              style: TextStyle(fontSize: 10, color: AppColors.textGrey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: const Text('No', style: TextStyle(fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: const Text('Yes', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  /// Reject Request dialog
  static Future<void> showReject(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Reject Request',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.red)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Reason for rejection?',
                style: TextStyle(
                    fontSize: 11, color: AppColors.textDark)),
            const SizedBox(height: 8),
            TextField(
              maxLines: 3,
              style: const TextStyle(fontSize: 11),
              decoration: InputDecoration(
                hintText: 'Enter reason for rejection...',
                hintStyle:
                    const TextStyle(fontSize: 10, color: AppColors.grey),
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: AppColors.borderGrey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: AppColors.borderGrey)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: const Text('Save', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  /// Discussion dialog — opens chat panel
  static Future<void> showDiscussion(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => const _DiscussionDialogContent(),
    );
  }
}

class _DiscussionDialogContent extends StatelessWidget {
  const _DiscussionDialogContent();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 340,
        height: 400,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(12)),
              ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Trainee',
                        style:
                            TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close,
                        size: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Messages
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  const Center(
                    child: Text('Today',
                        style: TextStyle(
                            fontSize: 9, color: AppColors.textGrey)),
                  ),
                  const SizedBox(height: 8),
                  _chatBubble('omg, this is amazing', false),
                  _chatBubble('perfect', false),
                  _chatBubble("I'll be there in 2 mins", true),
                  _chatBubble('Wow, this is really epic', false),
                  _chatBubble('just ideas for next time', true),
                ],
              ),
            ),
            // Quick replies
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 6,
                children: [
                  'Awesome',
                  'really all good',
                  'Good that\'s working',
                ]
                    .map((t) => Chip(
                          label:
                              Text(t, style: const TextStyle(fontSize: 9)),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: AppColors.background,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 6),
            // Input
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: TextField(
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
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send,
                        size: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _chatBubble(String text, bool isSent) {
    return Align(
      alignment:
          isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 220),
        decoration: BoxDecoration(
          color: isSent
              ? AppColors.primaryBlue
              : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 10,
                color:
                    isSent ? Colors.white : AppColors.textDark)),
      ),
    );
  }
}
