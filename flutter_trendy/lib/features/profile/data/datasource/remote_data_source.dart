import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_library_managent/core/shared_prefs/user_shared_prefs.dart';
import 'package:flutter_library_managent/features/profile/data/model/profileResponse.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../auth/data/model/user_model.dart';
import '../model/OrderResponse.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ProfileRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  // get userprofile

  Future<Either<AppException, ProfileResponse>> getUserProfile() async {
    try {
      final token = await userSharedPrefs.getUserToken();

      dio.options.headers['Authorization'] = 'Bearer $token';

      print("print from profile remote data source............");
      print(token);

      Response response = await dio.get(ApiEndpoints.profile);

      if (response.statusCode == 200) {
        final user = ProfileResponse.fromJson(response.data);
        return Right(user);
      } else {
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

  Future<Either<AppException, List<OrderResponse>>> getUserOrder() async {
    try {
      final token = await userSharedPrefs.getUserToken();

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.get(ApiEndpoints.getOrders);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          final orders = data
              .map((orderData) => OrderResponse.fromJson(orderData))
              .toList();
          return Right(orders);
        } else {
          return Left(AppException(
            error: 'Invalid response format',
            statusCode: response.statusCode.toString(),
          ));
        }
      } else {
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



  // Future<Either<AppException, List<BookingResponse>>> getUserRentBooks() async {
  //   try {
  //     final token = await userSharedPrefs.getUserToken();

  //     dio.options.headers['Authorization'] = 'Bearer $token';

  //     Response response = await dio.get(ApiEndpoints.getllBooking);

  //     if (response.statusCode == 200) {
  //       List<dynamic> bookingJson = response.data;
  //       List<BookingResponse> bookings = bookingJson
  //           .map((booking) => BookingResponse.fromJson(booking))
  //           .toList();
  //       return Right(bookings);
  //     } else {
  //       return Left(
  //         AppException(
  //           error: response.data["message"],
  //           statusCode: response.statusCode.toString(),
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(
  //       AppException(
  //         error: e.error.toString(),
  //         statusCode: e.response?.statusCode.toString() ?? '0',
  //       ),
  //     );
  //   }
  // }

  Future<Either<AppException, bool>> updateUserProfile(UserModel user) async {
    try {
      final token = await userSharedPrefs.getUserToken();

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response =
          await dio.put(ApiEndpoints.updateProfile, data: user.toJson());

      if (response.statusCode == 200) {
        return const Right(true); // Return true to indicate successful update
      } else {
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

  Future<Either<AppException, bool>> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      final token = await userSharedPrefs.getUserToken();

      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.put(ApiEndpoints.chnagePassword, data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'passwordConfirm': confirmPassword
      });

      if (response.statusCode == 200) {
        // Password change successful
        return const Right(true);
      } else {
        // Password change failed
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
