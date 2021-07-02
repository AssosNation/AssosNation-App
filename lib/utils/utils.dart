import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  static displaySnackBarWithMessage(
      BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }

  static isEmailValidated(String email) {
    return email
        .contains(new RegExp(r'([a-z0-9A-Z-.]+@[a-zA-Z]+\.[a-z]{1,3})'));
  }
}
