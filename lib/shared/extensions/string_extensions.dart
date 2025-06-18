extension StringExtensions on String {
  /// Capitalizes the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalizes each word in the string
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Checks if the string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Checks if the string is a valid phone number (International format)
  bool get isValidPhoneNumber {
    return RegExp(r'^(\+62|62|0)[0-9]{9,13}$').hasMatch(this);
  }

  /// Removes HTML tags from the string
  String removeHtmlTags() {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// Truncates the string to a specific length and adds ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Converts the string to a slug (URL-friendly format)
  String toSlug() {
    return toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  /// Masks the string for privacy (e.g., email, phone)
  String mask({int start = 2, int end = 2, String maskChar = '*'}) {
    if (length <= start + end) return this;
    final masked = maskChar * (length - start - end);
    return '${substring(0, start)}$masked${substring(length - end)}';
  }

  /// Converts string to initials (e.g., "John Doe" -> "JD")
  String toInitials({int maxLength = 2}) {
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';

    final initials = words
        .take(maxLength)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();

    return initials;
  }

  /// Formats a price string with currency
  String formatPrice({String currency = '\$'}) {
    final number = int.tryParse(replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return '$currency${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  /// Validates if the string is a strong password
  bool get isStrongPassword {
    return length >= 8 &&
        contains(RegExp(r'[A-Z]')) &&
        contains(RegExp(r'[a-z]')) &&
        contains(RegExp(r'[0-9]')) &&
        contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  /// Converts the string to a color based on its hash
  int toColorHash() {
    int hash = 0;
    for (int i = 0; i < length; i++) {
      hash = codeUnitAt(i) + ((hash << 5) - hash);
    }
    return hash;
  }
}

extension NullableStringExtensions on String? {
  /// Returns true if the string is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if the string is not null and not empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns the string or a default value if null
  String orDefault([String defaultValue = '']) => this ?? defaultValue;

  /// Returns the string or 'N/A' if null or empty
  String get orNA => isNullOrEmpty ? 'N/A' : this!;
}
