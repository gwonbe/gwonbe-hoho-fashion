import 'package:flutter/foundation.dart';

class DateTimeProvider with ChangeNotifier {

  String tag = "[date_time_provider.dart]";
  late DateTime now;

  DateTimeProvider() {
    now = DateTime.now();
    if (kDebugMode) {
      print("$tag _ ${now.toString()}");
    }
  }

}
