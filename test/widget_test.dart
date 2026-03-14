import 'package:flutter_test/flutter_test.dart';
import 'package:insta_zrex/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const InstaApp());
    expect(find.byType(InstaApp), findsOneWidget);
  });
}
