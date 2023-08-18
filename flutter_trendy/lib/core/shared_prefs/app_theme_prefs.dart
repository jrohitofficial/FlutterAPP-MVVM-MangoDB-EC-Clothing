import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../failure/failure.dart';

final appThemePrefsProvider = Provider((ref) {
  return AppThemePrefs();
});

class AppThemePrefs {
  late SharedPreferences _sharedPreferences;

  // set theme
  Future<Either<AppException, bool>> setTheme(bool value) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setBool('isDarkTheme', value);
      return const Right(true);
    } catch (e) {
      return Left(AppException(error: e.toString()));
    }
  }

  // get theme
  Future<Either<AppException, bool>> getTheme() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      final isDark = _sharedPreferences.getBool('isDarkTheme') ?? false;
      return Right(isDark);
    } catch (e) {
      return Left(AppException(error: e.toString()));
    }
  }
}
