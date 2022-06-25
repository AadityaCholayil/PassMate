import 'package:flutter/material.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:passmate/theme/theme.dart';
import 'dart:ui' as ui;

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
              color: CustomTheme.t1,
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
          Column(
            children: [
              CustomPaint(
                size: Size(414.w, 21.w),
                painter: BGTopVector(),
              ),
              Container(
                color: CustomTheme.secondaryVariant,
                child: SizedBox(height: 35.w),
              ),
            ],
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

class BGTopVector extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height * 0.9972667);
    path0.cubicTo(size.width * 0.1457734, size.height * 0.3644471,
        size.width * 0.3169251, 0, size.width * 0.5000000, 0);
    path0.cubicTo(size.width * 0.6830749, 0, size.width * 0.8542271,
        size.height * 0.3644476, size.width, size.height * 0.9972667);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, size.height * 0.9972667);
    path0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffF8CEF1).withOpacity(1.0);
    canvas.drawPath(path0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
