
import 'package:dartz/dartz.dart';
import 'package:flutter_library_managent/features/auth/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';

import '../datasource/remote_data_source.dart';

final authRemoteRepositoryProvider = Provider<AuthRemoteRepositoy>((ref) {
  return AuthRemoteRepositoy(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepositoy {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRemoteRepositoy(this._authRemoteDataSource);

  Future<Either<AppException, bool>> loginStudent(String username, String password) {
    return _authRemoteDataSource.loginStudent(username, password);
  }

  Future<Either<AppException, bool>> registerStudent(UserModel user) {
    return _authRemoteDataSource.registerStudent(user);
  }

}
