class AppException  {
  final String error;
  final String? statusCode;

  AppException({
    required this.error,
    this.statusCode,
  });
}
