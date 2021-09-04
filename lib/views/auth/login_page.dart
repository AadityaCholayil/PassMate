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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            await compute(EncryptionRepository.scryptHash, password)
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
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h),
                      CustomBackButton(),
                      SizedBox(height: 50.h),
                      Text(
                        'Welcome to,',
                        style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.onBackground,
                          height: 0.9,
                        ),
                      ),
                      Text(
                        'PassMate',
                        style: TextStyle(
                          height: 1.25,
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Text(
                        'Login to continue',
                        style: TextStyle(
                          height: 1.25.w,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      TextFormField(
                        decoration: customInputDecoration(
                            context: context, labelText: 'Email'),
                        style: formTextStyle(context),
                        onSaved: (value) {
                          email = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                        },
                      ),
                      SizedBox(height: 20.w),
                      TextFormField(
                        decoration: customInputDecoration(
                            context: context, labelText: 'Password'),
                        style: formTextStyle(context),
                        onSaved: (value) {
                          password = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                        },
                      ),
                      SizedBox(height: 25.w),
                      CustomElevatedButton(
                        text: 'Login',
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
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
                      SizedBox(height: 80.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Sign Up!",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary
                              ),
                            ),
                            onPressed: (){

                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
