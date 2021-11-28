import 'package:flutter/material.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/temp_error.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          // Responsive
          print('Layout Changed');
          if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
            // LandScape
            return const TempError(pageName: 'Welcome to PassMate');
          }
          return const WelcomeScreenPortrait();
        }),
      ),
    );
  }
}

class WelcomeScreenPortrait extends StatelessWidget {
  const WelcomeScreenPortrait({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 90.w),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Welcome to,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onBackground,
                height: 0.9,
              ),
            ),
          ),
          const Spacer(flex: 4,),
          SizedBox(
            height: 170.w,
            width: 170.w,
            child: Image.asset('assets/icon_without_bg.png'),
          ),
          Text(
            'PassMate',
            style: TextStyle(
              height: 1.25,
              fontSize: 49,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            'Your Password Manager',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Spacer(flex: 5,),
          CustomElevatedButton(
            style: 0,
            text: 'Login',
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.loginPage);
            },
          ),
          SizedBox(height: 25.w),
          CustomElevatedButton(
            style: 1,
            text: 'Sign Up',
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.signupPage);
            },
          ),
          SizedBox(height: 50.w),
        ],
      ),
    );
  }
}
