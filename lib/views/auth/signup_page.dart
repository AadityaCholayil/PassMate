import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/views/auth/login_page.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  final File? image;
  final String firstName;
  final String lastName;
  final String email;

  const SignUpPage(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthPassword password = AuthPassword('');
  PasswordStrength passwordStrength = PasswordStrength.fromPassword('');
  String stateMessage = '';
  bool showPassword = false;
  bool showConfirmPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is SignupPageState) {
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
            body: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive
                print('Layout Changed');
                if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                  // LandScape
                  return const TempError(pageName: 'SignUp Screen');
                }
                return _buildSignUpPortrait(context);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignUpPortrait(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Set Master Password',
                  style: TextStyle(
                    height: 1.25,
                    fontSize: 43.5,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 10.w),
                Text(
                  'The only password you’ll have to remember',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                ),
                SizedBox(height: 15.w),
                Stack(
                  children: [
                    TextFormField(
                      decoration: customInputDecoration(
                          context: context, labelText: 'Master Password'),
                      style: formTextStyle(context),
                      obscureText: !showPassword,
                      onChanged: (value) {
                        setState(() {
                          password.password = value;
                          passwordStrength = password.passwordStrength;
                          print(passwordStrength.list);
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10.w),
                      height: 56.w,
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 28.w),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                _buildPasswordStrength(),
                passwordStrength.list.isEmpty
                    ? Stack(
                      children: [
                        TextFormField(
                            decoration: customInputDecoration(
                                context: context, labelText: 'Confirm Password'),
                            style: formTextStyle(context),
                            obscureText: !showConfirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required!';
                              }
                              if (value != password.password) {
                                return 'Passwords do not match!';
                              }
                            },
                          ),
                        Container(
                          padding: EdgeInsets.only(right: 10.w),
                          height: 56.w,
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                                showConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 28.w),
                            onPressed: () {
                              setState(() {
                                showConfirmPassword = !showConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
                SizedBox(height: 20.w),
                CustomElevatedButton(
                  text: 'Sign Up',
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    if (passwordStrength.strength < 5) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          showCustomSnackBar(
                              context, "Password isn't strong enough!"));
                      return;
                    }
                    _formKey.currentState?.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                        showCustomSnackBar(context, stateMessage));
                    BlocProvider.of<AppBloc>(context).add(SignupUser(
                      email: widget.email,
                      password: password.password,
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      image: widget.image,
                    ));
                  },
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                TextButton(
                  child: Text(
                    "Log in!",
                    style: TextStyle(
                        fontSize: 15,
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

  List<Color> colorArr = [
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreenAccent[700]!,
    Colors.green,
  ];

  List<String> strengthText = [
    'Very weak',
    'Very weak',
    'Very weak',
    'Weak',
    'Moderate',
    'Strong',
    'Very Strong',
  ];

  Widget _buildPasswordStrength() {
    int strength = passwordStrength.strength;
    return Padding(
      padding: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10.w,
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    color: colorArr[strength],
                  ),
                  height: 8.w,
                ),
              ),
              for (int i = 2; i < 6; i++)
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      color:
                          strength > i ? colorArr[strength] : Colors.grey[300],
                    ),
                    height: 8.w,
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.w, top: 2.w),
            child: Text(
              strengthText[strength],
              style: TextStyle(
                fontSize: 15,
                color: colorArr[strength],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListView.builder(
            padding: passwordStrength.list.isEmpty
                ? EdgeInsets.only(top: 9.w)
                : EdgeInsets.only(top: 7.w, bottom: 10.w),
            shrinkWrap: true,
            itemCount: passwordStrength.list.length,
            itemBuilder: (context, index) {
              String text = passwordStrength.list[index];
              return Row(
                children: [
                  Icon(
                    Icons.close,
                    size: 17.w,
                    color: Theme.of(context).errorColor,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 1.w, 1.w, 1.w),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
