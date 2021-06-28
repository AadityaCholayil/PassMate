import 'package:flutter/material.dart';
import 'package:passmate/auth_screens/login.dart';
import 'package:passmate/auth_screens/welcome_screen.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/routes/routes_name.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case '/':
        return _GeneratePageRoute(
            widget: WelcomeScreen(), routeName: settings.name
        );
      case RoutesName.WELCOME_SCREEN:
        return _GeneratePageRoute(
            widget: WelcomeScreen(), routeName: settings.name
        );
      case RoutesName.LOGIN_PAGE:
        return _GeneratePageRoute(
            widget: LoginPage(), routeName: settings.name
        );
      case RoutesName.WELCOME_SCREEN:
        return _GeneratePageRoute(
            widget: WelcomeScreen(), routeName: settings.name
        );
      case RoutesName.WELCOME_SCREEN:
        return _GeneratePageRoute(
            widget: WelcomeScreen(), routeName: settings.name
        );
      case RoutesName.WELCOME_SCREEN:
        return _GeneratePageRoute(
            widget: WelcomeScreen(), routeName: settings.name
        );
      default:
        return _GeneratePageRoute(
            widget: WelcomeScreen(), routeName: settings.name
        );
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
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return SlideTransition(
          textDirection: TextDirection.rtl,
          position: Tween<Offset>(
            begin: Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      });
}
