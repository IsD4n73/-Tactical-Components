import 'package:flutter/material.dart';
import 'package:tactical_components/tactical_components.dart';

/// ============================================================
/// DEMO SCREEN
/// Assembla tutti i componenti Tactical HUD in un'unica schermata
/// scrollabile, per verificarne rendering e coerenza visiva.
///
/// Per avviarla:
///   void main() => runApp(const TacticalDemoApp());
/// ============================================================

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
  String _selectedRadio = 'opt1';

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  int _drawerNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(TacticalSpacing.xs),
          child: TacticalMenuButton(),
        ),
        title: const TacticalText('TACTICAL MAP ///'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: TacticalDrawer(
        title: 'NAVIGATION ///',
        currentIndex: _drawerNavIndex,
        onItemTap: (index) => setState(() => _drawerNavIndex = index),
        items: const [
          TacticalMenuItem(
            label: 'Tactical Map',
            icon: Icons.map_outlined,
            selectedIcon: Icons.map,
            badge: 'v0.4',
            badgeVariant: TacticalBadgeVariant.success,
          ),
          TacticalMenuItem(
            label: 'Active Objectives',
            icon: Icons.checklist_outlined,
            selectedIcon: Icons.checklist,
            badge: '3 ACTIVE',
            badgeVariant: TacticalBadgeVariant.warning,
          ),
          TacticalMenuItem(
            label: 'Key Database',
            icon: Icons.vpn_key_outlined,
            selectedIcon: Icons.vpn_key,
          ),
          TacticalMenuItem(
            label: 'System Diagnostics',
            icon: Icons.analytics_outlined,
            selectedIcon: Icons.analytics,
            badge: 'OK',
            badgeVariant: TacticalBadgeVariant.info,
          ),
          TacticalMenuItem(
            label: 'Terminal Settings',
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
          ),
        ],
        footer: const Text(
          'TAC_SYS v1.0.0 /// SYSTEM ONLINE',
          style: TextStyle(color: TacticalColors.textSecondary, fontSize: 11),
        ),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                  TextButton(onPressed: () {}, child: const Text('Undo')),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- ACTION BUTTONS + CLOSE ----------------
              const TacticalSectionHeader('Action Buttons'),
              const SizedBox(height: TacticalSpacing.sm),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: TacticalSpacing.sm,
                runSpacing: TacticalSpacing.sm,
                children: [
                  TacticalFilledButton(label: 'Back', onPressed: () {}),
                  TacticalFilledButton(
                    label: 'Key',
                    backgroundColor: TacticalFilledButton.neutralBackground,
                    onPressed: () {},
                  ),
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
                  border: Border(
                    bottom: BorderSide(color: TacticalColors.outline),
                  ),
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
                  const Text(
                    ' where you can leave feedback to help us make Tac Map even better.',
                  ),
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
                badges: const [
                  TacticalStatusBadge(
                    '0.4',
                    variant: TacticalBadgeVariant.success,
                  ),
                ],
                onTap: () {},
              ),
              TacticalTaskListItem(
                title: 'Substation Breach',
                badges: const [
                  TacticalStatusBadge(
                    'LCKD',
                    variant: TacticalBadgeVariant.danger,
                  ),
                  TacticalStatusBadge(
                    'DR',
                    variant: TacticalBadgeVariant.danger,
                  ),
                  TacticalStatusBadge(
                    '0.4',
                    variant: TacticalBadgeVariant.success,
                  ),
                ],
                onTap: () {},
              ),
              TacticalTaskListItem(
                title: 'Data Link Transfer',
                showSwapIcon: true,
                badges: const [
                  TacticalStatusBadge(
                    '0.4',
                    variant: TacticalBadgeVariant.success,
                  ),
                ],
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

              // ---------------- TACTICAL TEXT FIELD ----------------
              const TacticalSectionHeader('Tactical Text Field'),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalTextField(
                label: 'Encryption Key ///',
                hintText: 'Enter 16-character key...',
                prefixText: '>_ ',
                suffixIcon: Icons.lock_outline,
              ),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalTextField(
                label: 'Access Protocol ///',
                hintText: 'Required protocol...',
                errorText: 'INVALID AUTHORIZATION CODE',
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- PROGRESS BARS ----------------
              const TacticalSectionHeader('Progress Bars'),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalProgressBar(
                label: 'System Diagnostics',
                value: 0.85,
                color: TacticalColors.green,
                style: TacticalProgressStyle.segmented,
              ),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalProgressBar(
                label: 'Data Sync',
                value: 0.42,
                color: TacticalColors.yellow,
                style: TacticalProgressStyle.solid,
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- STEP TRACKER ----------------
              const TacticalSectionHeader('Step Tracker'),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalStepTracker(
                direction: Axis.vertical,
                steps: [
                  TacticalStep(
                    title: 'Phase 1: Infiltration',
                    subtitle: 'Secure entry point Alpha-01',
                    isCompleted: true,
                  ),
                  TacticalStep(
                    title: 'Phase 2: Terminal Breach',
                    subtitle: 'Download encrypted telemetry data',
                    isActive: true,
                  ),
                  TacticalStep(
                    title: 'Phase 3: Exfiltration',
                    subtitle: 'Extract at Helipad Bravo',
                  ),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- DIVIDERS & NOTIFICATION BADGES ----------------
              const TacticalSectionHeader('Divider & Notification Badges'),
              const SizedBox(height: TacticalSpacing.sm),
              const TacticalDivider(label: 'SECTION ALPHA'),
              const SizedBox(height: TacticalSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  TacticalNotificationBadge(
                    text: '3',
                    variant: TacticalBadgeVariant.danger,
                    child: Icon(
                      Icons.notifications_outlined,
                      color: TacticalColors.textPrimary,
                      size: 28,
                    ),
                  ),
                  TacticalNotificationBadge(
                    text: 'NEW',
                    variant: TacticalBadgeVariant.success,
                    child: Icon(
                      Icons.mail_outline,
                      color: TacticalColors.textPrimary,
                      size: 28,
                    ),
                  ),
                  TacticalNotificationBadge(
                    text: '!',
                    variant: TacticalBadgeVariant.warning,
                    child: Icon(
                      Icons.warning_amber_outlined,
                      color: TacticalColors.textPrimary,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- RADIO GROUP & KPI CARDS ----------------
              const TacticalSectionHeader('Radio Group & KPI Cards'),
              const SizedBox(height: TacticalSpacing.sm),
              TacticalRadioGroup<String>(
                selectedValue: _selectedRadio,
                onChanged: (val) => setState(() => _selectedRadio = val),
                options: const [
                  TacticalRadioOption(value: 'opt1', label: 'Protocol Alpha - High Security'),
                  TacticalRadioOption(value: 'opt2', label: 'Protocol Beta - Stealth Mode'),
                  TacticalRadioOption(value: 'opt3', label: 'Protocol Gamma - Standard Bypass'),
                ],
              ),
              const SizedBox(height: TacticalSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: TacticalKpiCard(
                      title: 'STAMINA',
                      value: '98',
                      unit: '%',
                      trend: '▲ +2.4%',
                      trendColor: TacticalColors.green,
                      icon: Icons.flash_on,
                    ),
                  ),
                  const SizedBox(width: TacticalSpacing.sm),
                  Expanded(
                    child: TacticalKpiCard(
                      title: 'SIGNAL',
                      value: '450',
                      unit: 'MHz',
                      trend: '▼ -0.8%',
                      trendColor: TacticalColors.red,
                      badge: 'SECURE',
                      badgeVariant: TacticalBadgeVariant.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TacticalSpacing.lg),

              // ---------------- PANEL, TOOLTIP & SKELETON ----------------
              const TacticalSectionHeader('Panel, Tooltip & Skeleton'),
              const SizedBox(height: TacticalSpacing.sm),
              TacticalPanel(
                title: 'TACTICAL TELEMETRY PANEL',
                accentColor: TacticalColors.green,
                accentPosition: TacticalPanelAccentPosition.top,
                headerAction: TacticalTooltip(
                  message: 'LIVE TELEMETRY FEED ACTIVE',
                  child: const TacticalStatusBadge('LIVE', variant: TacticalBadgeVariant.success),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Loading tactical satellite data stream...'),
                    SizedBox(height: TacticalSpacing.sm),
                    TacticalSkeleton(height: 14),
                    SizedBox(height: 6),
                    TacticalSkeleton(width: 200, height: 14),
                  ],
                ),
              ),
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
