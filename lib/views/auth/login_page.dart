import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/bloc/login_bloc/login_barrel.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';

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
      create: (context) => LoginBloc(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state == LoginState.success) {
            await compute(EncryptionRepository.scryptHash, password).then((value) {
              context.read<AuthenticationBloc>().encryptionRepository.updateKey(value);
              if (!kIsWeb) {
                final storage = FlutterSecureStorage();
                storage.write(key: 'key', value: value);
              }
              print('Navigating..');
              context.read<AuthenticationBloc>().add(AuthenticateUser());
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.pushReplacementNamed(context, RoutesName.WRAPPER);
            });
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(showCustomSnackBar(context, state.message));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login'),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        labelText: 'Email',
                        onSaved: (value) {
                          email = value ?? '';
                        },
                        validator: (value) {
                          if(value==null || value.isEmpty){
                            return 'Please enter your email';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        labelText: 'Password',
                        onSaved: (value) {
                          password = value ?? '';
                        },
                        validator: (value) {
                          if(value==null || value.isEmpty){
                            return 'Please enter your password';
                          }
                        },
                      ),
                      ElevatedButton(
                        child: Text('submit'),
                        onPressed: () async {
                          if(!_formKey.currentState!.validate()){
                            return;
                          }
                          _formKey.currentState?.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                              showCustomSnackBar(context, state.message));
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginUsingCredentials(
                                  email: AuthEmail(email),
                                  password: AuthPassword(password)));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
      }),
    );
  }
}
