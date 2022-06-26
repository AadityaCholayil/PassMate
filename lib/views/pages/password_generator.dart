import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:passmate/shared/custom_animated_app_bar.dart';
import 'package:passmate/views/settings/settings_page.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({Key? key}) : super(key: key);

  @override
  _PasswordGeneratorPageState createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  String password = '';
  int length = 16;
  bool includeUpper = true;
  bool includeLower = true;
  bool includeSpecial = true;
  bool includeNumbers = true;

  @override
  void initState() {
    super.initState();
    password = EncryptionRepository.generateCryptoRandomString(length: length);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      // Responsive
      print('Layout Changed');
      if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
        // LandScape
        return const TempError(pageName: 'Password Generator Screen');
      }
      return _buildPasswordGeneratorPagePortrait(colors, context);
    });
  }

  Widget _buildPasswordGeneratorPagePortrait(
      ColorScheme colors, BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.w),
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
                      buildHeader('Generated Password'),
                      SizedBox(height: 5.w),
                      Text(
                        password,
                        style: TextStyle(
                          color: colors.onBackground,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20.w),
                      buildHeader('Length'),
                      Slider(
                        value: length.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            if (value >= 8) {
                              length = value.round();
                              password = EncryptionRepository
                                  .generateCryptoRandomString(length: length);
                            }
                          });
                        },
                        min: 0,
                        max: 28,
                        divisions: 28,
                        label: '$length',
                      ),
                      // SizedBox(height: 5.w),
                      Text(
                        'Password Length: $length',
                        style: TextStyle(
                          color: colors.onBackground,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20.w),
                      // buildHeader('Optional Parameters'),
                      // Text(
                      //   'Password Length: $length',
                      //   style: TextStyle(
                      //     color: colors.onBackground,
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      SizedBox(height: 100.w),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.w, 95.w, 20.w),
              child: CustomElevatedButton(
                text: 'Copy to Clipboard',
                fontSize: 18,
                onPressed: () {
                  // setState(() {
                  //   password = EncryptionRepository.generateCryptoRandomString(
                  //       length: length);
                  // });
                  Clipboard.setData(ClipboardData(text: password));
                  print(password);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: const CustomFAB(),
      ),
    );
  }

  Widget buildHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondaryVariant,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Padding _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Row(
        children: [
          IconButton(
            iconSize: 38.w,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notes_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 38.w,
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
          const Spacer(),
          IconButton(
            iconSize: 34.w,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.settings_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}
