import 'package:flutter/material.dart';
import 'theme.dart';
import 'tactical_widgets.dart';
import 'tactical_widgets_extended.dart';

/// ============================================================
/// DEMO SCREEN
/// Assembla tutti i componenti Tactical HUD in un'unica schermata
/// scrollabile, per verificarne rendering e coerenza visiva.
///
/// Per avviarla:
///   void main() => runApp(const TacticalDemoApp());
/// ============================================================

void main() => runApp(const TacticalDemoApp());

class TacticalDemoApp extends StatelessWidget {
  const TacticalDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tactical HUD — Demo',
      theme: TacticalTheme.dark,
      home: const TacticalDemoScreen(),
    );
  }
}

class TacticalDemoScreen extends StatefulWidget {
  const TacticalDemoScreen({super.key});

  @override
  State<TacticalDemoScreen> createState() => _TacticalDemoScreenState();
}

class _TacticalDemoScreenState extends State<TacticalDemoScreen> {
  // Stato dei toggle in stile "MEASURE [OFF]"
  bool _measure = false;
  bool _grid = true;
  bool _draw = true;

  // Stato segmented control "solid / Dashed"
  int _lineStyleIndex = 1;

  // Stato color swatch
  Color _selectedColor = TacticalColors.swatchPalette[1];

  // Stato dropdown versione mappa
  String _mapVersion = 'v0.4';

  final _filterController = TextEditingController();

