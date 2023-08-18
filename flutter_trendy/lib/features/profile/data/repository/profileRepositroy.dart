import 'package:dartz/dartz.dart';

import 'package:flutter_library_managent/features/profile/data/datasource/remote_data_source.dart';

import 'package:flutter_library_managent/features/profile/data/model/profileResponse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../auth/data/model/user_model.dart';
import '../model/OrderResponse.dart';

final profileRemoteRepositoryProvider = Provider<ProfileRemoteRepositoy>((ref) {
  return ProfileRemoteRepositoy(
    ref.read(profileRemoteDataSourceProvider),
  );
});

class ProfileRemoteRepositoy {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRemoteRepositoy(this._profileRemoteDataSource);

  Future<Either<AppException, ProfileResponse>> getProfile() {
    return _profileRemoteDataSource.getUserProfile();
  }

  Future<Either<AppException, List<OrderResponse>>> getUserOrder() {
    return _profileRemoteDataSource.getUserOrder();
  }

  Future<Either<AppException, bool>> updateProfile(UserModel user) {
    return _profileRemoteDataSource.updateUserProfile(user);
  }

 

  Future<Either<AppException, bool>> changePassword(
      String oldPassword, String newPassword, String confirmPassword) {
    return _profileRemoteDataSource.changePassword(
        oldPassword, newPassword, confirmPassword);
  }




}
