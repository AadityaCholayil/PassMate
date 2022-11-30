import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc_new/app_bloc.dart';
import 'package:passmate/views/auth/welcome_screen.dart';
import 'package:passmate/views/drawer_wrapper.dart';
import 'package:passmate/shared/loading.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return state.when(
          uninitialised: () => const Loading(),
          unauthenticated: () => const WelcomeScreen(),
          authenticated: (user) => const DrawerWrapper(),
          partiallyWebAuthenticated: (user) => const Loading(),
          errorOccurred: () => const Loading(),
        );
      },
    );
    // if (state is Uninitialized) {
    //   return const LoadingPage();
    // } else if (state is Unauthenticated ||
    //     state is LoginPageState ||
    //     state is SignupPageState ||
    //     state is EmailInputPageState) {
    //   return const WelcomeScreen();
    // } else if (state is Authenticated ||
    //     state is DeleteAccountPageState ||
    //     state is EditProfilePageState) {
    //   return const DrawerWrapper();
    // } else {
    //   return const LoadingPage();
    // }
  }
}
