import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/routes/route_generator.dart';
import 'package:passmate/theme/theme.dart';
import 'package:passmate/views/wrapper.dart';
import 'bloc/database_bloc/database_barrel.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepository(),
      child: BlocProvider<AppBloc>(
        create: (context) {
          AppBloc appBloc = AppBloc(
              authRepository:
              context.read<AuthRepository>());
          appBloc.add(AppStarted());
          return appBloc;
        },
        child: Builder(
          builder: (context) {
            return BlocBuilder<AppBloc, AppState>(
              builder: (context, state) => BlocProvider<DatabaseBloc>.value(
                value: context.read<AppBloc>().databaseBloc,
                child: ScreenUtilInit(
                  designSize: const Size(414, 896),
                  builder: () {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData.from(
                        textTheme: Theme.of(context)
                            .textTheme
                            .apply(fontFamily: 'Poppins'),
                        colorScheme: colorScheme,
                      ),
                      onGenerateRoute: (settings) {
                        return RouteGenerator.generateRoute(settings, state);
                      },
                      // initialRoute: RoutesName.wrapper,
                      home: Wrapper(
                        state: state,
                      ),
                      builder: (context, child) {
                        int height = MediaQuery.of(context).size.height.toInt();
                        int width = MediaQuery.of(context).size.width.toInt();
                        int factor = 0;
                        ScreenUtil.setContext(context);
                        if(height < 1.2*width){
                          factor = height;
                        } else {
                          factor = width;
                        }
                        return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: factor / 414),
                            child: child ?? Container());
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

