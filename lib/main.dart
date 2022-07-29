import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc_observer.dart';
import 'package:passmate/firebase_options.dart';
import 'package:passmate/my_app.dart';
import 'package:passmate/shared/error_screen.dart';
import 'package:passmate/shared/loading.dart';
import 'package:url_strategy/url_strategy.dart';

// import 'dart:html' as html;

void main() async {
  // html.window.onBeforeUnload.listen((event) async{
  //   print('u sure bruv?');
  // });
  setPathUrlStrategy();
  Bloc.transformer = sequential<dynamic>();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlutterFireInit());
}

class FlutterFireInit extends StatefulWidget {
  const FlutterFireInit({Key? key}) : super(key: key);

  @override
  _FlutterFireInitState createState() => _FlutterFireInitState();
}

class _FlutterFireInitState extends State<FlutterFireInit> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(home: SomethingWentWrong());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const LoadingPage();
      },
    );
  }
}
