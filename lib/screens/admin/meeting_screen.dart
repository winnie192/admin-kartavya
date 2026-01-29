import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widgets/admin_sidebar.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const Drawer(child: AdminSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.darkSidebar,
              foregroundColor: Colors.white,
              title: const Text('Meeting', style: TextStyle(fontSize: 16)),
              leading: IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => Navigator.pop(context)),
            )
          : null,
      body: Row(
        children: [
          if (!isMobile) const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                if (!isMobile)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.borderGrey)),
                            child: const Icon(Icons.arrow_back, size: 14, color: AppColors.textDark),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Product design weekly meeting', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      ],
                    ),
                  ),
                Expanded(
                  child: Row(
                    children: [
                      // Video grid
                      Expanded(flex: 3, child: _buildVideoGrid()),
                      // Participants sidebar
                      if (!isMobile)
                        SizedBox(width: 250, child: _buildParticipantsList()),
                    ],
                  ),
                ),
                // Bottom controls
                _buildControls(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoGrid() {
    final participants = [
      _Participant('John', Colors.blue),
      _Participant('You', AppColors.primaryBlue),
      _Participant('Jeong', Colors.teal),
      _Participant('Sara', Colors.purple),
      _Participant('Rachana Singh', AppColors.amber),
    ];

    return Container(
      color: const Color(0xFF1A1A2E),
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.5,
        ),
        itemCount: participants.length,
        itemBuilder: (context, i) {
          final p = participants[i];
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: p.color,
                  child: Text(p.name[0], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 6),
                Text(p.name, style: const TextStyle(color: Colors.white70, fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildParticipantsList() {
    final names = [
      'Rohit Verma', 'Muskan Shinde', 'Vimla Doliya', 'Shweta Balotiya',
      'Clement Pinto', 'Yashoda Anchan', 'Divya Shetty', 'Rahul Roy',
      'Ankit Pandey',
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: AppColors.borderGrey)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderGrey))),
            child: Row(
              children: [
                const Text('Participate', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Text('107', style: TextStyle(fontSize: 9, color: AppColors.primaryBlue, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          // Recording info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                const Text('30 May 2022', style: TextStyle(fontSize: 9, color: AppColors.textGrey)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.fiber_manual_record, size: 8, color: AppColors.red),
                      SizedBox(width: 4),
                      Text('Recording 26:32', style: TextStyle(fontSize: 8, color: AppColors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Participant list
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: [AppColors.primaryBlue, AppColors.green, AppColors.amber, AppColors.orange][i % 4],
                        child: Text(names[i][0], style: const TextStyle(color: Colors.white, fontSize: 9)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(names[i], style: const TextStyle(fontSize: 10, color: AppColors.textDark))),
                      const Icon(Icons.mic, size: 14, color: AppColors.textGrey),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFF1A1A2E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _controlBtn(Icons.mic, Colors.white24),
          const SizedBox(width: 10),
          _controlBtn(Icons.videocam, Colors.white24),
          const SizedBox(width: 10),
          _controlBtn(Icons.screen_share, Colors.white24),
          const SizedBox(width: 10),
          _controlBtn(Icons.chat, Colors.white24),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.call_end, size: 16),
            label: const Text('Leave Meeting', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 0,
            ),
          ),
          const SizedBox(width: 20),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.link, size: 14, color: Colors.white70),
            label: const Text('Share meeting link', style: TextStyle(fontSize: 9, color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Widget _controlBtn(IconData icon, Color bg) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

class _Participant {
  final String name;
  final Color color;
  _Participant(this.name, this.color);
}
