import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/authentication_repository/authentication_repository.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SignUp'),
              ElevatedButton(
                child: Text('submit'),
                onPressed: (){
                  AuthenticationRepository().signUp('aadi1@xyz.com', 'aadi123');
                  BlocProvider.of<AuthenticationBloc>(context).add(AuthenticateUser());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
