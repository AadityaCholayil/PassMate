import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/authentication_repository/authentication_repository.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/login_bloc/login_barrel.dart';
import 'package:passmate/model/credentials.dart';
import 'package:passmate/routes/routes_name.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = '';
  String password = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state){
          if(state.message == 'Successful'){
            Navigator.pushReplacementNamed(context, RoutesName.WRAPPER);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login'),
                      TextFormField(
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                        onSaved: (value){
                          email = value??'';
                        },
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                        onSaved: (value){
                          password = value??'';
                        },
                      ),
                      ElevatedButton(
                        child: Text('submit'),
                        onPressed: () async {
                          _formKey.currentState?.save();
                          Credentials credentials = Credentials(email: email, password: password);
                          BlocProvider.of<LoginBloc>(context).add(LoginUsingCredentials(credentials: credentials));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