  int _customNavIndex = 2;

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TacticalText('TACTICAL MAP ///'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TacticalSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- TOGGLE BAR ----------------
              const TacticalSectionHeader('Toggle Bar'),
              const SizedBox(height: TacticalSpacing.sm),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: TacticalColors.outline),
                    bottom: BorderSide(color: TacticalColors.outline),
                  ),
                ),
                child: Row(
                  children: [
                    TacticalStateToggle(
                      label: 'Measure',
                      value: _measure,
                      onChanged: (v) => setState(() => _measure = v),
                    ),
                    TacticalStateToggle(
                      label: 'Grid',
                      value: _grid,
                      onChanged: (v) => setState(() => _grid = v),
                    ),
                    TacticalStateToggle(
                      label: 'Draw',
                      value: _draw,
                      onChanged: (v) => setState(() => _draw = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- DROPDOWN ----------------
              const TacticalSectionHeader('Dropdown Field'),
              const SizedBox(height: TacticalSpacing.sm),
              TacticalDropdownField<String>(
                selected: _mapVersion,
                onChanged: (v) => setState(() => _mapVersion = v),
                options: const [
                  TacticalDropdownOption(value: 'v0.1', label: 'Sector 0.1'),
                  TacticalDropdownOption(value: 'v0.1b', label: 'Sector 0.1b'),
                  TacticalDropdownOption(value: 'v0.2', label: 'Sector 0.2'),
                  TacticalDropdownOption(value: 'v0.3', label: 'Sector 0.3'),
                  TacticalDropdownOption(
                    value: 'v0.4',
                    label: 'Sector 0.4',
                    indicatorColor: TacticalColors.green,
                  ),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- SEGMENTED CONTROL + SWATCH ----------------
              const TacticalSectionHeader('Draw Toolbar'),
              const SizedBox(height: TacticalSpacing.sm),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: TacticalSpacing.md,
                runSpacing: TacticalSpacing.sm,
                children: [
                  TacticalSegmentedControl(
                    options: const ['solid', 'Dashed'],
                    selectedIndex: _lineStyleIndex,
                    onChanged: (i) => setState(() => _lineStyleIndex = i),
                  ),
                  TacticalColorSwatchPicker(
                    selectedColor: _selectedColor,
                    onChanged: (c) => setState(() => _selectedColor = c),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Undo'),
                  ),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- ACTION BUTTONS + CLOSE ----------------
              const TacticalSectionHeader('Action Buttons'),
              const SizedBox(height: TacticalSpacing.sm),
              Row(
                children: [
                  TacticalFilledButton(label: 'Back', onPressed: () {}),
                  const SizedBox(width: TacticalSpacing.sm),
                  TacticalFilledButton(
                    label: 'Key',
                    backgroundColor: TacticalFilledButton.neutralBackground,
                    onPressed: () {},
                  ),
                  const Spacer(),
                  TacticalCloseButton(onPressed: () {}),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- DESCRIPTION ----------------
              const TacticalSectionHeader('Description'),
              const SizedBox(height: TacticalSpacing.sm),
              const Text('Access key for Sector Alpha Command Office.'),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- TASK REQUIREMENT ----------------
              const TacticalSectionHeader(
                'Task Requirement',
                variant: TacticalHeaderVariant.warning,
              ),
              const SizedBox(height: TacticalSpacing.sm),
              Wrap(
                children: [
                  const Text('Required for the '),
                  TacticalInlineLink('Primary Recon', onTap: () {}),
                  const Text(' task(s).'),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- LOCKED OBJECT ----------------
              const TacticalSectionHeader('Locked Object'),
              const SizedBox(height: TacticalSpacing.sm),
              TacticalLocationChip(label: 'Alpha Door #02', onTap: () {}),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- STATIC SPAWN LOCATIONS ----------------
              const TacticalSectionHeader(
                'Static Spawn Locations',
                variant: TacticalHeaderVariant.success,
              ),
              const SizedBox(height: TacticalSpacing.sm),
              Wrap(
                children: [
                  const Text('To achieve the desired result, all '),
                  const TacticalInlineLink(
                    'static spawns',
                    variant: TacticalLinkVariant.glossaryTerm,
                  ),
                  const Text(' should be checked during '),
                  const TacticalInlineLink(
                    'one visit',
                    variant: TacticalLinkVariant.glossaryTerm,
                  ),
                  const Text('.'),
                ],
              ),
              const SizedBox(height: TacticalSpacing.sm),
              TacticalLocationChipGrid(
                chips: [
                  TacticalLocationChip(
                    label: 'Spawn #1',
                    showTrailingIcon: true,
                    onTap: () {},
                  ),
                  TacticalLocationChip(
                    label: 'Spawn #2',
                    showTrailingIcon: true,
                    onTap: () {},
                  ),
                  TacticalLocationChip(
                    label: 'Spawn #3',
                    showTrailingIcon: true,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalNoteRow(
                text: 'Appears only while the task is active.',
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- KEY ADDITIONAL DETAILS ----------------
              const TacticalSectionHeader('Key Additional Details'),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalDetailList(
                entries: {
                  'Origin': 'Command Depot',
                  'Short Name': 'Alpha-02',
                  'POI': 'Sector Alpha',
                  'Type': 'key',
                  'In System Since': 'Base (0.1)',
                },
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- SEARCH FIELD ----------------
              const TacticalSectionHeader('Search Field'),
              const SizedBox(height: TacticalSpacing.sm),
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: TacticalColors.outline)),
                ),
                child: TacticalSearchField(
                  controller: _filterController,
                  hintText: 'Filter...',
                ),
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- CODE COMMENT HEADERS ----------------
              const TacticalCodeHeader('Feedback'),
              const SizedBox(height: TacticalSpacing.sm),
              Wrap(
                children: [
                  const Text('You can join our '),
                  TacticalInlineLink('<:Community/>', onTap: () {}),
                  const Text(' where you can leave feedback to help us make Tac Map even better.'),
                ],
              ),
              const SizedBox(height: TacticalSpacing.md),
              const TacticalCodeHeader('Support'),
              const SizedBox(height: TacticalSpacing.sm),
              Wrap(
                children: [
                  const Text('You can '),
                  TacticalInlineLink('<:Support/>', onTap: () {}),
                  const Text(' us and the project in general.'),
                ],
              ),
              const SizedBox(height: TacticalSpacing.xl),

              // ---------------- TOOLBAR SELECT GROUP ----------------
              const TacticalSectionHeader('Toolbar Select Group'),
              const SizedBox(height: TacticalSpacing.sm),
              Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: TacticalColors.outline),
                  ),
                ),
                child: TacticalToolbarSelectGroup(
                  items: [
                    TacticalToolbarSelect(
                      label: 'Default',
                      options: const ['Default', 'Compact'],
                      onSelected: (_) {},
                    ),
                    TacticalToolbarSelect(
                      label: 'Normal',
                      options: const ['Normal', 'High Contrast'],
                      onSelected: (_) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- COUNTER HEADER + TASK LIST ----------------
              const TacticalSectionHeader('Task List'),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalCounterHeader(title: 'Active Objectives', count: 3),
              TacticalTaskListItem(
                title: 'Alpha Sector Recon',
                badges: const [TacticalStatusBadge('0.4', variant: TacticalBadgeVariant.success)],
                onTap: () {},
              ),
              TacticalTaskListItem(
                title: 'Substation Breach',
                badges: const [
                  TacticalStatusBadge('LCKD', variant: TacticalBadgeVariant.danger),
                  TacticalStatusBadge('DR', variant: TacticalBadgeVariant.danger),
                  TacticalStatusBadge('0.4', variant: TacticalBadgeVariant.success),
                ],
                onTap: () {},
              ),
              TacticalTaskListItem(
                title: 'Data Link Transfer',
                showSwapIcon: true,
                badges: const [TacticalStatusBadge('0.4', variant: TacticalBadgeVariant.success)],
                onTap: () {},
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- ACCORDION ----------------
              const TacticalSectionHeader('Expandable Section'),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalExpandableSection(
                title: 'Description',
                initiallyExpanded: true,
                child: Text('Access key for Sector Alpha Command Office.'),
              ),
              TacticalExpandableSection(
                title: 'Task Requirement',
                variant: TacticalHeaderVariantAlias.warning,
                child: Wrap(
                  children: [
                    const Text('Required for the '),
                    TacticalInlineLink('Primary Recon', onTap: () {}),
                    const Text(' task(s).'),
                  ],
                ),
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- DIALOG / SNACKBAR / EMPTY STATE ----------------
              const TacticalSectionHeader('Dialog, Snackbar & Empty State'),
              const SizedBox(height: TacticalSpacing.sm),
              Wrap(
                spacing: TacticalSpacing.sm,
                runSpacing: TacticalSpacing.sm,
                children: [
                  OutlinedButton(
                    onPressed: () => showTacticalConfirmDialog(
                      context,
                      title: 'Delete marker',
                      message: 'This action cannot be undone.',
                      danger: true,
                    ),
                    child: const Text('Show Confirm Dialog'),
                  ),
                  OutlinedButton(
                    onPressed: () => showTacticalSnackBar(
                      context,
                      'Marker saved successfully.',
                      variant: TacticalBadgeVariant.success,
                    ),
                    child: const Text('Show Snackbar'),
                  ),
                ],
              ),
              const SizedBox(height: TacticalSpacing.md),
              const TacticalEmptyState(message: 'No results found'),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- SCAN INDICATOR ----------------
              const TacticalSectionHeader('Scan Indicator'),
              const SizedBox(height: TacticalSpacing.sm),
              const Center(child: TacticalScanIndicator()),
              const SizedBox(height: TacticalSpacing.xl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TacticalBottomNavBar(
        currentIndex: _customNavIndex,
        onTap: (i) => setState(() => _customNavIndex = i),
        items: const [
          TacticalNavItem(icon: Icons.change_history),
          TacticalNavItem(icon: Icons.home_outlined),
          TacticalNavItem(icon: Icons.checklist_outlined),
          TacticalNavItem(icon: Icons.vpn_key_outlined),
          TacticalNavItem(icon: Icons.info_outline),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.change_history),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
