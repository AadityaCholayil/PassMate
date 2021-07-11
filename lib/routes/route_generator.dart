import 'package:flutter/material.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/views/auth/login_page.dart';
import 'package:passmate/views/auth/signup_page.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/views/wrapper.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings, AuthenticationState state) {
    switch(settings.name){
      case '/':
        return _GeneratePageRoute(
            widget: Wrapper(state: state), routeName: settings.name
        );
      case RoutesName.LOGIN_PAGE:
        return _GeneratePageRoute(
            widget: LoginPage(), routeName: settings.name
        );
      case RoutesName.SIGNUP_PAGE:
        return _GeneratePageRoute(
            widget: SignUpPage(), routeName: settings.name
        );
      default:
        return _GeneratePageRoute(
            widget: Wrapper(state: state), routeName: '/'
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
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return SlideTransition(
          textDirection: TextDirection.rtl,
          position: Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      });
}
