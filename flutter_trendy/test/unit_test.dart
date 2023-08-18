import 'package:dio/dio.dart';
import 'package:flutter_library_managent/core/failure/failure.dart';
import 'package:flutter_library_managent/core/shared_prefs/user_shared_prefs.dart';
import 'package:flutter_library_managent/features/Home/data/datasource/remote_data_source.dart';
import 'package:flutter_library_managent/features/auth/data/datasource/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_library_managent/features/auth/data/model/user_model.dart';

void main() {
  group('Auth Remote Data Source tests', () {
    late AuthRemoteDataSource dataSource;
    late HomeRemoteDataSource dataSource2;
    late Dio dio;
    late UserSharedPrefs userSharedPrefs;

    setUp(() {
      dio = Dio();
      userSharedPrefs = UserSharedPrefs();
      dataSource = AuthRemoteDataSource(
        dio: dio,
        userSharedPrefs: userSharedPrefs,
      );
      dataSource2 = HomeRemoteDataSource(
        dio: dio,
        userSharedPrefs: userSharedPrefs,
      );
    });

    test('loginStudent returns a Right bool if successful', () async {
      String username = 'test123@gmail.com';
      String password = 'test123456@';
      Either<AppException, bool> result =
          await dataSource.loginStudent(username, password);
      expect(result.isRight(), false);
    });

    test('loginStudent returns a Left AppException if unsuccessful', () async {
      Either<AppException, bool> result =
          await dataSource.loginStudent('invalid', 'password');

      expect(result.isLeft(), true);
      expect(result.fold((left) => left, (right) => null), isA<AppException>());
    });

    test('registerStudent returns a Right bool if successful', () async {
      UserModel user = UserModel(
        email: 'mailto:testregisterr@gmail.com',
        password: 'test1234',
        name: 'Test Register',
      );
      Either<AppException, bool> result =
          await dataSource.registerStudent(user);

      expect(result.isRight(), false);
    });

    test('registerStudent returns a Left AppException if unsuccessful',
        () async {
      UserModel user = UserModel(
        email: '',
        password: 'password',
        name: 'name',
      );
      Either<AppException, bool> result =
          await dataSource.registerStudent(user);

      expect(result.isLeft(), true);
      expect(result.fold((left) => left, (right) => null), isA<AppException>());
    });

    // test('addComment returns a Right bool if successful', () async {
    //   CommentModel comment = CommentModel(
    //     Comment: "Test Comment",
    //     productId: "Test Product Id",
    //     rating: 5,
    //   );
    //   Either<AppException, bool> result = await dataSource2.addComment(comment);

    //   expect(result.isRight(), false);
    //   // expect(result.fold((left) => null, (right) => right), true);
    // });

    // test('addComment returns a Left AppException if unsuccessful', () async {
    //   CommentModel comment = CommentModel(
    //     Comment: "Test Comment",
    //     productId: "Test Product Id",
    //     rating: 5,
    //   );
    //   Either<AppException, bool> result = await dataSource2.addComment(comment);

    //   expect(result.isLeft(), true);
    //   expect(result.fold((left) => left, (right) => null), isA<AppException>());
    // });
  });
}
