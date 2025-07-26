import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('App loads and builds MyPortfolioApp', (WidgetTester tester) async {
    await tester.pumpWidget(const MyPortfolioApp());
    expect(find.text('My Portfolio'), findsOneWidget);
  });
}
