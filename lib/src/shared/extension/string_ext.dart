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
}
