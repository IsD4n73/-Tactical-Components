import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tactical_components/tactical_components.dart';

void main() {
  Widget buildSmallScreenApp(Widget child, {double width = 320, double height = 568}) {
    return MaterialApp(
      theme: TacticalTheme.dark,
      home: MediaQuery(
        data: MediaQueryData(size: Size(width, height)),
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: width,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('TacticalFilledButton renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      TacticalFilledButton(
        label: 'VERY LONG BUTTON LABEL THAT SHOULD NOT OVERFLOW THE SCREEN',
        onPressed: () {},
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalColorSwatchPicker renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      TacticalColorSwatchPicker(
        selectedColor: TacticalColors.yellow,
        onChanged: (_) {},
        colors: const [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
          Colors.orange,
          Colors.purple,
          Colors.cyan,
          Colors.pink,
        ],
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalSegmentedControl renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      TacticalSegmentedControl(
        options: const ['Option 1', 'Option 2', 'Option 3 Long', 'Option 4 Extra Long'],
        selectedIndex: 0,
        onChanged: (_) {},
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalToolbarSelectGroup renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      TacticalToolbarSelectGroup(
        items: [
          TacticalToolbarSelect(label: 'Long Toolbar Selection 1', options: const ['A', 'B']),
          TacticalToolbarSelect(label: 'Long Toolbar Selection 2', options: const ['C', 'D']),
          TacticalToolbarSelect(label: 'Long Toolbar Selection 3', options: const ['E', 'F']),
        ],
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalStateToggle renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      TacticalStateToggle(
        label: 'COMPLEX HIGH SECURITY MEASUREMENT MODE',
        value: true,
        onChanged: (_) {},
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalCounterHeader renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      const TacticalCounterHeader(
        title: 'EXTREMELY LONG SYSTEM OBJECTIVES COUNTER TITLE FOR NARROW SCREEN',
        count: 42,
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalDetailRow renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      const TacticalDetailRow(
        label: 'Very Long System Detail Label Name',
        value: 'Very Long System Detail Value Response Data',
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalKpiCard renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      const TacticalKpiCard(
        title: 'HIGH PRECISION FREQUENCY MEASUREMENT',
        value: '99999.99',
        unit: 'MEGAHERTZ PER SEC',
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalLocationChip renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      TacticalLocationChip(
        label: 'Extremely Long Tactical Location Access Terminal Door #999',
        showTrailingIcon: true,
        onTap: () {},
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalBadgeGroup renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      const TacticalBadgeGroup(
        badges: [
          TacticalStatusBadge('STATUS OK', variant: TacticalBadgeVariant.success),
          TacticalStatusBadge('CRITICAL WARNING', variant: TacticalBadgeVariant.danger),
          TacticalStatusBadge('SYSTEM ONLINE', variant: TacticalBadgeVariant.info),
          TacticalStatusBadge('VERSION 2.4.1', variant: TacticalBadgeVariant.neutral),
        ],
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalProgressBar renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      const TacticalProgressBar(
        label: 'EXTREMELY DETAILED SYSTEM TELEMETRY DUMP PROGRESS',
        value: 0.75,
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalExpandableSection renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      const TacticalExpandableSection(
        title: 'LONG EXPANDABLE SECTION TITLE FOR SMALL MOBILE DEVICES',
        child: Text('Section content'),
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalStepTracker horizontal renders without overflow on small screen', (tester) async {
    await tester.pumpWidget(buildSmallScreenApp(
      const TacticalStepTracker(
        direction: Axis.horizontal,
        steps: [
          TacticalStep(title: 'Phase 1', isCompleted: true),
          TacticalStep(title: 'Phase 2', isActive: true),
          TacticalStep(title: 'Phase 3'),
          TacticalStep(title: 'Phase 4'),
          TacticalStep(title: 'Phase 5'),
        ],
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('TacticalDrawer caps width on small viewports', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: TacticalTheme.dark,
        home: MediaQuery(
          data: const MediaQueryData(size: Size(280, 600)),
          child: const Scaffold(
            drawer: TacticalDrawer(
              title: 'SYSTEM MENU',
              width: 300,
              items: [
                TacticalMenuItem(label: 'Item 1', icon: Icons.map),
              ],
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
