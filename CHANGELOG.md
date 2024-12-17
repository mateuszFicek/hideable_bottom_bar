## 1.0.1
Readme update.

## 1.0.0
### New Features:
- Added a `showTooltips` property to enable tooltips on navigation items.
- Introduced the `padding` property to customize padding around the bottom bar.
- Changed the horizontalPadding to margin.
- Added new property cornerRadius.
- The `onIndexChanged` callback has been added to notify external state listeners when the selected index changes.

### Improvements:
- Enhanced the `_selectedItemBuilder` to display both the icon and text with better layout styling.
- Refined `_wrapWithTooltip` to conditionally wrap widgets with `Tooltip` based on the `showTooltips` flag.

### Behavior Updates:
- The `onSelected` callback now triggers state updates and works alongside `onIndexChanged`.

## 0.0.1
Initial Open Source release.