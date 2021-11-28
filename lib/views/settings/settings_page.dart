import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/views/settings/delete_account_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/settings/edit_profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25.w),
              const CustomBackButton(),
              SizedBox(height: 25.w),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 42,
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.w),
              _buildCategoryHead(colors, 'Security', Icons.security_outlined),
              SizedBox(height: 7.w),
              _buildTile(
                colors,
                label: 'Read more',
                onTap: () {},
              ),
              SizedBox(height: 20.w),
              _buildCategoryHead(
                  colors, 'Account', Icons.account_circle_outlined),
              SizedBox(height: 7.w),
              _buildTile(
                colors,
                label: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()));
                },
              ),
              _buildTile(
                colors,
                label: 'Delete Account',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeleteAccountPage()));
                },
              ),
              _buildTile(
                colors,
                label: 'Sign out',
                onTap: () {
                  context.read<AppBloc>().add(LoggedOut());
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20.w),
              _buildCategoryHead(colors, 'About', Icons.info_outline),
              SizedBox(height: 7.w),
              _buildTile(colors, label: 'More About Us', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCategoryHead(ColorScheme colors, String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20.w, color: colors.secondaryVariant),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: colors.secondaryVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  ListTile _buildTile(ColorScheme colors,
      {String label = '', void Function()? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: colors.onBackground),
      ),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 28.w, color: colors.primary),
      onTap: onTap,
    );
  }
}
