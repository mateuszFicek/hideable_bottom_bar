A Flutter implementation of hideable bottom bar with vertical slide animation.

## Features

Create bottom navigation bar that can animate bellow screen.

## Install

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  hideable_bottom_bar: <latest_version>
```

In your library add the following import:

```dart
import 'package:hideable_bottom_bar/hideable_bottom_bar.dart';
```



## Usage
Create HideableBottomBar place it in Stack and change bottomPosition to animate widget.

![Bottom bar animation](https://media3.giphy.com/media/9nLRYf3XsukcOJgz00/giphy.gif?cid=5e214886a233f4c10f539f9aee773019341fd2394c4386e1&rid=giphy.gif&ct=g)

```dart
HideableBottomBar(
    selectedIndex: selectedIndex,
    bottomPosition: bottomPosition,
    horizontalPadding: 24,
    children: List.generate(
        5,
        (index) => HideableBottomNavigationItem(
            index: index,
            name: _text(index),
            icon: _icon(index),
        ),
    ),
    onSelected: (c) {
        selectedIndex = c.index;
    },
),
```
