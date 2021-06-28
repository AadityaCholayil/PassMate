import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/auth_screens/login.dart';
import 'package:passmate/auth_screens/signup_page.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = BlocProvider.of<AuthenticationBloc>(context).state.userData.isEmpty;
    print(isEmpty);
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome Screen'),
              ElevatedButton(
                child: Text('login'),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage())
                  );
                },
              ),
              ElevatedButton(
                child: Text('signup'),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage())
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
