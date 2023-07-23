import 'package:flutter/material.dart';
import 'package:todo/ui/auth/register_page.dart';
import 'package:todo/ui/root.dart';

class Routes {
  static Route<dynamic> on(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return switch(settings.name) {
          RegisterPage.route => const RegisterPage(),
          _ => const Root(),
        };
      },
    );
  }
}
