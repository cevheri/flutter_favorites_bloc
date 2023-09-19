
/// Exception thrown when handle the business logic exception in the data layer
/// 
/// [RepositoryException] extends [Exception]
/// 
/// ```dart
/// throw BusinessException(message: "An error occurred while getting favorites", code: "favorite_get_error");
/// ```
class RepositoryException implements Exception {
  final String message;
  final String code;

  RepositoryException({
    required this.message,
    required this.code,
  }) : super();
}
