import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/shared/custom_snackbar.dart';

class PasswordFormPage extends StatefulWidget {
  const PasswordFormPage({Key? key}) : super(key: key);

  @override
  _PasswordFormPageState createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {
  String imageUrl = 'https://api.faviconkit.com/google.com/144';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<DatabaseBloc, DatabaseState>(
          listener: (context, state) {
            if (state is PasswordFormState) {
              if (state == PasswordFormState.success) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(showCustomSnackBar(context, state.message));
              }
            }
          },
          builder: (context, state) {
            return Container(
              child: Column(
                children: [
                  Text(
                    'Add Password',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Password password = Password(
                        path: '/default',
                        siteName: 'Google',
                        siteUrl: 'www.google.com',
                        email: 'aaditya@xyz.com',
                        password: 'aadi123',
                        imageUrl: 'https://api.faviconkit.com/www.google.com/144',
                        note: 'Bruh',
                        category: PasswordCategory.Entertainment,
                        favourite: false,
                        usage: 3,
                        lastUsed: Timestamp.now(),
                        timeAdded: Timestamp.now(),
                      );
                      context.read<DatabaseBloc>().add(AddPassword(password));
                    },
                  ),
                  // Image.network(
                  //   imageUrl
                  // ),
                  // ElevatedButton(
                  //   child: Text(
                  //     'Test API',
                  //     style: TextStyle(
                  //         fontSize: 20
                  //     ),
                  //   ),
                  //   onPressed: () async {
                  //     setState(() {
                  //       imageUrl = 'https://api.faviconkit.com/www.github.com/144';
                  //     });
                  //   }
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
