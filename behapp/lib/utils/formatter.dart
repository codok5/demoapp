import 'package:intl/intl.dart';

final DateFormat format = DateFormat('yyyy-MM-dd');
final DateFormat formatw = DateFormat.EEEE('ko_KR');
final DateFormat formatint = DateFormat('yyyyMMdd');

int formatdatetoint(String date) {
  return int.parse(date);
}

String inttominute(int sec) {
  int m, s;

  m = sec ~/ 60;

  s = sec - (m * 60);

  return "${m.toString().padLeft(2, '0')}분:${s.toString().padLeft(2, '0')}초";
}
