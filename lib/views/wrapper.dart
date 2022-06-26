import 'package:flutter/material.dart';
import 'package:passmate/views/auth/welcome_screen.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/views/drawer_wrapper.dart';
import 'package:passmate/shared/loading.dart';

class Wrapper extends StatelessWidget {
  final AppState state;

  const Wrapper({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is Uninitialized) {
      return const LoadingPage();
    } else if (state is Unauthenticated ||
        state is LoginPageState ||
        state is SignupPageState ||
        state is EmailInputPageState) {
      return const WelcomeScreen();
    } else if (state is Authenticated ||
        state is DeleteAccountPageState ||
        state is EditProfilePageState) {
      return const DrawerWrapper();
    } else {
      return const LoadingPage();
    }
  }
}
