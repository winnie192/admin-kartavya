import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TraineeSessionDetailScreen extends StatelessWidget {
  final String type; // 'Session' or 'Meeting'
  const TraineeSessionDetailScreen({super.key, this.type = 'Session'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.topNavBg,
        foregroundColor: Colors.white,
        title: Text('${type == 'Meeting' ? 'Meeting' : 'Session'} Details',
            style: const TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 8)],
            ),
            child: type == 'Meeting' ? _buildMeetingDetails() : _buildSessionDetails(),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and status
        Row(
          children: [
            const Text('Session Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Complete',
                  style: TextStyle(fontSize: 10, color: AppColors.green, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Date & Time
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'Date & Time : 11:00AM - 12:00 PM | 12 Sep 2023 - 14 Jun 2024',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),
        // Course Name
        const Text('Course Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        const Text(
          'Add a Quiz for Students of JCO - JVY on the subject Fundamentals of Programming',
          style: TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        const SizedBox(height: 20),
        // Days and Slots
        const Text('Days and Slots', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        _buildSlotsTable(),
        const SizedBox(height: 20),
        // Attachment
        const Text('Attachment', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _attachChip('C++ with OOPS Notes.pdf'),
            _attachChip('C++ with OOPS Notes.pdf'),
            _attachChip('C++ with OOPS Notes.pdf'),
          ],
        ),
        const SizedBox(height: 20),
        // Text
        const Text('Text', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const Text(
          'Lorem ipsum dolor sit amet consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu.',
          style: TextStyle(fontSize: 11, color: AppColors.textGrey, height: 1.5),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('View Course', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildMeetingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and status
        Row(
          children: [
            const Text('Meeting Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Upcoming',
                  style: TextStyle(fontSize: 10, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Date & Time
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'Date & Time : 11:00AM - 12:00 PM | 12 Sep 2023 - 14 Jun 2024',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),
        // Meeting Agenda
        const Text('Meeting Agenda', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        const Text(
          'Add a Quiz for Students of JCO - A/V on the subject Fundamentals of Programming',
          style: TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        const SizedBox(height: 20),
        // Attachment
        const Text('Attachment', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _attachChip('C++ with OOPS Notes.pdf'),
            _attachChip('C++ with OOPS Notes.pdf'),
            _attachChip('C++ with OOPS Notes.pdf'),
          ],
        ),
        const SizedBox(height: 20),
        // Text
        const Text('Text', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const Text(
          'Lorem ipsum dolor sit amet consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus.',
          style: TextStyle(fontSize: 11, color: AppColors.textGrey, height: 1.5),
        ),
        const SizedBox(height: 20),
        // Course Name
        const Text('Course Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        const Text(
          'Add a Quiz for Students of JCO - A/V on the subject Fundamentals of Programming',
          style: TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        const SizedBox(height: 20),
        // Participant Name
        const Text('Participate Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final name in [
              'Divya Liberty', 'Barsena Singh', 'Phil Okrais', 'Om Padolay', 'Amit Pandey',
              'Preeth Moibahar', 'Satish Avit', 'Shreya Panday', 'Komal Navel', 'Khan Cis',
              'Vaistal Redi', 'Shweta Bodiviya', 'Vinita Bodaye', 'Karan Singh', 'Arjun Joshi',
              'Shyam Frohan', 'Sujit Rec',
            ])
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(name, style: const TextStyle(fontSize: 10)),
              ),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('View Meeting', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildSlotsTable() {
    final days = [
      {'day': 'Monday', 'slots': [
        {'shift': 'Morning', 'time': '09:00AM - 10:00AM'},
        {'shift': 'Afternoon', 'time': '11:00AM - 2:00PM'},
        {'shift': '', 'time': '11:00AM - 12:00PM'},
      ]},
      {'day': 'Monday', 'slots': [
        {'shift': 'Evening', 'time': '04:00AM - 5:30PM'},
      ]},
      {'day': 'Tuesday', 'slots': [
        {'shift': 'Morning', 'time': '09:00AM - 11:00AM'},
      ]},
      {'day': 'Wednesday', 'slots': [
        {'shift': 'Afternoon', 'time': '01:00PM - 3:00PM'},
        {'shift': '', 'time': '11:00AM - 12:00PM'},
        {'shift': '', 'time': '11:00AM - 12:00PM'},
      ]},
      {'day': 'Saturday', 'slots': [
        {'shift': 'Morning', 'time': '09:00AM - 10:00AM'},
        {'shift': '', 'time': '11:00AM - 12:00PM'},
      ]},
    ];

    return Table(
      border: TableBorder.all(color: AppColors.borderGrey, width: 0.5),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1.5),
      },
      children: [
        for (final d in days)
          for (int i = 0; i < (d['slots'] as List).length; i++)
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(i == 0 ? d['day'] as String : '',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(((d['slots'] as List)[i] as Map)['shift'] as String,
                      style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(((d['slots'] as List)[i] as Map)['time'] as String,
                      style: const TextStyle(fontSize: 11)),
                ),
              ],
            ),
      ],
    );
  }

  Widget _attachChip(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(name, style: const TextStyle(fontSize: 10)),
    );
  }
}
