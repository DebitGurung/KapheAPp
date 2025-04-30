class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials.Please double check information';
      case 'too-many-request':
        return 'Too many request. Please try again later';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'The provided phone number is not a valid phone number.';
      case 'operation-not-allowed':
        return 'The sign in provider is disabled for your firebase project';
      case 'session-cookie-expired':
        return 'The firebase session cookie has expired.';

      case 'uid-already-exists':
        return 'The provided user id already exists';
      case 'sign-in-failed':
        return 'Sign in failed. Please try again later';
      case 'internal-error':
        return 'Internal error. Please try again later';

      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification id. Please enter a valid code.';

      case 'network-error':
        return 'Network connection failed.';

      case 'permission-denied':
        return 'Permission denied.';
      case 'service-disabled':
        return 'Service disabled.';
      default:
        return 'An unexpected platform error occurred.';
    }
  }
}
