import 'package:flutter/material.dart';

class HideableBottomBar extends StatefulWidget {
  final Duration duration;
  final Widget? bottomBarWidget;
  final int selectedIndex;
  final Color backgroundColor;
  final Color unselectedColor;
  final Color selectedColor;
  final BoxShadow shadow;
  final double height;
  final TextStyle selectedItemTextStyle;
  final double horizontalPadding;
  final double bottomPosition;
  final Function(HideableBottomNavigationItem) onSelected;
  final List<HideableBottomNavigationItem> children;
  final Curve? curve;

  const HideableBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.children,
    required this.onSelected,
    this.curve,
    this.height = 60,
    this.backgroundColor = Colors.white,
    required this.bottomPosition,
    this.horizontalPadding = 16,
    this.selectedColor = Colors.black,
    this.unselectedColor = Colors.white,
    this.shadow = const BoxShadow(
      color: Colors.grey,
      blurRadius: 16,
    ),
    this.selectedItemTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
    this.duration = const Duration(milliseconds: 300),
    this.bottomBarWidget,
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
      curve: widget.curve ?? Curves.linear,
      left: widget.horizontalPadding,
      right: widget.horizontalPadding,
      child: widget.bottomBarWidget ?? _defaultBottomBar(),
    );
  }

  Widget _defaultBottomBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          boxShadow: [widget.shadow],
          borderRadius: BorderRadius.circular(16),
        ),
        height: widget.height,
        child: _bottomBarRow());
  }

  Widget _bottomBarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        children.length,
        (index) {
          if (index == selectedIndex) {
            return _selectedItemBuilder(index);
          }
          return _unselectedItemBuilder(index);
        },
      ),
    );
  }

  Center _selectedItemBuilder(int index) {
    return Center(
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
    );
  }

  GestureDetector _unselectedItemBuilder(int index) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(children[index]);
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
    );
  }

  Icon _icon(int index, Color color) =>
      Icon(children[index].icon, color: color);
}

class HideableBottomNavigationItem {
  final String name;
  final IconData icon;
  final int index;

  HideableBottomNavigationItem(
      {required this.index, required this.icon, required this.name});
}
