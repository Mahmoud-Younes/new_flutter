import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String timePassed(DateTime datetime, {bool full = false}) {
  DateTime ago = datetime;
  Duration dur = now.difference(ago);
  int days = dur.inDays;
  int years = days ~/ 365;
  int months = (days - (years * 365)) ~/ 30;
  int weeks = (days - (years * 365 + months * 30)) ~/ 7;
  int rdays = days - (years * 365 + months * 30 + weeks * 7).toInt();
  int hours = (dur.inHours % 24).toInt();
  int minutes = (dur.inMinutes % 60).toInt();
  int seconds = (dur.inSeconds % 60).toInt();
  var diff = {
    "d": rdays,
    "w": weeks,
    "m": months,
    "y": years,
    "s": seconds,
    "i": minutes,
    "h": hours
  };

  Map str = {
    'y': 'year',
    'm': 'month',
    'w': 'week',
    'd': 'day',
    'h': 'hour',
    'i': 'minute',
    's': 'second',
  };

  str.forEach((k, v) {
    if (diff[k]! > 0) {
      str[k] = '${diff[k]} $v${diff[k]! > 1 ? 's' : ''}';
    } else {
      str[k] = "";
    }
  });
  str.removeWhere((index, ele) => ele == "");
  List<String> tlist = [];
  str.forEach((k, v) {
    tlist.add(v);
  });
  if (full) {
    return str.isNotEmpty ? "${tlist.join(", ")} ago" : "Just Now";
  } else {
    return str.isNotEmpty ? "${tlist[0]} ago" : "Just Now";
  }
}

/*

String timeago1 = timePassed(DateTime.parse("2023-02-26 23:01:50"));
print(timeago1); //2 years ago

String timeago3 = timePassed(DateTime.now());
print(timeago3); //Just Now

print("======================================================");
  var formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    print(formattedDat);

*/

List weekDays = [];
List fullDate = [];

getWeekDays() {
  for (int i = 0; i < 7; i++) {
    weekDays.add(DateFormat('dd').format(now.add(Duration(days: i))));
    weekDays.add(DateFormat('E').format(now.add(Duration(days: i))));
    fullDate
        .add(DateFormat('dd - MM - yyyy').format(now.add(Duration(days: i))));
  }
}
