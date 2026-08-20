## 1.1.0

# Features

- Add `IconStyleData.trailingIcon` as the title icon customization option.
- Add `animationDuration` to customize list expansion and title icon rotation timing.
- Add optional `autoCollapsed` behavior to collapse the list after selecting an item.
- Add `initiallyExpanded` to render the list opened on first build.
- Add `onExpansionChanged` to listen to open and close changes.
- Add `selectedTitleBuilder` to customize the collapsed title text.
- Add `itemBuilder` to customize item row content while keeping the built-in selection behavior.

# Fixes

- Deprecate the generic `ListSelectionWidget` constructor in favor of `ListSelectionWidget.single` and `ListSelectionWidget.multi`.
- Remove the misspelled `IconStyleData.tailingIcon` parameter.
- Keep selected values synchronized when `selectedValue`, `multiSelectValues`, or `listItems` change after the first build.
- Restore the list expansion animation to fade vertically instead of sliding from the side.
- Remove internal dynamic selection passing and unused expansion provider code.
- Fix initial single selection so `selectedValue` is matched by value instead of defaulting to the first item.
- Update Flutter package constraints and lint dependency for recent Flutter versions.

## 1.0.1

- added icon personalization:
  - Now it will be possible to integrate a custom icon for both the title and the selection ones.

## 1.0.0

- added factories
- code optimization
- class models for added styles

## 0.0.1

## 0.0.2

Compatibility and repository details added
