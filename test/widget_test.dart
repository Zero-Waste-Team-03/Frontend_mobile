import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gaspzero/main.dart'; // gaspzero because pubspec.yaml name

void main() {
  testWidgets('App startup test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GaspZeroApp());

    // Verify that the loading mock text is shown.
    expect(find.text("Gasp'Zero Map Loading..."), findsOneWidget);
  });
}
