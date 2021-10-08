import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/bloc/signup_bloc/signup_barrel.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/views/auth/login_page.dart';
import 'package:passmate/views/pages/temp_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(
          authenticationRepository: context.read<AuthRepository>()),
      child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) async {
        if (state == SignupState.success) {
          /// Compute Password Hash
          await compute(EncryptionRepository.scryptHash, password.password)
              .then((value) {
            /// Update Key in Encryption Repository
            context
                .read<AppBloc>()
                .encryptionRepository
                .updateKey(value);

            /// Storing password hash on Android
            if (!kIsWeb) {
              const storage = FlutterSecureStorage();
              storage.write(key: 'key', value: value);
            }

            /// Start Authentication
            context.read<AppBloc>().add(AuthenticateUser());
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            print('Navigating..');
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.wrapper));
          });
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, state.message));
        }
      }, builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(
              builder: (context, constraints) {
                /// Responsive
                print('Layout Changed');
                if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                  ///LandScape
                  return const TempError(pageName: 'SignUp Screen');
                }
                return _buildSignUpPortrait(context, state);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSignUpPortrait(BuildContext context, SignupState state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            const CustomBackButton(),
            SizedBox(height: 15.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(height: 1.w,),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(
                    height: 25.w,
                  ),
                  TextFormField(
                    decoration: customInputDecoration(
                        context: context, labelText: 'Email'),
                    style: formTextStyle(context),
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
                    height: 15.w,
                  ),
                  TextFormField(
                    decoration: customInputDecoration(
                        context: context, labelText: 'Master Password'),
                    style: formTextStyle(context),
                    onChanged: (value) {
                      setState(() {
                        password.password = value;
                        passwordStrength = password.passwordStrength;
                        print(passwordStrength.list);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required!';
                      }
                    },
                  ),
                  _buildPasswordStrength(),
                  TextFormField(
                    decoration: customInputDecoration(
                        context: context, labelText: 'Confirm Password'),
                    style: formTextStyle(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required!';
                      }
                      if (value != password.password) {
                        return 'Passwords do not match!';
                      }
                    },
                  ),
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
                          showCustomSnackBar(context, state.message));
                      BlocProvider.of<SignupBloc>(context).add(
                          SignupUsingCredentials(
                              email: email, password: password));
                    },
                  ),
                  // SizedBox(height: password.password != '' ? 20.h : 80.h),
                  Expanded(
                    flex: 3,
                    child: Row(
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: password.password != '' ? 30.h : 20.h,
                  // ),
                ],
              ),
            )
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
                : EdgeInsets.only(top: 9.w, bottom: 9.w),
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
