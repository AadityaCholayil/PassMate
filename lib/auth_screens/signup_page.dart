import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/authentication_repository/authentication_repository.dart';
import 'package:passmate/bloc/signup_bloc/signup_barrel.dart';
import 'package:passmate/model/credentials.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Email email = Email('');
  Password password = Password('');
  PasswordStrength passwordStrength = PasswordStrength.fromPassword('');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPasswordStrength(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: passwordStrength.list.length,
            itemBuilder: (context, index){
              String text = passwordStrength.list[index];
              return Text(text);
            },
          ),
          Text('strength = ${passwordStrength.strength}')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state == SignupState.success) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pushReplacementNamed(context, RoutesName.WRAPPER);
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
                      Text('Sign Up'),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        labelText: 'Email',
                        onSaved: (value) {
                          email.email = value ?? '';
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        labelText: 'Password',
                        onChanged: (value) {
                          setState(() {
                            password.password = value ?? '';
                            passwordStrength = password.passwordStrength;
                          });
                        },
                      ),
                      _buildPasswordStrength(),
                      ElevatedButton(
                        child: Text('submit'),
                        onPressed: passwordStrength.strength<5?null:() async {
                          _formKey.currentState?.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                              showCustomSnackBar(context, state.message));
                          BlocProvider.of<SignupBloc>(context).add(
                              SignupUsingCredentials(
                                  email: email,
                                  password: password));
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
