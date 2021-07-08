import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/app_bloc_observer.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/routes/route_generator.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:provider/provider.dart';

import 'bloc/database_bloc/database_barrel.dart';
// import 'dart:html' as html;

void main() async {
  // html.window.onBeforeUnload.listen((event) async{
  //   print('u sure bruv?');
  // });
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationRepository>(
      create: (context) => AuthenticationRepository(),
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          AuthenticationBloc authenticationBloc = AuthenticationBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>());
          authenticationBloc.add(AppStarted());
          return authenticationBloc;
        },
        child: Builder(builder: (context) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<EncryptionRepository>.value(
                value: context.read<AuthenticationBloc>().encryptionRepository,
              ),
              RepositoryProvider<DatabaseRepository>.value(
                value: context.read<AuthenticationBloc>().databaseRepository,
              ),
            ],
            child: BlocProvider<DatabaseBloc>(
              create: (context) => DatabaseBloc(
                  userData: context.read<AuthenticationBloc>().userData,
                  databaseRepository: context.read<DatabaseRepository>(),
                  encryptionRepository: context.read<EncryptionRepository>()),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.from(
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  ),
                  colorScheme: ColorScheme.fromSwatch(
                    brightness: Brightness.light,
                    primarySwatch: Colors.purple,
                  ),
                ),
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: RoutesName.WRAPPER,
              ),
            ),
          );
        }),
      ),
    );
  }
}
