import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    print(context.read<EncryptionRepository>().key);
    String email = BlocProvider.of<AuthenticationBloc>(context).state.userData.email??'popat ho gaya';
    context.read<DatabaseRepository>().completeUserData.then((value) => print(value));

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HomePage\n$email',
                style: TextStyle(
                  fontSize: 25
                ),
              ),
              ElevatedButton(
                child: Text('Logout'),
                onPressed: (){
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  // Navigator.pushReplacementNamed(context, RoutesName.WRAPPER);
                },
              ),
              ElevatedButton(
                child: Text('Change Password'),
                onPressed: (){
                  // Navigator.pushReplacementNamed(context, RoutesName.WRAPPER);
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}
