import 'package:flutter/material.dart';
import 'package:passmate/views/auth/details_page.dart';
import 'package:passmate/views/auth/login/login_page.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/views/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _GeneratePageRoute(
            widget: const Wrapper(), routeName: settings.name);
      case RoutesName.loginPage:
        return _GeneratePageRoute(
            widget: const LoginPage(), routeName: settings.name);
      case RoutesName.signupPage:
        return _GeneratePageRoute(
            widget: const DetailsPage(), routeName: settings.name);
      default:
        return _GeneratePageRoute(
            widget: const Wrapper(), routeName: '/');
    }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;

  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              textDirection: TextDirection.rtl,
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
