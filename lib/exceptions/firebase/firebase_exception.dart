class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message => 'Firebase error: $code';
}
