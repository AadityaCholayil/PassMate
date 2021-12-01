import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/temp_error.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({Key? key}) : super(key: key);

  @override
  _PasswordGeneratorPageState createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  String password = '';

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      // Responsive
      print('Layout Changed');
      if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
        // LandScape
        return const TempError(pageName: 'Settings Screen');
      }
      return _buildPasswordGeneratorPagePortrait(colors, context);
    });
  }

  Widget _buildPasswordGeneratorPagePortrait(
      ColorScheme colors, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40.w),
              Text(
                'Password Generator',
                style: TextStyle(
                  fontSize: 42,
                  height: 1.2.w,
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.w),
            ],
          ),
        ),
      ),
    );
  }
}
