class AuthState {
  final bool ? isLoggedIn;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
     this.isLoggedIn,
    required this.isLoading,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
