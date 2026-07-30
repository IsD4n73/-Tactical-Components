import 'package:flutter_test/flutter_test.dart';
import 'package:tactical_components_example/demo_screen.dart';

void main() {
  testWidgets('TacticalDemoApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TacticalDemoApp());
    expect(find.byType(TacticalDemoApp), findsOneWidget);
  });
}
