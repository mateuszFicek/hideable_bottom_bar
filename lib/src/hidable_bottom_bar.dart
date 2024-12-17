import 'package:flutter/material.dart';

/// HideableBottomBar is a customizable and hideable bottom navigation bar widget for Flutter.
/// It allows for dynamic updates and a sleek, animated UI.
/// The widget supports custom child items and styling options, including color, size, and animations.
class HideableBottomBar extends StatefulWidget {
  /// Determines the duration of the animation when the bottom bar is shown or hidden.
  /// Default: Duration(milliseconds: 300)
  final Duration duration;

  /// Allows you to provide a custom widget to use as the bottom bar. If null, a default bottom bar will be used.
  /// Default: null
  final Widget? bottomBarWidget;

  /// Specifies the currently selected index of the bottom navigation items.
  /// Required parameter.
  final int selectedIndex;

  /// Sets the background color of the bottom bar.
  /// Default: Colors.white
  final Color backgroundColor;

  /// Sets the color for unselected navigation items.
  /// Default: Colors.white
  final Color unselectedColor;

  /// Sets the background color for the selected navigation item.
  /// Default: Colors.black
  final Color selectedColor;

  /// Provides a shadow effect for the bottom bar container.
  /// Default: [BoxShadow(color: Colors.grey, blurRadius: 16)]
  final List<BoxShadow> shadow;

  /// Sets the height of the bottom bar.
  /// Default: 60.0
  final double height;

  /// Configures the text style for the selected item’s label.
  /// TextStyle(fontSize: 16, color: Colors.white)
  final TextStyle selectedItemTextStyle;

  /// Sets the horizontal margin for the bottom bar.
  /// Default: 16.0
  final double margin;

  /// Controls the vertical position of the bottom bar relative to the bottom of the screen.
  /// Required parameter.
  final double bottomPosition;

  /// Callback function triggered when a navigation item is selected. It returns the selected HideableBottomNavigationItem.
  /// Required parameter.
  final Function(HideableBottomNavigationItem) onSelected;

  /// A callback that is triggered whenever the selected index changes.
  /// This allows external state management for the navigation bar.
  /// Default: null
  final Function(int)? onIndexChanged;

  /// List of navigation items displayed in the bottom bar.
  /// Required parameter.
  final List<HideableBottomNavigationItem> children;

  /// Specifies the animation curve for the bottom bar’s appearance and disappearance.
  /// Default: Curves.linear
  final Curve? curve;

  /// Specifies the corner radius for the bottom bar and the selected item.
  /// This allows customization of the widget’s rounded edges.
  /// Default: 16.0
  final double cornerRadius;

  /// Determines whether tooltips should be displayed when hovering or long-pressing on navigation items.
  /// Default: false
  final bool showTooltips;

  /// Defines the padding around the bottom bar.
  /// Default: EdgeInsets.symmetric(horizontal: 16.0)
  final EdgeInsetsGeometry? padding;

  /// Default constructor.
  const HideableBottomBar({
    Key? key,
    required this.bottomPosition,
    required this.children,
    required this.onSelected,
    required this.selectedIndex,
    this.backgroundColor = Colors.white,
    this.bottomBarWidget,
    this.cornerRadius = 16.0,
    this.curve,
    this.duration = const Duration(milliseconds: 300),
    this.height = 60,
    this.margin = 16,
    this.onIndexChanged,
    this.padding,
    this.selectedColor = Colors.black,
    this.selectedItemTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
    this.shadow = const [BoxShadow(color: Colors.grey, blurRadius: 16)],
    this.showTooltips = false,
    this.unselectedColor = Colors.white,
  }) : super(key: key);

  @override
  State<HideableBottomBar> createState() => _HideableBottomBarState();
}

class _HideableBottomBarState extends State<HideableBottomBar>
    with SingleTickerProviderStateMixin {
  late int selectedIndex = widget.selectedIndex;
  late List<HideableBottomNavigationItem> children = widget.children;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.duration,
      bottom: widget.bottomPosition,
      left: 0,
      right: 0,
      curve: widget.curve ?? Curves.linear,
      child: widget.bottomBarWidget ?? _defaultBottomBar(),
    );
  }

  Widget _defaultBottomBar() {
    return Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.symmetric(horizontal: widget.margin),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          boxShadow: widget.shadow,
          borderRadius: BorderRadius.circular(widget.cornerRadius),
        ),
        height: widget.height,
        child: _bottomBarRow());
  }

  Widget _bottomBarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        children.length,
        (index) => index == selectedIndex
            ? _selectedItemBuilder(index)
            : _unselectedItemBuilder(index),
      ),
    );
  }

  Widget _wrapWithTooltip({required Widget child, required String message}) {
    if (widget.showTooltips) {
      return Tooltip(message: message, child: child);
    }
    return child;
  }

  Widget _selectedItemBuilder(int index) {
    return _wrapWithTooltip(
      message: children[index].name,
      child: Center(
        child: Container(
          height: widget.height * 2 / 3,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: widget.selectedColor,
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(index, widget.unselectedColor),
              const SizedBox(width: 8),
              Text(
                children[index].name,
                style: widget.selectedItemTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _unselectedItemBuilder(int index) {
    return _wrapWithTooltip(
      message: children[index].name,
      child: GestureDetector(
        onTap: () {
          widget.onSelected(children[index]);
          widget.onIndexChanged?.call(index); // Notify external listener
          setState(() {
            selectedIndex = index;
          });
        },
        child: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.unselectedColor,
              shape: BoxShape.circle,
            ),
            child: _icon(index, widget.selectedColor),
          ),
        ),
      ),
    );
  }

  Widget _icon(int index, Color color) => children[index].icon;
}

/// HideableBottomNavigationItem represents an individual item in the HideableBottomBar widget.
/// It defines the properties needed to display the item, including its icon, label, and unique index.
class HideableBottomNavigationItem {
  /// The label or name of the navigation item. This text is displayed when the item is selected.
  /// Required parameter.
  final String name;

  /// The icon that represents the navigation item. It is displayed for both selected and unselected states.
  /// Required parameter.
  final Widget icon;

  /// A unique index identifying this navigation item within the HideableBottomBar. It is used to track the selected item.
  /// Required parameter.
  final int index;

  /// Default constructor.
  HideableBottomNavigationItem(
      {required this.index, required this.icon, required this.name});
}
