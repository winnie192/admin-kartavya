import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class UploadDialog extends StatelessWidget {
  final String title;
  final String? supportedFormats;
  final VoidCallback? onUpload;

  const UploadDialog({
    super.key,
    this.title = 'Upload Document',
    this.supportedFormats,
    this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 16, color: AppColors.textGrey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryBlue, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.lightBlue.withValues(alpha: 0.3),
              ),
              child: CustomPaint(
                painter: _DashedBorderPainter(color: AppColors.primaryBlue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 28, color: AppColors.primaryBlue),
                    const SizedBox(height: 6),
                    const Text(
                      'Drag & Drop your files here',
                      style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 4),
                    const Text('or', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        elevation: 0,
                        minimumSize: Size.zero,
                      ),
                      child: const Text('Browse', style: TextStyle(fontSize: 9)),
                    ),
                  ],
                ),
              ),
            ),
            if (supportedFormats != null) ...[
              const SizedBox(height: 8),
              Text(
                'Supported formats: $supportedFormats',
                style: const TextStyle(fontSize: 8, color: AppColors.textGrey),
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
                  onPressed: () {
                    onUpload?.call();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 0,
                  ),
                  child: const Text('Upload', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(8),
    );
    final path = Path()..addRRect(rect);
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void showUploadDialog(BuildContext context, {
  String title = 'Upload Document',
  String? supportedFormats,
  VoidCallback? onUpload,
}) {
  showDialog(
    context: context,
    builder: (_) => UploadDialog(
      title: title,
      supportedFormats: supportedFormats,
      onUpload: onUpload,
    ),
  );
}
