import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc_observer.dart';
import 'package:passmate/my_app.dart';

// import 'dart:html' as html;

void main() async {
  // html.window.onBeforeUnload.listen((event) async{
  //   print('u sure bruv?');
  // });
  Bloc.transformer = sequential<dynamic>();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


