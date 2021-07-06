
import 'package:flutter/material.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome Screen'),
              ElevatedButton(
                child: Text('login'),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.LOGIN_PAGE);
                },
              ),
              ElevatedButton(
                child: Text('signup'),
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.SIGNUP_PAGE);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
