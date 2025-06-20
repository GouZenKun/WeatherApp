class ForDisplayException implements Exception {
  final dynamic message;

  ForDisplayException(this.message);

  @override
  String toString() {
    return "$message";
  }
}
