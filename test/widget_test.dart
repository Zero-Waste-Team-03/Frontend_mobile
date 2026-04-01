import 'package:flutter_test/flutter_test.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/main.dart';

void main() {
  testWidgets('App bootstraps', (WidgetTester tester) async {
    configureDependencies();
    await tester.pumpWidget(const GaspZeroApp());
    expect(find.byType(GaspZeroApp), findsOneWidget);
  }, tags: ['requires_env']);
}
