import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/temp_error.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      // Responsive
      print('Layout Changed');
      if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
        // LandScape
        return const TempError(pageName: 'About us Page');
      }
      return _buildAboutUsPagePortrait(colors, context);
    });
  }

  Widget _buildAboutUsPagePortrait(ColorScheme colors, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 25.w),
                const CustomBackButton(),
                SizedBox(height: 20.w),
                Text(
                  'Hey there!',
                  style: TextStyle(
                    fontSize: 42,
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15.w),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 24,
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.w),
                _buildAnswer(colors,
                    'PassMate uses Military-Grade AES256 to encrypt your credentials. Even if you use Tianhe-2 (MilkyWay-2), the fastest supercomputer in the world, it will take millions of years to crack 256-bit AES encryption.'),
                SizedBox(height: 20.w),
                _buildQuestion(
                    colors, 'What is the significance of my Master Password?'),
                SizedBox(height: 8.w),
                _buildAnswer(colors,
                    'The key for the encryption is derived from your Master Password. SCRYPT and SHA256 is used for this. Hence, remembering your Master password and keeping it safe is extremely important.'),
                SizedBox(height: 20.w),
                _buildQuestion(
                    colors, 'What happens if I forget my Master Password?'),
                SizedBox(height: 8.w),
                _buildAnswer(colors,
                    'We DO NOT store your Master Password on our end. Hence, we CANNOT recover your account if you forget your master password. '),
                SizedBox(height: 20.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(ColorScheme colors, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        color: colors.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildAnswer(ColorScheme colors, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: colors.secondaryVariant,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
