abstract class DateDifferenceCalculator {
  static String fromPastDate({required DateTime dateTime}) {
    final duration = DateTime.now().difference(dateTime);

    int days = duration.inDays;
    int hours = duration.inHours;
    int minutes = duration.inMinutes;

    if (days > 1) {
      return '$days days ago';
    } else if (days == 1) {
      return '1 day ago';
    } else if (hours > 1 && hours % 5 != 0) {
      return '$hours hours ago';
    } else if (hours > 1 && hours % 5 == 0) {
      return '$hours hour ago';
    } else if (hours == 1) {
      return '1 hour ago';
    } else if (minutes > 1 && minutes % 5 != 0) {
      return '$minutes minutes ago';
    } else if (minutes >= 1 || minutes % 5 == 0 && minutes != 0) {
      return '$minutes minute ago';
    } else {
      return 'Just now';
    }
  }

  static String durationCalculator({
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) {
    String message = '';

    final difference = endDateTime.difference(startDateTime);

    final int minutes = difference.inMinutes % 60;
    final int hours = difference.inHours % 24;

    if (hours > 0) {
      message = "$hours hours";
    }

    if (minutes > 0) {
      if (message.isNotEmpty) {
        message = "$message $minutes minutes";
      } else {
        message = '$minutes minutes';
      }
    }

    return message;
  }
}
