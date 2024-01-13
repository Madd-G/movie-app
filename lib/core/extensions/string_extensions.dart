extension DateFormatExtension on String {
  String get formatDate {
    List<String> parts = split('-');

    Map<String, String> monthMap = {
      '01': 'Jan',
      '02': 'Feb',
      '03': 'Mar',
      '04': 'Apr',
      '05': 'May',
      '06': 'Jun',
      '07': 'Jul',
      '08': 'Aug',
      '09': 'Sep',
      '10': 'Oct',
      '11': 'Nov',
      '12': 'Dec',
    };

    String month = monthMap[parts[1]] ?? '';

    return '$month ${int.parse(parts[2])}, ${parts[0]}';
  }
}
