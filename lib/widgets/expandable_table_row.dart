import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ExpandableTableRow extends StatefulWidget {
  final Widget header;
  final Widget expandedContent;
  final Color? expandedBackground;

  const ExpandableTableRow({
    super.key,
    required this.header,
    required this.expandedContent,
    this.expandedBackground,
  });

  @override
  State<ExpandableTableRow> createState() => _ExpandableTableRowState();
}

class _ExpandableTableRowState extends State<ExpandableTableRow>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _controller;
  late final Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggle,
          child: Container(
            decoration: BoxDecoration(
              color: _expanded
                  ? AppColors.lightBlue.withValues(alpha: 0.3)
                  : Colors.white,
              border: const Border(
                bottom: BorderSide(color: AppColors.borderGrey, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(child: widget.header),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: _heightFactor.value,
                child: child,
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.expandedBackground ??
                  AppColors.lightBlue.withValues(alpha: 0.15),
              border: const Border(
                bottom: BorderSide(color: AppColors.borderGrey, width: 0.5),
              ),
            ),
            child: widget.expandedContent,
          ),
        ),
      ],
    );
  }
}
