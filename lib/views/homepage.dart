import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/views/formpages/password_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context
        .read<DatabaseBloc>()
        .add(GetPasswords(PasswordCategory.Entertainment));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabaseState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is PasswordList) {
            state.list.forEach((element) {
              print(element);
            });
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HomePage',
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(LoggedOut());
                },
              ),
              ElevatedButton(
                child: Text('Bruh'),
                onPressed: () {

                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PasswordFormPage()));
          },
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
