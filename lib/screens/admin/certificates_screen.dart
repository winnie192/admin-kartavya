import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  int selectedTab = 0; // 0 = Certificates, 1 = Certificate Designs

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabs(),
          const SizedBox(height: 12),
          _buildSearchBar(),
          const SizedBox(height: 12),
          if (selectedTab == 0) _buildCertificateList() else _buildDesignsList(),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTab('Certificates', 0),
        const SizedBox(width: 6),
        _buildTab('Certificate Designs', 1),
        const Spacer(),
        if (selectedTab == 0)
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Create Certificate', style: TextStyle(fontSize: 14)),
                  content: const Text('Certificate creation form coming soon.', style: TextStyle(fontSize: 12)),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                ),
              );
            },
            icon: const Icon(Icons.add, size: 12),
            label: const Text('Create Certificate', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 0,
            ),
          ),
      ],
    );
  }

  Widget _buildTab(String label, int index) {
    final isActive = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.borderGrey),
        ),
        child: Text(label, style: TextStyle(fontSize: 10, color: isActive ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        SizedBox(
          width: 200, height: 30,
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, size: 14),
              prefixIconConstraints: const BoxConstraints(minWidth: 30),
              hintText: 'Search ...',
              hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0), child: const Text('Search', style: TextStyle(fontSize: 10))),
      ],
    );
  }

  Widget _buildCertificateList() {
    final certs = [
      ['Aspirant', '12 April 2025', AppColors.red],
      ['Performer', '12 December 2025', AppColors.orange],
      ['Front Runner', '22 July 2023', AppColors.primaryBlue],
      ['Achiever', '09 September 2023', AppColors.green],
      ['Participate', '02 January 2024', AppColors.grey],
      ['Achiever', '09 September 2023', AppColors.green],
      ['Aspirant', '12 April 2025', AppColors.red],
      ['Performer', '12 December 2025', AppColors.orange],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.4,
      ),
      itemCount: certs.length,
      itemBuilder: (_, i) {
        final cert = certs[i];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderGrey),
            boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 2)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Certificate preview placeholder
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: (cert[2] as Color).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: (cert[2] as Color).withValues(alpha: 0.2)),
                  ),
                  child: Center(
                    child: Icon(Icons.card_membership, color: cert[2] as Color, size: 24),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(color: (cert[2] as Color).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)),
                    child: Text(cert[0] as String, style: TextStyle(fontSize: 8, color: cert[2] as Color, fontWeight: FontWeight.w500)),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz, size: 14, color: AppColors.textGrey),
                ],
              ),
              const SizedBox(height: 2),
              Text(cert[1] as String, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesignsList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.4,
      ),
      itemCount: 6,
      itemBuilder: (_, i) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderGrey),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue.withValues(alpha: 0.3),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: const Center(child: Icon(Icons.design_services, color: AppColors.primaryBlue, size: 24)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    Text('Design ${i + 1}', style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                    const Spacer(),
                    const Text('Access', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
