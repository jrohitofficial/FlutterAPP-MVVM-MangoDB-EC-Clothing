import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_library_managent/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Login interation testing', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    Finder phoneInput = find.byKey(const ValueKey("txtEmail"));
    await tester.enterText(phoneInput, "testx1@gmail.com");
    Finder passwordInput = find.byKey(const ValueKey("txtPassword"));
    await tester.enterText(passwordInput, "test123456");
    Finder btnLogin = find.byKey(const ValueKey("btnLogin"));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
  });
}
