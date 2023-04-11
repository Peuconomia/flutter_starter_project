abstract class TimeParser {
  static String parseDuration({required Duration duration}) {
    final int hours = duration.inHours % 24;
    final int minutes = duration.inMinutes % 60;

    String message = '--:--';

    if (duration.inSeconds == 0) {
      return message;
    } else {
      message = '$hours:${minutes.toString().padLeft(2, '0')} hrs.';
    }

    return message;
  }
}
