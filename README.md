# Tactical HUD UI Kit (`tactical_components`)

A Flutter component library and design system providing a **Military Terminal / Tactical HUD** interface.

---

## ✨ Features

- 🪖 **Military Terminal Aesthetic**: Flat 1px borders, zero-radius corners, and JetBrains Mono monospace typography.
- 🎨 **Pre-configured Dark Theme**: Drop-in `TacticalTheme.dark` ready for instant application setup.
- 🧱 **20+ Tactical UI Components**: State toggles, segmented controls, color swatch pickers, location chips, task lists, status badges, expandable accordion sections, animated radar sweep indicators, modal confirm dialogs, and custom snackbars.
- 🎯 **Centralized Tokens**: Access `TacticalColors` and `TacticalSpacing` for custom HUD extensions.
- 📱 **Interactive Showcase Included**: Complete demo screen included out-of-the-box (`TacticalDemoApp`).

---

## 📐 Design System Principles

1. **Flat & Sharp Geometry**: Zero border radii (`BorderRadius.zero`) on all buttons, inputs, dialogs, and containers.
2. **1px Tactical Borders**: Surfaces are demarcated by 1px solid borders (`TacticalColors.outline` / `TacticalColors.outlineStrong`) without dropshadows or gradients (`elevation: 0`).
3. **Monospace Typography**: All text is rendered using **JetBrains Mono** via `GoogleFonts` and formatted in **UPPERCASE** for a terminal interface aesthetic.
4. **High-Contrast Dark Theme**: Deep black/dark-gray backgrounds combined with distinct semantic state colors (Green, Yellow, Orange, Red, Blue, Muted).

---

## 📦 Installation & Setup

### Prerequisites
- **Flutter**: `>=3.12.0`
- **Dart**: `>=3.12.0`

### 1. Add Dependency to `pubspec.yaml`

#### Option A: Local Path Dependency (Recommended for local workspace)
```yaml
dependencies:
  flutter:
    sdk: flutter
  tactical_components:
    path: ../path/to/tactical_components
```

#### Option B: Git Repository Dependency
```yaml
dependencies:
  flutter:
    sdk: flutter
  tactical_components:
    git:
      url: https://github.com/your-username/tactical_components.git
      ref: main
```

#### Option C: Pub.dev Package (If published)
```yaml
dependencies:
  flutter:
    sdk: flutter
  tactical_components: ^1.0.0
```

Then fetch the package:
```bash
flutter pub get
```

### 2. Import & Apply Theme

Import all components, theme settings, and widgets via a single library import (`package:tactical_components/tactical_components.dart`):

```dart
import 'package:flutter/material.dart';
import 'package:tactical_components/tactical_components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tactical HUD',
      theme: TacticalTheme.dark, // Apply military dark theme
      home: const TacticalDemoScreen(),
    );
  }
}
```

---

## 💡 Useful Info & Best Practices

- 🔤 **JetBrains Mono Font**: The library automatically loads **JetBrains Mono** using `google_fonts`. No manual TTF assets are required in your app's `pubspec.yaml`.
- 🔠 **Uppercase Text Convention**: Tactical HUD components automatically transform text strings to uppercase. When writing custom text widgets, use `TacticalText('LABEL')` or `.toUpperCase()` to maintain terminal consistency.
- 📐 **Zero Border Radius**: Never add rounded corners (`BorderRadius.circular(...)`) to tactical components; keep all edges sharp and rectangular to preserve the military terminal aesthetic.
- 🧪 **Running the Example App**: You can run the interactive component showcase directly from the repository using:
  ```bash
  flutter run -t example/lib/main.dart
  ```

---

## 🎨 Theme & Tokens (`lib/theme.dart`)

### `TacticalColors`

