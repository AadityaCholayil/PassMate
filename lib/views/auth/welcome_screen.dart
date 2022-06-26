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
      color: CustomTheme.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 70),
          Container(
            padding: EdgeInsets.only(left: 24.w),
            alignment: Alignment.topLeft,
            child: Text(
              'Welcome to,',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: CustomTheme.primary,
              ),
            ),
          ),
          const Spacer(flex: 16),
          Expanded(
            flex: 110,
            child: Image.asset('assets/icon_without_bg.png'),
          ),
          Text(
            'PassMate',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: CustomTheme.primary,
            ),
          ),
          Text(
            'Your Password Manager',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: CustomTheme.t1,
              height: 0.9.w,
            ),
          ),
          const Spacer(flex: 10),
          Container(
            decoration: BoxDecoration(
              color: CustomTheme.secondary,
              borderRadius: BorderRadius.circular(3.w),
            ),
            height: 3.w,
            width: 80.w,
          ),
          const Spacer(flex: 10),
          Text(
            'One password to \nremember them all',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: CustomTheme.primary,
              height: 1.1.w,
            ),
          ),
          const Spacer(flex: 25),
          CustomPaint(
            size: Size(414.w, 21.w),
            painter: BGTopVector1(),
          ),
          Expanded(
            flex: 172,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10.w),
                  color: CustomTheme.background,
                  child: Image.asset(
                    'assets/welcome_page_vector.png',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Positioned(
                  bottom: -1.w,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: CustomPaint(
                      size: Size(414.w, 21.w),
                      painter: BGTopVector2(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 240,
            child: Container(
              color: CustomTheme.secondaryVariant,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(flex: 35),
                  CustomElevatedButton(
                    style: 0,
                    text: 'Login',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.loginPage);
                    },
                  ),
                  const Spacer(flex: 24),
                  CustomElevatedButton(
                    style: 1,
                    text: 'Sign Up',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.signupPage);
                    },
                  ),
                  const Spacer(flex: 66),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BGTopVector1 extends CustomPainter {
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
    paint0Fill.color = CustomTheme.background;
    canvas.drawPath(path0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BGTopVector2 extends CustomPainter {
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
    paint0Fill.color = CustomTheme.secondaryVariant;
    canvas.drawPath(path0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
