import 'package:dartz/dartz.dart';
import 'package:flutter_library_managent/features/auth/presentation/providers/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repository/auth_remote_repository.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(
    ref.read(authRemoteRepositoryProvider),
  );
});

//
class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRemoteRepositoy _authRemoteRepositoy;
  AuthStateNotifier(this._authRemoteRepositoy)
      : super(AuthState(isLoggedIn: false, isLoading: false));

  Future<Either<AppException, bool>> login(
      String username, String password) async {
    // Update state to indicate loading
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Call login method of repository
     final result = await _authRemoteRepositoy.loginStudent(username, password);

    result.fold(
      (error) {
        // Update state with error message
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
      },
      (isLoggedIn) {
        // Update state with logged-in status
        state = state.copyWith(
          isLoggedIn: isLoggedIn,
          isLoading: false,
        );
      },
    );

    return result;
  }



  // make  the register method fro User model
  Future<Either<AppException, bool>> register(UserModel user) async {
    // Update state to indicate loading
    state = state.copyWith(isLoading: true, errorMessage: null);
    // Call logn method of repository
    final result = await _authRemoteRepositoy.registerStudent(user);
    result.fold(
      (error) {
        // Update state with error message
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
      },
      (isLoggedIn) {
        // Update state with logged-in status
        state = state.copyWith(
          isLoggedIn: isLoggedIn,
          isLoading: false,
        );
      },
    );

    return result;
  }

}
