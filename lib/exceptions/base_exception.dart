class BaseException implements Exception {
  final String message;
  final int? statusCode;
  final DateTime timeStamp;

  BaseException({
    required this.message, 
    this.statusCode,
  }) : timeStamp = DateTime.now();

  @override
  String toString() => '[$timeStamp] BaseException: $message (Status: $statusCode)';
}