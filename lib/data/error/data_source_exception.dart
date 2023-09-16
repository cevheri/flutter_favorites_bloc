class DataSourceException implements Exception {
  final String message;
  final String code;

  DataSourceException({
    required this.message,
    required this.code,
  }) : super();
}
