import 'package:flutter/material.dart';
import 'package:flutter_library_managent/config/router/app_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
     
      initialRoute: AppRoute.loginRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
