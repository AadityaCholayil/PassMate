import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:passmate/theme/theme.dart';

import '../details_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String stateMessage = '';
  bool showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OldAppBloc, OldAppState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) async {
        if (state is LoginPageState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, state.message));
        }
        if (state is Authenticated) {
          stateMessage = 'Success!';
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          print('Navigating..');
          await Future.delayed(const Duration(milliseconds: 600));
          Navigator.popUntil(context, ModalRoute.withName(RoutesName.wrapper));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive
                print('Layout Changed');
                if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                  // LandScape
                  return const TempError(pageName: 'Login Screen');
                }
                return _buildLoginPortrait(context);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginPortrait(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25.w),
              const CustomBackButton(),
              SizedBox(height: 90.h),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to,',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: CustomTheme.primary,
                        height: 0.9,
                      ),
                    ),
                    Text(
                      'PassMate',
                      style: TextStyle(
                        height: 1.25,
                        fontSize: 43.5,
                        fontWeight: FontWeight.bold,
                        color: CustomTheme.primary,
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Text(
                      'Login to continue',
                      style: TextStyle(
                        height: 1.25.w,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: CustomTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              CustomShadow(
                child: TextFormField(
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
                    if (!AuthEmail(value).isValid) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.w),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomShadow(
                    child: TextFormField(
                      decoration: customInputDecoration(
                          context: context, labelText: 'Password'),
                      style: formTextStyle(context),
                      obscureText: !showPassword,
                      onSaved: (value) {
                        password = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 15.w),
                    height: 60.w,
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 25.w),
                    ),
                  ),
                ],
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
                  BlocProvider.of<OldAppBloc>(context)
                      .add(LoginUser(email: email, password: password));
                },
              ),
              SizedBox(height: 150.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 15, color: CustomTheme.t1),
                  ),
                  TextButton(
                    child: Text(
                      "Sign Up!",
                      style:
                          TextStyle(fontSize: 15, color: CustomTheme.primary),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const DetailsPage()));
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
