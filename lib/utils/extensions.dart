import 'package:flutter/material.dart';
import 'package:todo/ui/root.dart';

extension BuildContextExtension on BuildContext {
  Future<dynamic> go(String route, {Object? extra}) async {
    return await Navigator.pushNamed(this, route, arguments: extra);
  }

  Future<dynamic> replace(String route, {Object? extra}) async {
    return await Navigator.pushReplacementNamed(this, route, arguments: extra);
  }

  void goToRoot() {
    Navigator.pushNamedAndRemoveUntil(this, Root.route, (route) => false);
  }

  Size get size_ => MediaQuery.sizeOf(this);

  ThemeData get theme => Theme.of(this);

  ColorScheme get scheme => theme.colorScheme;

  TextTheme get style => theme.textTheme;

  void error(dynamic e) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          '$e',
          style: TextStyle(color: scheme.errorContainer),
        ),
        backgroundColor: scheme.onErrorContainer,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void message(dynamic e) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          '$e',
          style: TextStyle(color: scheme.primaryContainer),
        ),
        backgroundColor: scheme.onPrimaryContainer,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}


extension StringExtension on String {
  String? get crim => trim().isEmpty? null: trim(); 
}