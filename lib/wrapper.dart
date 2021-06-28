import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/auth_screens/welcome_screen.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/homepage.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/loading.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state){
        print('bruh');
        if(state is Uninitialized){
          // Navigator.pushNamed(context, RoutesName.LOGIN_PAGE);
          return Loading();
        } else if (state is Unauthenticated) {
          return WelcomeScreen();
        } else if (state is Authenticated){
          print('home jaa');
          return HomePage();
        } else {
          return Loading();
        }
      },
    );
  }
}
