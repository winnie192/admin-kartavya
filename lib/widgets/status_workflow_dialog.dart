import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

enum WorkflowAction { approve, reject, rework, publish, activate, inactivate, delete }

class StatusWorkflowDialog extends StatefulWidget {
  final WorkflowAction action;
  final String title;
  final String? subtitle;
  final bool showDatePicker;
  final bool showComment;
  final bool showProgressBar;
  final VoidCallback? onConfirm;

  const StatusWorkflowDialog({
    super.key,
    required this.action,
    required this.title,
    this.subtitle,
    this.showDatePicker = false,
    this.showComment = true,
    this.showProgressBar = false,
    this.onConfirm,
  });

  @override
  State<StatusWorkflowDialog> createState() => _StatusWorkflowDialogState();
}

class _StatusWorkflowDialogState extends State<StatusWorkflowDialog> {
  bool _loading = false;
  bool _success = false;
  final _commentController = TextEditingController();

  Color get _actionColor {
    switch (widget.action) {
      case WorkflowAction.approve:
        return AppColors.green;
      case WorkflowAction.reject:
        return AppColors.red;
      case WorkflowAction.rework:
        return AppColors.amber;
      case WorkflowAction.publish:
        return AppColors.primaryBlue;
      case WorkflowAction.activate:
        return AppColors.green;
      case WorkflowAction.inactivate:
        return AppColors.orange;
      case WorkflowAction.delete:
        return AppColors.red;
    }
  }

  String get _successMessage {
    switch (widget.action) {
      case WorkflowAction.approve:
        return 'Approved Successfully';
      case WorkflowAction.reject:
        return 'Rejected Successfully';
      case WorkflowAction.rework:
        return 'Sent for Rework Successfully';
      case WorkflowAction.publish:
        return 'Published Successfully';
      case WorkflowAction.activate:
        return 'Activated Successfully';
      case WorkflowAction.inactivate:
        return 'Inactivated Successfully';
      case WorkflowAction.delete:
        return 'Deleted Successfully';
    }
  }

  void _submit() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _loading = false;
          _success = true;
        });
        widget.onConfirm?.call();
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 380,
        padding: const EdgeInsets.all(20),
        child: _success ? _buildSuccess() : _loading ? _buildLoading() : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _getActionIcon(),
          color: _actionColor,
          size: 32,
        ),
        const SizedBox(height: 10),
        Text(
          widget.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
          textAlign: TextAlign.center,
        ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(widget.subtitle!, style: const TextStyle(fontSize: 10, color: AppColors.textGrey), textAlign: TextAlign.center),
        ],
        if (widget.showComment) ...[
          const SizedBox(height: 14),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Comment / Reason', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _commentController,
            maxLines: 3,
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: 'Enter reason...',
              hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              contentPadding: const EdgeInsets.all(8),
            ),
          ),
        ],
        if (widget.showDatePicker) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _dateField('Start Date')),
              const SizedBox(width: 8),
              Expanded(child: _dateField('End Date')),
            ],
          ),
        ],
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey)),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _actionColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 0,
              ),
              child: Text('Confirm', style: const TextStyle(fontSize: 10)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showProgressBar) ...[
          Text(widget.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textDark)),
          const SizedBox(height: 16),
          LinearProgressIndicator(color: _actionColor, backgroundColor: _actionColor.withValues(alpha: 0.15)),
        ] else ...[
          SizedBox(
            width: 32, height: 32,
            child: CircularProgressIndicator(strokeWidth: 2, color: _actionColor),
          ),
        ],
        const SizedBox(height: 12),
        Text(
          widget.showProgressBar ? 'Processing...' : widget.title,
          style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
        ),
      ],
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: _actionColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.thumb_up, color: _actionColor, size: 24),
        ),
        const SizedBox(height: 12),
        Text(
          _successMessage,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _actionColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: _actionColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            elevation: 0,
          ),
          child: const Text('OK', style: TextStyle(fontSize: 10)),
        ),
      ],
    );
  }

  Widget _dateField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 3),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              const Expanded(child: Text('dd/mm/yyyy', style: TextStyle(fontSize: 9, color: AppColors.grey))),
              const Icon(Icons.calendar_today, size: 12, color: AppColors.textGrey),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getActionIcon() {
    switch (widget.action) {
      case WorkflowAction.approve:
        return Icons.check_circle_outline;
      case WorkflowAction.reject:
        return Icons.cancel_outlined;
      case WorkflowAction.rework:
        return Icons.replay;
      case WorkflowAction.publish:
        return Icons.publish;
      case WorkflowAction.activate:
        return Icons.toggle_on_outlined;
      case WorkflowAction.inactivate:
        return Icons.toggle_off_outlined;
      case WorkflowAction.delete:
        return Icons.delete_outline;
    }
  }
}

void showWorkflowDialog(BuildContext context, {
  required WorkflowAction action,
  required String title,
  String? subtitle,
  bool showDatePicker = false,
  bool showComment = true,
  bool showProgressBar = false,
  VoidCallback? onConfirm,
}) {
  showDialog(
    context: context,
    builder: (_) => StatusWorkflowDialog(
      action: action,
      title: title,
      subtitle: subtitle,
      showDatePicker: showDatePicker,
      showComment: showComment,
      showProgressBar: showProgressBar,
      onConfirm: onConfirm,
    ),
  );
}
