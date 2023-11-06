class LocationUtils {
  static String getType(String type) {
    switch (type) {
      case 'unknown':
        return 'unknown';
      case '':
        return 'not_specified';

      default:
        String tag = type.toLowerCase().splitMapJoin(
              ' ',
              onMatch: (m) => '_',
              onNonMatch: (n) => n,
            );

        return tag.replaceAll('-', '_').replaceAll(RegExp(r'[()]'), '');
    }
  }

  static String dimensionValue(String value) {
    if (value.isEmpty) return 'not_specified';
    if (value == 'unknown') return 'unknown';

    return value;
  }
}
