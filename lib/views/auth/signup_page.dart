import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/bloc/signup_bloc/signup_barrel.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthEmail email = AuthEmail('');
  AuthPassword password = AuthPassword('');
  PasswordStrength passwordStrength = PasswordStrength.fromPassword('');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPasswordStrength() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: passwordStrength.list.length,
            itemBuilder: (context, index) {
              String text = passwordStrength.list[index];
              return Text(
                text,
                style: TextStyle(fontSize: 15),
              );
            },
          ),
          Text(
            'strength = ${passwordStrength.strength}',
            style: TextStyle(fontSize: 15),
          )
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
          listener: (context, state) async {
        if (state == SignupState.success) {
          await compute(EncryptionRepository.scryptHash, password.password)
              .then((value) {
            context
                .read<AuthenticationBloc>()
                .encryptionRepository
                .updateKey(value);
            if (!kIsWeb) {
              final storage = FlutterSecureStorage();
              storage.write(key: 'key', value: value);
            }
            context.read<AuthenticationBloc>().add(AuthenticateUser());
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            print('Navigating..');
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.WRAPPER));
          });
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, state.message));
        }
      }, builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          height: 1.25,
                          fontSize: 43,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        labelText: 'Email',
                        onSaved: (value) {
                          email.email = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
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
                      Center(
                        child: ElevatedButton(
                          child: Text('submit'),
                          onPressed: (passwordStrength.strength < 5)
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  _formKey.currentState?.save();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      showCustomSnackBar(context, state.message));
                                  BlocProvider.of<SignupBloc>(context).add(
                                      SignupUsingCredentials(
                                          email: email, password: password));
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
