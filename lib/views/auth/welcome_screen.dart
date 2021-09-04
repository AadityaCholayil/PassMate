import 'package:flutter/material.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 55.w,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.LOGIN_PAGE);
              },
            ),
            SizedBox(height: 25.w,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 55.w,
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.SIGNUP_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
