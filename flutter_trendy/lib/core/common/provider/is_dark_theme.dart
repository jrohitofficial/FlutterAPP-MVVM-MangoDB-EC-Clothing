// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_and_api_for_class/core/shared_prefs/app_theme_prefs.dart';

// final isDarkThemeProvider = StateNotifierProvider<IsDarkTheme, bool>(
//   (ref) => IsDarkTheme(
//     ref.watch(appThemePrefsProvider),
//   ),
// );

// class IsDarkTheme extends StateNotifier<bool> {
//   final AppThemePrefs appThemePrefs;

//   // initially it will be light theme
//   IsDarkTheme(this.appThemePrefs) : super(false) {
//     onInit();
//   }

//   onInit() async {
//     final isDarkTheme = await appThemePrefs.getTheme();
//     isDarkTheme.fold((l) => state = false, (r) => state = r);
//   }

//   updateTheme(bool isDarkTheme) {
//     appThemePrefs.setTheme(isDarkTheme);
//     state = isDarkTheme;
//   }
// }
