import 'package:flutter/material.dart';
import 'package:passmate/views/auth/additional_details.dart';
import 'package:passmate/views/auth/welcome_screen.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/views/home_screen.dart';
import 'package:passmate/shared/loading.dart';

class Wrapper extends StatelessWidget {
  final AppState state;

  const Wrapper({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is Uninitialized) {
      return const Loading();
    } else if (state is Unauthenticated) {
      return const WelcomeScreen();
    } else if (state is PartiallyAuthenticated) {
      return const AdditionalDetailsPage();
    } else if (state is FullyAuthenticated) {
      return const HomeScreen();
    } else {
      return const Loading();
    }
  }
}