| Color Constant | Hex Value | Intended Usage |
| :--- | :--- | :--- |
| `background` | `#0A0A0A` | Main app scaffold background |
| `surface` | `#141414` | Card, box, and container background |
| `surfaceHigh` | `#1B1B1B` | Elevated header / panel background |
| `outline` | `#2A2A2A` | Standard 1px divider and border color |
| `outlineStrong` | `#3A3A3A` | Emphasized element border color |
| `textPrimary` | `#E0E0E0` | Primary readable text |
| `textSecondary` | `#8A8A8A` | Muted labels, subtitles, and detail headers |
| `textDisabled` | `#4A4A4A` | Disabled text and buttons |
| `green` | `#3DFF6E` | Active state, success, positive values, radar accents |
| `yellow` | `#F2C744` | Warnings, primary action buttons, code comments (`//:`) |
| `orange` | `#FF7A29` | Task requirements, warning headers |
| `red` | `#FF4444` | Locked items, external links, error/danger states |
| `blue` | `#4A9EFF` | Links, toggles, sub-navigation highlights |
| `muted` | `#6E6E6E` | Inactive / OFF toggle state |
| `swatchPalette` | *List* | Pre-defined drawing color palette (`White`, `Yellow`, `Blue`, `Red`, `Green`) |

### `TacticalSpacing`

* `xs`: 4.0
* `sm`: 8.0
* `md`: 16.0
* `lg`: 24.0
* `xl`: 32.0
* `borderWidth`: 1.0
* `radius`: `BorderRadius.zero`
* `inputBorderShape`: `OutlineInputBorder(borderRadius: BorderRadius.zero)`

### `TacticalText`

A convenience helper widget that automatically renders uppercase monospace text:

```dart
TacticalText('Tactical Map ///', style: TextStyle(fontSize: 16))
```

---

## 🧩 Core Components (`lib/tactical_widgets.dart`)

### 1. `TacticalStateToggle`

Label button displaying bracketed `[ ON ]` / `[OFF]` state.

```dart
TacticalStateToggle(
  label: 'GRID',
  value: isGridEnabled,
  onChanged: (val) => setState(() => isGridEnabled = val),
)
```

### 2. `TacticalSegmentedControl`

Multi-option selector with highlighted active background.

```dart
TacticalSegmentedControl(
  options: const ['Solid', 'Dashed'],
  selectedIndex: selectedIndex,
  onChanged: (index) => setState(() => selectedIndex = index),
  selectedColor: TacticalColors.blue,
)
```

### 3. `TacticalColorSwatchPicker`

Row of color swatches for drawing/annotation toolbars with active selection outline.

```dart
TacticalColorSwatchPicker(
  selectedColor: currentColor,
  onChanged: (color) => setState(() => currentColor = color),
  colors: TacticalColors.swatchPalette,
)
```

### 4. `TacticalFilledButton`

Square primary or neutral action button with bold uppercase text.

```dart
// Primary Action (Yellow)
TacticalFilledButton(
  label: 'BACK',
  onPressed: () => Navigator.pop(context),
  backgroundColor: TacticalColors.yellow,
)

// Neutral Action (Gray)
TacticalFilledButton(
  label: 'KEY',
  onPressed: () {},
  backgroundColor: TacticalFilledButton.neutralBackground,
)
```

### 5. `TacticalCloseButton`

Square gray close button with an 'X' icon.

```dart
TacticalCloseButton(
  onPressed: () => Navigator.pop(context),
  size: 48,
)
```

### 6. `TacticalSectionHeader`

Uppercase section title with semantic variant coloring.

* Variants: `neutral`, `warning`, `success`, `info`, `danger`.

```dart
TacticalSectionHeader(
  'TASK REQUIREMENT',
  variant: TacticalHeaderVariant.warning,
)
```

### 7. `TacticalCodeHeader`

Code-style comment header prefixed with `//:`.

```dart
TacticalCodeHeader('Feedback & Bug Reports')
```

### 8. `TacticalInlineLink`

Underlined actionable link or wavy-underlined glossary term.

```dart
// Action Link
TacticalInlineLink(
  'Primary Recon',
  variant: TacticalLinkVariant.link,
  onTap: () {},
)

// Glossary Term (Wavy Yellow Underline)
TacticalInlineLink(
  'static spawns',
  variant: TacticalLinkVariant.glossaryTerm,
)
```

### 9. `TacticalDetailRow` & `TacticalDetailList`

Key-value metadata rows with bottom divider line.

