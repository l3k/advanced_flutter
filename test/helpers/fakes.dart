import 'dart:math';

int anyInt([int max = 999999999]) => Random().nextInt(max);
String anyString() => anyInt().toString();
bool anyBool() => Random().nextBool();
DateTime anyDate() => DateTime.fromMillisecondsSinceEpoch(anyInt());
String anyIsoDate() => anyDate().toIso8601String();
