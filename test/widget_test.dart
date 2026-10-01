import 'package:flutter_test/flutter_test.dart';
import 'package:student_digital_id/main.dart';

void main() {
  testWidgets('Dashboard loads', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentIdApp());
    expect(find.text('Campus Dashboard'), findsOneWidget);
  });
}
