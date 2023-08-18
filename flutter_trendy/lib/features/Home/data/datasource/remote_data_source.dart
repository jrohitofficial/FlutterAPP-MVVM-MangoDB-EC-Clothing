// make remote data source for home

// make remote data source for home

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_library_managent/core/network/remote/http_service.dart';
import 'package:flutter_library_managent/core/shared_prefs/user_shared_prefs.dart';
import 'package:flutter_library_managent/features/Home/data/model/cart.dart';

import 'package:flutter_library_managent/features/Home/data/response/productResponse.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../model/cart_response.dart';
import '../model/orderModel.dart';

final productRemoteDataSourceProvider = Provider(
  (ref) => HomeRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class HomeRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  HomeRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  // future for get all books List<Book>

  // future for get all books List<Book> function

  Future<Either<AppException, ProductResponse>> getBooks(
      String searchQuery) async {
    ProductResponse? productResponse;
    Box box;
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('test');
    try {
      Response response =
          await dio.get(ApiEndpoints.getBooks, queryParameters: {
        'keyword': searchQuery,
      });

      if (response.statusCode == 200) {
        final books = ProductResponse.fromJson(response.data);
        box.put('books', jsonEncode(books));

        return Right(books);
      } else {
        return Left(
          AppException(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      print("print from hive.........");
      var stored = box.get("books");

      var encoded = jsonDecode(stored);

      productResponse = ProductResponse.fromJson(encoded);

      return Right(productResponse);
    }
  }

  // add to cart function
  Future<Either<AppException, bool>> addToCart(Cart cart) async {
    try {
      final token = await userSharedPrefs.getUserToken();

      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.post(
        ApiEndpoints.addToCart,
        data: cart.toJson(),
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

  // create order function

  Future<Either<AppException, bool>> createOrder(OrderModel order) async {
    try {
      final token = await userSharedPrefs.getUserToken();

      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.post(
        ApiEndpoints.createOrder,
        data: order.toJson(),
      );

      if (response.statusCode == 200) {
        // Order creation successful
        return const Right(true);
      } else {
        // Order creation failed
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

  Future<Either<AppException, CartResponse>> getCartForUser() async {
    try {
      final token = await userSharedPrefs.getUserToken();

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.get(ApiEndpoints.getusercart);

      if (response.statusCode == 200) {
        final cart = CartResponse.fromJson(response.data);
        return Right(cart);
      } else {
        return Left(
          AppException(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      String errorMessage = 'Request failed';

      if (e.response != null && e.response!.data != null) {
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic> &&
            errorData.containsKey('error')) {
          errorMessage = errorData['error'].toString();
        }
      }

      return Left(
        AppException(
          error: errorMessage,
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
