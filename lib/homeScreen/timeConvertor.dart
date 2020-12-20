import 'package:intl/intl.dart';

String timeConvertor(millisecond, DateTime time) {
  var second = millisecond / 1000;
  String toReturn;
  var minute = second / 60;
  var hour = minute / 60;
  var day = hour / 24;
  var week = day / 7;
  DateTime today = DateTime.now();
  DateTime givenDay = time;
  Duration dateDiff = today.difference(givenDay);
  print(day.round());
  int dayDiff = givenDay.day - today.day;
  int monthDiff = givenDay.month - today.month;
  int yearDiff = givenDay.year - today.year;
  print(hour.round());
  if (dayDiff == 0 && monthDiff == 0 && yearDiff == 0) {
    toReturn = 'Today - ${amPmConvertor(time.toString().substring(11, 16))}';
  } else if (hour.round() >= 24) {
    toReturn =
        '${DateFormat.yMMMd().format(time)} - ${amPmConvertor(time.toString().substring(11, 16))}';
  } else {
    toReturn =
        'Yesterday - ${amPmConvertor(time.toString().substring(11, 16))}';
  }

  return toReturn;
}

String amPmConvertor(String railyWayTime) {
  int hour = int.parse(railyWayTime.substring(0, 2));
  print(hour);
  String toReturn;
  if (hour >= 12) {
    if (hour == 12) {
      toReturn = '$hour${railyWayTime.substring(2, 5)} pm';
    } else {
      toReturn = '${hour - 12}${railyWayTime.substring(2, 5)} pm';
    }
  } else if (hour == 0) {
    toReturn = '${hour + 12}${railyWayTime.substring(2, 5)} am';
  } else {
    toReturn = '$railyWayTime am';
  }
  return toReturn;
}
