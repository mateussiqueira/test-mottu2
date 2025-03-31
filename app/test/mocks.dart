import 'package:flutter/services.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  SharedPreferences,
  MethodChannel,
  EventChannel,
])
void main() {}
