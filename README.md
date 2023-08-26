

# ListFilteringTile Widget

The `ListFilteringTile` is a customizable Flutter widget that allows you to create a filter based on an enum's values. It detects changes and provides an initial enum object as start data if available. When the initial filter is set to null, it indicates that no filter is being applied, and the list will display "All" items.

## Installation

To use the `ListFilteringTile` widget in your Flutter project, follow these steps:

1. Add the package to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     your_package_name: ^your_package_version
   ```

2. Import the package in your Dart code:

   ```dart
   import 'package:flutter/material.dart';
   import 'package:your_package_name/list_filtering_tile.dart';
   ```

## Usage

Create an **Enum** that overrides the method `toString` which will produce the label:

```dart
// the enum elements we are trying to filter for.
enum MyFilterType {
  firstType,
  secondType,
  otherType
}

// adding label
extention on MyFilterType {
  @override
  String toString(){
    return this.name;
  }
}

```

The `ListFilteringTile` widget can be used to create a filter chip bar with a list of filters based on an enum's values. Here's an example of how to use it:

```dart
ListFilteringTile<MyEnum>(
  onChanged: (selectedFilter) {
    // Handle the selected filter change
  },
  initialFilter: MyEnum.someValue, // Optional initial filter
  allLabel: "All Categories",      // Optional label for "All" option
);
```

- The `onChanged` callback function will be called whenever a filter is selected or changed. The selected filter is passed as an argument.
- The `initialFilter` parameter can be used to set the initial filter when the widget is first displayed. Pass `null` if no initial filter is needed.
- The `allLabel` parameter allows you to customize the label for the "All" option.

## Example

Here's an example of how you might use the `ListFilteringTile` widget in your Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:your_package_name/list_filtering_tile.dart';

enum Category { all, electronics, clothing, books }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Filter Categories'),
        ),
        body: Center(
          child: ListFilteringTile<Category>(
            onChanged: (selectedCategory) {
              // Handle selectedCategory change
            },
            initialFilter: Category.all,
            allLabel: "All Categories",
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());
```


