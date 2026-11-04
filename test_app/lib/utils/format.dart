
class AppFormat {
  static String date(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final day = dt.day;
    final month = months[dt.month - 1];
    final hours = dt.hour.toString().padLeft(2, '0');
    final minutes = dt.minute.toString().padLeft(2, '0');
    return '$day $month, $hours:$minutes';
  }

  static String duration(Duration d) {
    final hours = d.inHours;
    final mins = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${d.inMinutes}m';
  }
}