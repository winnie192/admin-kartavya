import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/upload_dialog.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  int selectedTab = 0;

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
            onPressed: () => _showCreateCertificateDialog(),
            icon: const Icon(Icons.add, size: 12),
            label: const Text('Create Certificate', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
          ),
        if (selectedTab == 1)
          ElevatedButton.icon(
            onPressed: () => showUploadDialog(context, title: 'Upload Certificate Design', supportedFormats: 'PNG, JPG, PDF, AI, PSD'),
            icon: const Icon(Icons.upload, size: 12),
            label: const Text('Upload Design', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), elevation: 0),
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
      ['KHPL Stamp', '12 April 2025', AppColors.primaryBlue],
      ['Director Sign', '08 March 2025', AppColors.green],
      ['Aspirant', '12 April 2025', AppColors.red],
      ['Performer', '12 December 2025', AppColors.orange],
      ['Untitled', '15 June 2024', AppColors.grey],
      ['Program Manager Sign', '22 July 2023', AppColors.amber],
      ['Front Runner', '22 July 2023', AppColors.primaryBlue],
      ['Achiever', '09 September 2023', AppColors.green],
      ['Participate', '02 January 2024', AppColors.grey],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.4),
      itemCount: certs.length,
      itemBuilder: (_, i) {
        final cert = certs[i];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.borderGrey), boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 2)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: (cert[2] as Color).withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6), border: Border.all(color: (cert[2] as Color).withValues(alpha: 0.2))),
                  child: Center(child: Icon(Icons.card_membership, color: cert[2] as Color, size: 24)),
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
                  PopupMenuButton<String>(
                    iconSize: 14,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.more_horiz, size: 14, color: AppColors.textGrey),
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit', style: TextStyle(fontSize: 10))),
                      const PopupMenuItem(value: 'download', child: Text('Download', style: TextStyle(fontSize: 10))),
                      const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(fontSize: 10))),
                    ],
                  ),
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
    final designs = [
      ['KHPL Stamp', AppColors.primaryBlue],
      ['Director Sign', AppColors.green],
      ['Program Manager Sign', AppColors.amber],
      ['Aspirant Template', AppColors.red],
      ['Performer Template', AppColors.orange],
      ['Front Runner Template', AppColors.primaryBlue],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.4),
          itemCount: designs.length,
          itemBuilder: (_, i) {
            return Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.borderGrey)),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: (designs[i][1] as Color).withValues(alpha: 0.08),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      ),
                      child: Center(child: Icon(Icons.design_services, color: designs[i][1] as Color, size: 24)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Text(designs[i][0] as String, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: const Text('Access', style: TextStyle(fontSize: 8, color: AppColors.primaryBlue)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _showCreateCertificateDialog() {
    showDialog(
      context: context,
      builder: (_) => const _CreateCertificateDialog(),
    );
  }
}

class _CreateCertificateDialog extends StatelessWidget {
  const _CreateCertificateDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Create Certificate', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  const Spacer(),
                  InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 16, color: AppColors.textGrey)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _field('Trainer Name')),
                  const SizedBox(width: 10),
                  Expanded(child: _field('Course Name')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _field('Date (dd/mm/yyyy)')),
                  const SizedBox(width: 10),
                  Expanded(child: _dropdownField('Assessment Matrix', ['Aspirant', 'Performer', 'Front Runner', 'Achiever'])),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _dropdownField('Program Manager Sign', ['Select'])),
                  const SizedBox(width: 10),
                  Expanded(child: _dropdownField('Director Sign', ['Select'])),
                ],
              ),
              const SizedBox(height: 10),
              _dropdownField('KHPL Stamp', ['Select']),
              const SizedBox(height: 12),
              // Upload area
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload_outlined, size: 20, color: AppColors.primaryBlue),
                    const SizedBox(height: 4),
                    const Text('Drag & Drop or Browse', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontSize: 10, color: AppColors.textGrey))),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), elevation: 0),
                    child: const Text('Download', style: TextStyle(fontSize: 10)),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), elevation: 0),
                    child: const Text('Upload', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _field(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 3),
        SizedBox(
          height: 30,
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.borderGrey)),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _dropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey)),
        const SizedBox(height: 3),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(border: Border.all(color: AppColors.borderGrey), borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              Expanded(child: Text(items.first, style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
              const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textGrey),
            ],
          ),
        ),
      ],
    );
  }
}
