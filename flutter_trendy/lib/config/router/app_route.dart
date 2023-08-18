import 'package:flutter_library_managent/features/Home/presentation/screen/navigation_screen.dart';
import 'package:flutter_library_managent/features/profile/presentation/order_details_screen.dart';
import 'package:flutter_library_managent/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:flutter_library_managent/features/auth/presentation/screen/sign_up_screen.dart';

import '../../features/profile/presentation/my_orders_screen.dart';

class AppRoute {
  AppRoute._();

  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String batchStudentRoute = '/batchStudent';
  static const String googleMapRoute = '/googleMap';
  static const String orderDetailsRoute = '/orderDetails';
  static const String orderScreenRoute = '/orderScreen';

  static getApplicationRoute() {
    return {
      loginRoute: (context) => const SignIn(),
      registerRoute: (context) => const SignUp(),
      homeRoute: (context) => const NavigationDrawers(),
      orderScreenRoute: (context) => const OrderDetailsScreen(),

      // registerRoute: (context) => const RegisterView(),
      // batchStudentRoute: (context) => const BatchStudentView(null),
      // googleMapRoute: (context) => const GoogleMapView(),
    };
  }
}
