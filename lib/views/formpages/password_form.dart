import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/loading.dart';

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
        body: BlocConsumer<DatabaseBloc, DatabaseState>(
          listener: (context, state){

          },
          builder: (context, state){
            if(state is PasswordFormState){
              if (state == PasswordFormState.success) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(showCustomSnackBar(context, state.message));
              }
          }
            return Container(
              child: Column(
                children: [
                  Text(
                    'Add Password',
                    style: TextStyle(
                        fontSize: 30
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      Password password = Password(
                          path: '/default',
                          siteName: 'Google',
                          siteUrl: 'www.google.com',
                          email: 'aaditya@xyz.com',
                          password: 'aadi123',
                          note: 'Bruh',
                          category: PasswordCategory.Entertainment,
                          favourite: false,
                          usage: 3
                      );
                      context.read<DatabaseBloc>().add(AddPassword(password));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
