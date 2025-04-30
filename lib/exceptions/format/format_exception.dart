class TFormatException implements Exception {
  final String message;

  const TFormatException(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  String get formattedMessage => message;

  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const TFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-date-format':
        return const TFormatException(
            'Date format is invalid. Please use YYYY-MM-DD format.');
      case 'invalid-phone-number-format':
        return const TFormatException(
            'Phone number format is invalid. Please include country code.');
      case 'invalid-url-format':
        return const TFormatException(
            'URL format is invalid. Please include http:// or https:// prefix.');
      case 'invalid-username-format':
        return const TFormatException(
            'Username must only contain letters, numbers, underscores, or periods.');
      case 'missing-required-whitespace':
        return const TFormatException(
            'Input must contain proper whitespace formatting.');
      case 'empty-input':
        return const TFormatException('Required field cannot be empty.');
      case 'invalid-numeric-format':
        return const TFormatException('Input must be a valid numeric value.');
      // case 'invalid-credit-card-format':
      //   return const TFormatException('Credit card number format is invalid.');
      // case 'invalid-password-format':
      //   return const TFormatException(
      //       'Password must contain at least 8 characters with mix of letters, numbers, and symbols.');
      // case 'invalid-postal-code-format':
      //   return const TFormatException(
      //       'Postal code format is invalid for this region.');
      // case 'invalid-currency-format':
      //   return const TFormatException(
      //       'Currency format is invalid. Please include valid currency symbol and amount.');
      // case 'invalid-percentage-format':
      //   return const TFormatException(
      //       'Percentage must be between 0-100 with optional percentage symbol.');
      // case 'invalid-social-security-format':
      //   return const TFormatException(
      //       'Social security number format is invalid.');
      // case 'invalid-html-tag-format':
      //   return const TFormatException('HTML tag format is invalid.');
      // case 'invalid-hex-color-format':
      //   return const TFormatException(
      //       'Hex color code must start with # followed by 3 or 6 hexadecimal digits.');
      default:
        return const TFormatException();
    }
  }
}
