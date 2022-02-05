import 'package:flutter/material.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:passmate/theme/theme.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 70.w),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Welcome to,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: CustomTheme.primary,
                height: 0.9,
              ),
            ),
          ),
          const Spacer(
            flex: 4,
          ),
          SizedBox(
            height: 200.w,
            width: 200.w,
            child: Image.asset('assets/icon_without_bg.png'),
          ),
          Text(
            'PassMate',
            style: TextStyle(
              height: 1.25,
              fontSize: 53,
              fontWeight: FontWeight.bold,
              color: CustomTheme.primary,
            ),
          ),
          Text(
            'Your Password Manager',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: CustomTheme.onSurface,
            ),
          ),
          SizedBox(height: 20.w),
          Container(
            decoration: BoxDecoration(
              color: CustomTheme.secondaryVariant,
              borderRadius: BorderRadius.circular(3.w),
            ),
            height: 5.w,
            width: 100.w,
          ),
          SizedBox(height: 26.w),
          Text(
            'One password to \nremember them all',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: CustomTheme.primary,
            ),
          ),
          const Spacer(
            flex: 5,
          ),
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
