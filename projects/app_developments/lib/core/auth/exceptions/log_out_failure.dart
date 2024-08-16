// Exception class for handling logout failures
class LogOutFailure implements Exception{
  final String? message;

  const LogOutFailure([
    this.message = 'An unknown exception occurred.',
  ]);

}