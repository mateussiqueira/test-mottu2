import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IRouter {
  List<GetPage> get routes;
  Route<dynamic> generateRoute(RouteSettings settings);
}
