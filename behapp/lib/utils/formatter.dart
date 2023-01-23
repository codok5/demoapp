import 'package:intl/intl.dart';

final DateFormat format = DateFormat('yyyy-MM-dd');
final DateFormat formatw = DateFormat.EEEE('ko_KR');
final DateFormat formatint = DateFormat('yyyyMMdd');

int formatdatetoint(String date) {
  return int.parse(date);
}
