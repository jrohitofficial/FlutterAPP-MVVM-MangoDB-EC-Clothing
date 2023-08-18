
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_library_managent/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Register interation testing', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    // txtName
    Finder nameInput = find.byKey(const ValueKey("txtName"));
    await tester.enterText(nameInput, "testx1");
    Finder emailInput = find.byKey(const ValueKey("txtEmail"));
    await tester.enterText(emailInput, "testx1@gmail.com");
    Finder passwordInput = find.byKey(const ValueKey("txtPassword"));
    await tester.enterText(passwordInput, "test123456");
    // txtConfirmPassword
    Finder confirmPasswordInput = find.byKey(const ValueKey("txtConfirmPassword"));
    await tester.enterText(confirmPasswordInput, "test123456");

    Finder btnLogin = find.byKey(const ValueKey("btnRegister"));
    await tester.tap(btnLogin);
    await tester.pumpAndSettle();
  });
}