```dart
TacticalDetailList(
  entries: {
    'LOCATION': 'Sector Alpha Base',
    'KEY REQUIRED': 'SEC-02',
    'AUTHORITY': 'HQ',
  },
)
```

### 10. `TacticalLocationChip` & `TacticalLocationChipGrid`

Bordered chips displaying coordinates, spawn points, or locked icons.

```dart
TacticalLocationChipGrid(
  chips: [
    TacticalLocationChip(
      label: 'Spawn #1',
      icon: Icons.gps_fixed,
      iconColor: TacticalColors.green,
      onTap: () {},
    ),
    TacticalLocationChip(
      label: 'Locked Object',
      icon: Icons.lock,
      iconColor: TacticalColors.red,
      showTrailingIcon: true,
    ),
  ],
)
```

### 11. `TacticalNoteRow`

Icon + text annotation row with leading alert/link icon.

```dart
TacticalNoteRow(
  text: 'Appears only during active quest phase.',
  icon: Icons.link,
  iconColor: TacticalColors.red,
)
```

### 12. `TacticalDropdownField`

Highlighted popup dropdown field with optional color indicators.

```dart
TacticalDropdownField<String>(
  selected: selectedVersion,
  onChanged: (val) => setState(() => selectedVersion = val),
  options: const [
    TacticalDropdownOption(value: 'v0.3', label: 'Sector 0.3'),
    TacticalDropdownOption(
      value: 'v0.4',
      label: 'Sector 0.4',
      indicatorColor: TacticalColors.green,
    ),
  ],
)
```

### 13. `TacticalSearchField`

Terminal-style text field prefixed with `>_ `.

```dart
TacticalSearchField(
  hintText: 'Filter locations...',
  onChanged: (query) => filterItems(query),
)
```

---

## ⚡ Extended Components (`lib/tactical_widgets_extended.dart`)

### 1. `TacticalStatusBadge` & `TacticalBadgeGroup`

Compact status badge for list items (variants: `neutral`, `success`, `warning`, `danger`, `info`).

```dart
TacticalBadgeGroup(
  badges: const [
    TacticalStatusBadge('LCKD', variant: TacticalBadgeVariant.danger),
    TacticalStatusBadge('0.4', variant: TacticalBadgeVariant.success),
  ],
)
```

### 2. `TacticalCounterHeader`

Full-width banner header showing title and item count `[N]`.

```dart
TacticalCounterHeader(
  title: 'Active Tasks',
  count: 4,
)
```

### 3. `TacticalTaskListItem`

Item row featuring a leading radar icon, title, optional swap icon, and status badges.

```dart
TacticalTaskListItem(
  title: 'First Recon',
  leadingIcon: Icons.radar,
  badges: const [
    TacticalStatusBadge('0.4', variant: TacticalBadgeVariant.success),
  ],
  onTap: () {},
)
```

### 4. `TacticalToolbarSelectGroup`

Row of compact dropdown menus separated by thin vertical borders (`DEFAULT ▾ | NORMAL ▾ | SECTOR 0.4 ▾`).

```dart
TacticalToolbarSelectGroup(
  items: [
    TacticalToolbarSelect(
      label: 'Default ▾',
      options: ['Option A', 'Option B'],
      onSelected: (opt) {},
    ),
    TacticalToolbarSelect(
      label: 'Normal ▾',
      options: ['Normal', 'High Contrast'],
      onSelected: (opt) {},
    ),
  ],
)
```

### 5. `TacticalBottomNavBar`

5-item tactical bottom navigation bar with outline icons and active indicator color.

```dart
TacticalBottomNavBar(
  currentIndex: _selectedIndex,
  onTap: (i) => setState(() => _selectedIndex = i),
  items: const [
    TacticalNavItem(icon: Icons.map_outlined, selectedIcon: Icons.map),
    TacticalNavItem(icon: Icons.list_alt),
    TacticalNavItem(icon: Icons.search),
    TacticalNavItem(icon: Icons.settings),
  ],
)
```

### 6. `TacticalExpandableSection`

Collapsible accordion section featuring animated expand/collapse transitions and header color variants.

