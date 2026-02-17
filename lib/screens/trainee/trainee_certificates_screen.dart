import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'trainee_certificate_preview_screen.dart';

class TraineeCertificatesScreen extends StatelessWidget {
  const TraineeCertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Certificates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: _certificates
                .map((c) => _CertificateCard(cert: c))
                .toList(),
          ),
          const SizedBox(height: 16),
          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('1-5  of  5',
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderGrey),
                    ),
                    child: const Icon(Icons.chevron_left,
                        size: 16, color: AppColors.textGrey),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('1/1',
                        style:
                            TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderGrey),
                    ),
                    child: const Icon(Icons.chevron_right,
                        size: 16, color: AppColors.textGrey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CertData {
  final String outcome;
  final String date;
  final Color color;

  const _CertData(
      {required this.outcome, required this.date, required this.color});
}

const _certificates = [
  _CertData(outcome: 'Aspirant', date: '12 April 2025', color: AppColors.primaryBlue),
  _CertData(outcome: 'Performer', date: '12 December 2025', color: AppColors.orange),
  _CertData(outcome: 'Front Runner', date: '22 July 2023', color: Color(0xFF9C27B0)),
  _CertData(outcome: 'Participate', date: '02 January 2024', color: AppColors.grey),
  _CertData(outcome: 'Achiever', date: '09 September 2023', color: AppColors.green),
  _CertData(outcome: 'Performer', date: '12 December 2025', color: AppColors.orange),
  _CertData(outcome: 'Achiever', date: '09 September 2023', color: AppColors.green),
];

class _CertificateCard extends StatelessWidget {
  final _CertData cert;

  const _CertificateCard({required this.cert});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => const TraineeCertificatePreviewScreen(),
        ));
      },
      child: Container(
      width: 220,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A237E),
            const Color(0xFF0D47A1),
            cert.color.withValues(alpha: 0.3),
          ],
        ),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 6)
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.workspace_premium,
                        color: Colors.amber, size: 20),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: cert.color.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(cert.outcome,
                          style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const Spacer(),
                const Text('CERTIFICATE',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 8,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                const Text('of Achievement',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(cert.date,
                    style: const TextStyle(
                        color: Colors.white60, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
