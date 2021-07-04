import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/views/auth/additional_details.dart';
import 'package:passmate/views/auth/welcome_screen.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/views/homepage.dart';
import 'package:passmate/shared/loading.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous!=current,
      builder: (context, state){
        if(state is Uninitialized){
          return Loading();
        } else if (state is Unauthenticated) {
          return WelcomeScreen();
        } else if (state is PartiallyAuthenticated) {
          return AdditionalDetailsPage();
        } else if (state is FullyAuthenticated){
          return RepositoryProvider<DatabaseRepository>.value(
            // create: (context) => DatabaseRepository(uid: state.userData.uid),
            value: context.read<AuthenticationBloc>().databaseRepository,
            child: BlocProvider<DatabaseBloc>(
              create: (context) => DatabaseBloc(
                  userData: state.userData,
                  databaseRepository: context.read<DatabaseRepository>()),
              child: HomePage(),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
