import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/auth/login_page.dart';
import 'package:passmate/views/auth/signup_page.dart';
import 'package:passmate/shared/temp_error.dart';

class EmailInputPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final File? image;

  const EmailInputPage(
      {required this.firstName, required this.lastName, required this.image, Key? key})
      : super(key: key);

  @override
  _EmailInputPageState createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<EmailInputPage> {
  AuthEmail email = AuthEmail('');
  EmailStatus emailStatus = EmailStatus.invalid;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is EmailInputPageState) {
            emailStatus = state.emailStatus;
            print(emailStatus);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: LayoutBuilder(builder: (context, constraints) {
                /// Responsive
                print('Layout Changed');
                if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                  /// LandScape
                  return const TempError(pageName: 'Additional Details Screen');
                }
                return _buildAdditionalDetailsPortrait(context);
              }),
            ),
          );
        });
  }

  Container _buildAdditionalDetailsPortrait(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25.w),
            const CustomBackButton(),
            SizedBox(height: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an Account',
                  style: TextStyle(
                    height: 1.25,
                    fontSize: 43.5,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 15.w),
                Text(
                  'Enter your email',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                ),
                SizedBox(height: 20.w),
                Stack(
                  children: [
                    TextFormField(
                      decoration: emailStatus == EmailStatus.valid
                          ? customInputDecoration(
                              context: context, labelText: 'Email').copyWith(
                        enabledBorder: greenBorder,
                        focusedBorder: greenBorder,
                      )
                          : customInputDecoration(
                              context: context, labelText: 'Email'),
                      style: formTextStyle(context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!AuthEmail(value).isValid) {
                          return 'Invalid email format';
                        }
                        if (emailStatus == EmailStatus.invalid) {
                          return 'This email is already taken!';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          email.email = value;
                        });
                        if (value.isNotEmpty && AuthEmail(value).isValid) {
                          context
                              .read<AppBloc>()
                              .add(CheckEmailStatus(email: value));
                        } else {
                          setState(() {
                            emailStatus = EmailStatus.invalid;
                          });
                        }
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 15.w),
                      height: 55.w,
                      alignment: Alignment.centerRight,
                      child: emailStatus == EmailStatus.loading
                          ? const CircularProgressIndicator()
                          : emailStatus == EmailStatus.valid
                              ? Icon(
                                  Icons.check,
                                  size: 30.w,
                                  color: Colors.green,
                                )
                              : Icon(Icons.close,
                                  size: 30.w,
                                  color: email.email == ''
                                      ? Colors.transparent
                                      : Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 30.w),
                CustomElevatedButton(
                  text: 'Next',
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState?.save();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPage(
                                  firstName: widget.firstName,
                                  lastName: widget.lastName,
                                  image: widget.image,
                                  email: email.email,
                                )));
                  },
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                TextButton(
                  child: Text(
                    "Login!",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => const LoginPage()), ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
            SizedBox(height: 15.w),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder greenBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green,
      width: 2.w,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
  );
}
