import 'package:flutter/material.dart';
import 'package:flutter_library_managent/config/router/app_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KhaltiScope(
        publicKey: "test_public_key_bb1471963e924514a506965357fd2c02",
        enabledDebugging: true,
        builder: (context, navKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Trendy',
            initialRoute: AppRoute.loginRoute,
            routes: AppRoute.getApplicationRoute(),
            navigatorKey: navKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
          );
        });
  }
}