```dart
TacticalExpandableSection(
  title: 'Key Additional Details',
  variant: TacticalHeaderVariantAlias.neutral,
  initiallyExpanded: true,
  child: TacticalDetailList(entries: {'Map': 'Sector Alpha'}),
)
```

### 7. `showTacticalConfirmDialog`

Modal dialog function styled with tactical typography and standard/danger confirmation buttons.

```dart
final confirmed = await showTacticalConfirmDialog(
  context,
  title: 'Confirm Operation',
  message: 'Do you want to reset all tactical markers?',
  confirmLabel: 'CONFIRM',
  danger: true,
);
```

### 8. `showTacticalSnackBar`

Toast alert notification with a colored status indicator bar on the left edge.

```dart
showTacticalSnackBar(
  context,
  'Marker updated successfully.',
  variant: TacticalBadgeVariant.success,
);
```

### 9. `TacticalEmptyState`

Placeholder layout for empty search or query results with icon and centered text.

```dart
TacticalEmptyState(
  message: 'No tactical locations found',
  icon: Icons.search_off,
)
```

### 10. `TacticalScanIndicator`

Animated radar sweep progress indicator (replaces standard `CircularProgressIndicator`).

```dart
TacticalScanIndicator(
  size: 56,
  color: TacticalColors.green,
)
```

### 11. `TacticalDrawer`, `TacticalMenuItem` & `TacticalMenuButton`

Military terminal styled side navigation drawer and square hamburger trigger button.

```dart
// Hamburger Menu Button (AppBar leading or toolbar)
AppBar(
  leading: const Padding(
    padding: EdgeInsets.all(TacticalSpacing.xs),
    child: TacticalMenuButton(),
  ),
)

// Tactical Side Navigation Drawer
Scaffold(
  drawer: TacticalDrawer(
    title: 'NAVIGATION ///',
    currentIndex: selectedIndex,
    onItemTap: (index) => setState(() => selectedIndex = index),
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
        badge: '3 ACTIVE',
        badgeVariant: TacticalBadgeVariant.warning,
      ),
    ],
    footer: const Text('TAC_SYS v1.0.0 /// SYSTEM ONLINE'),
  ),
)
```

### 12. `TacticalTextField`

Terminal input field with top label, monospace font, green focus border, and red error state support.

```dart
TacticalTextField(
  label: 'Encryption Key ///',
  hintText: 'Enter 16-character key...',
  prefixText: '>_ ',
  suffixIcon: Icons.lock_outline,
  onChanged: (text) {},
)
```

### 13. `TacticalProgressBar`

Linear progress gauge with percentage readout in `segmented` or `solid` bar style.

```dart
TacticalProgressBar(
  label: 'System Diagnostics',
  value: 0.85,
  color: TacticalColors.green,
  style: TacticalProgressStyle.segmented,
)
```

### 14. `TacticalStepTracker`

Numbered phase/step timeline tracker (`01`, `02`, `03`) connected by 1px tactical lines.

```dart
TacticalStepTracker(
  direction: Axis.vertical,
  steps: const [
    TacticalStep(title: 'Phase 1: Infiltration', isCompleted: true),
    TacticalStep(title: 'Phase 2: Terminal Breach', isActive: true),
    TacticalStep(title: 'Phase 3: Exfiltration'),
  ],
)
```

### 15. `TacticalDivider`

Terminal 1px divider line with optional centered label string.

```dart
TacticalDivider(
  label: 'SECTION ALPHA',
  color: TacticalColors.outline,
)
```

### 16. `TacticalNotificationBadge`

Overlay notification badge wrapping any widget with corner alert badge.

```dart
TacticalNotificationBadge(
  text: '3',
  variant: TacticalBadgeVariant.danger,
  child: Icon(Icons.notifications_outlined),
)
```

---

## 📺 Demo Application (`lib/demo_screen.dart`)

To preview and interact with all Tactical HUD widgets in a single scrollable showcase screen:

```dart
import 'package:flutter/material.dart';
import 'package:tactical_components/tactical_components.dart';

void main() => runApp(const TacticalDemoApp());
```
