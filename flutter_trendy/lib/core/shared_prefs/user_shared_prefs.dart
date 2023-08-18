import 'package:dartz/dartz.dart';
import 'package:flutter_library_managent/core/failure/failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;
  // Set user token
  Future<Either<AppException, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return left(AppException(error: e.toString()));
    }
  }

  Future<Either<AppException, bool>> setUserId(String id) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('id', id);
      return right(true);
    } catch (e) {
      return left(AppException(error: e.toString()));
    }
  }

  Future<Either<AppException, String?>> getUserId() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('id');
      return right(token);
    } catch (e) {
      return left(AppException(error: e.toString()));
    }
  }

  // Get user token
  Future<String?> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return token;
    } catch (e) {
      AppException(error: e.toString());
    }
  }

  // Delete token
  Future<Either<AppException, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(AppException(error: e.toString()));
    }
  }
}
