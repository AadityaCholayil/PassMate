import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/routes/route_generator.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/theme/theme.dart';
import 'package:provider/provider.dart';

import 'bloc/database_bloc/database_barrel.dart';

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
              create: (context) {
                if (!kIsWeb) {
                  return DatabaseBloc(
                    userData: context.read<AuthenticationBloc>().userData,
                    databaseRepository: context.read<DatabaseRepository>(),
                    encryptionRepository: context.read<EncryptionRepository>(),
                  );
                } else {
                  return DatabaseBloc(
                    userData: context.read<AuthenticationBloc>().userData,
                    databaseRepository: context.read<AuthenticationBloc>().databaseRepository,
                    encryptionRepository: context.read<AuthenticationBloc>().encryptionRepository,
                  );
                }
              },
              child: ScreenUtilInit(
                designSize: Size(375, 812),
                builder: (){
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData.from(
                      textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
                      colorScheme: colorScheme,
                    ),
                    onGenerateRoute: RouteGenerator.generateRoute,
                    initialRoute: RoutesName.WRAPPER,
                    builder: (context, child){
                      int width = MediaQuery.of(context).size.width.toInt();
                      return MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor: width/375),
                          child: child??Container()
                      );
                    },
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}