import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/repositories/database_repository.dart';

class PasswordFormPage extends StatefulWidget {
  const PasswordFormPage({Key? key}) : super(key: key);

  @override
  _PasswordFormPageState createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ElevatedButton(
            child: Text(
              'Add Password',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            onPressed: (){
              Password password = Password(
                  path: 'work',
                  siteName: 'Google',
                  siteUrl: 'www.google.com',
                  email: 'aaditya@xyz.com',
                  password: 'aadi123',
                  note: 'Bruh',
                  category: PasswordCategory.Entertainment,
                  favourite: false,
                  usage: 3
              );

              context.read<AuthenticationBloc>().databaseRepository.addPassword(password);
            },
          ),
        ),
      ),
    );
  }
}
