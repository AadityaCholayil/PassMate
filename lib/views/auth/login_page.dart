import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/auth/signup_page.dart';
import 'package:passmate/views/pages/temp_error.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String stateMessage = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) async {
        if (state is LoginNewState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, state.message));
        }
        if (state is Authenticated) {
          stateMessage = 'Success!';
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          print('Navigating..');
          Navigator.popUntil(context, ModalRoute.withName(RoutesName.wrapper));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(builder: (context, constraints) {
              // Responsive
              print('Layout Changed');
              if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                // LandScape
                return const TempError(pageName: 'Login Screen');
              }
              return _buildLoginPortrait(context);
            }),
          ),
        );
      },
    );
  }

  Container _buildLoginPortrait(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            const CustomBackButton(),
            SizedBox(height: 50.h),
            Text(
              'Welcome to,',
              style: TextStyle(
                fontSize: 32.5,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
                height: 0.9,
              ),
            ),
            Text(
              'PassMate',
              style: TextStyle(
                height: 1.25,
                fontSize: 43.5,
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
              decoration:
                  customInputDecoration(context: context, labelText: 'Email'),
              style: formTextStyle(context),
              onSaved: (value) {
                email = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!AuthEmail(value).isValid) {
                  return 'Invalid email format';
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(showCustomSnackBar(context, stateMessage));
                BlocProvider.of<AppBloc>(context)
                    .add(LoginUser(email: email, password: password));
              },
            ),
            SizedBox(height: 80.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                TextButton(
                  child: Text(
                    "Sign Up!",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
