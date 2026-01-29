import 'package:flutter_test/flutter_test.dart';
import 'package:exam_management/main.dart';

void main() {
  testWidgets('App loads dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const ExamManagementApp());
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
