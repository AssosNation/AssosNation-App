import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static String getDiffTimeBetweenNowAndTimestamp(Timestamp _timestamp) {
    final DateTime currentTime = Timestamp.now().toDate();
    final Duration difference = currentTime.difference(_timestamp.toDate());

    if (difference.inMinutes < 60)
      return "${difference.inMinutes} min";
    else if (difference.inHours < 24)
      return "${difference.inHours}h";
    else
      return "${difference.inDays} days";
  }
}
