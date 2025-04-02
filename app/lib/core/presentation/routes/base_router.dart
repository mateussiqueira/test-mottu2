import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'i_router.dart';

abstract class BaseRouter implements IRouter {
  @override
  List<GetPage> get routes;

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    final route = routes.firstWhere(
      (route) => route.name == settings.name,
      orElse: () => GetPage(
        name: settings.name ?? '',
        page: () => _buildNotFoundPage(settings.name ?? ''),
      ),
    );

    return GetPageRoute(
      page: route.page,
      settings: settings,
    );
  }

  Widget _buildNotFoundPage(String routeName) {
    return Scaffold(
      body: Center(
        child: Text('Route $routeName not found'),
      ),
    );
  }
}
