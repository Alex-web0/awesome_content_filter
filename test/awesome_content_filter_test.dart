import 'package:awesome_content_filter/awesome_content_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

enum TestType { sd, gg, ss }

void main() {
  testWidgets('adds one to input values', (w) async {
    w.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: ListFilteringTile<TestType>(
            onChanged: (TestType? type) {},
            enumValues: TestType.values,
          ),
        ),
      ),
    ));
  });
}
