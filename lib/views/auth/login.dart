import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/bloc/login_bloc/login_barrel.dart';
import 'package:passmate/model/auth_credentials.dart';
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
      child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state == LoginState.success) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushReplacementNamed(context, RoutesName.WRAPPER);
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, state.message));
        }
      }, builder: (context, state) {
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
                    SizedBox(height: 15,),
                    CustomTextFormField(
                      labelText: 'Email',
                      onSaved: (value) {
                        email = value ?? '';
                      },
                    ),
                    SizedBox(height: 15,),
                    CustomTextFormField(
                      labelText: 'Password',
                      onSaved: (value) {
                        password = value ?? '';
                      },
                    ),
                    ElevatedButton(
                      child: Text('submit'),
                      onPressed: () async {
                        _formKey.currentState?.save();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(showCustomSnackBar(context, state.message));
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginUsingCredentials(email: AuthEmail(email), password: AuthPassword(password)));
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
