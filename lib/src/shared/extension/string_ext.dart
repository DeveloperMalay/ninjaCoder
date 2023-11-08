extension StringDateFormat on String {
  String formatToCustomDate() {
    try {
      final dateTime = DateTime.parse(this);
      final formattedDate =
          '${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}';
      return formattedDate;
    } catch (e) {
      return this; // Return the original string if parsing fails
    }
  }

  String _getMonthName(int month) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  DateTime toDate() {
    final months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };

    final parts = split(' ');
    if (parts.length != 3) {
      throw const FormatException('Invalid date format');
    }

    final day = int.parse(parts[0]);
    final month = months[parts[1]];
    final year = int.parse(parts[2]);

    return DateTime(year, month ?? -1, day);
  }
}
