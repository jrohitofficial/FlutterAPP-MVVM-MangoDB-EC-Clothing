import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_library_managent/features/auth/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';

// initialize the shared preferences and dio with provider
final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

// the bewlo code can accept the class AuthRemoteDataSource as ref with provider
// so it can access fro that authRemoteDataSourceProvider becasue of the class AuthRemoteDataSource

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  // login of library managemnt system which retuern Either true or false
  Future<Either<AppException, bool>> loginStudent(
    String username,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        print("trueeeeeeeeeeeeeeeeeeeeeeeeeee");
        // retrieve token
        String token = response.data["token"];
        // save token to shared preferences
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      } else {
        print(
            "falseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        return Left(
          AppException(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        AppException(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<AppException, bool>> registerStudent(UserModel user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: user.toMap(),
      );

      if (response.statusCode == 200) {
        // Registration successful
        return const Right(true);
      } else {
        // Registration failed
        return Left(
          AppException(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      // Dio exception occurred
      return Left(
        AppException(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
