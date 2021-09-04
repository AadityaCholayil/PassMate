import 'package:flutter/material.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(height: 40.w,),
              CustomElevatedButton(
                style: 0,
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.LOGIN_PAGE);
                },
              ),
              SizedBox(height: 25.w,),
              CustomElevatedButton(
                style: 1,
                text: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.SIGNUP_PAGE);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
