import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TraineeCertificatePreviewScreen extends StatelessWidget {
  const TraineeCertificatePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title: const Text('Certificate', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Certificate card
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 12)],
                ),
                child: Stack(
                  children: [
                    // Blue decorative border
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF1A237E), width: 3),
                        ),
                      ),
                    ),
                    // Inner decorative border
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF1A237E).withValues(alpha: 0.3), width: 1),
                        ),
                      ),
                    ),
                    // Certificate content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                      child: Column(
                        children: [
                          // Top decorative elements
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 2,
                                color: const Color(0xFF1A237E),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.workspace_premium,
                                  size: 28, color: Color(0xFF1A237E)),
                              const SizedBox(width: 12),
                              Container(
                                width: 40,
                                height: 2,
                                color: const Color(0xFF1A237E),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'CERTIFICATE',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A237E),
                              letterSpacing: 6,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'OF PARTICIPATION',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A237E),
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'This certificate is awarded to',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Name
                          const Text(
                            'Daniel Gallego',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF1A237E),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 200,
                            height: 1,
                            color: const Color(0xFF1A237E).withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 24),
                          // Award ribbon icon
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.military_tech,
                                  size: 64, color: const Color(0xFF1A237E).withValues(alpha: 0.8)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Signature area
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text('Signature',
                                      style: TextStyle(fontSize: 10, color: AppColors.textGrey, fontStyle: FontStyle.italic)),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 120,
                                    height: 1,
                                    color: AppColors.borderGrey,
                                  ),
                                  const SizedBox(height: 4),
                                  const Text('LUIS MARTINEZ',
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.print, size: 16),
                    label: const Text('Print', style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Download', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: const Text('Back', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
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
