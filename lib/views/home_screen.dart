// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/views/main_screen.dart';
import 'package:passmate/views/settings/edit_profile_page.dart';
import 'package:passmate/views/settings/settings_page.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _zoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuProvider>(
      create: (context) => MenuProvider(),
      child: SafeArea(
        child: GestureDetector(
          child: Builder(
            builder: (context) {
              return Consumer<MenuProvider>(
                builder: (context, provider, child) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // Responsive
                      print('Layout Changed');
                      if (constraints.maxHeight < 1.5 * constraints.maxWidth) {
                        return const TempError(pageName: 'HomeScreen');
                      }
                      return ZoomDrawer(
                        // style: DrawerStyle.Style9,
                        controller: _zoomController,
                        angle: 0,
                        borderRadius: 45.w,
                        slideWidth: MediaQuery.of(context).size.width * .535,
                        menuScreen: MenuScreen(),
                        mainScreen: MainScreen(),
                      );
                    },
                  );
                },
              );
            },
          ),
          onHorizontalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              _zoomController.open!();
            } else if (details.delta.dx < -sensitivity) {
              _zoomController.close!();
            }
          },
        ),
      ),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<String> folderList = [];

  @override
  Widget build(BuildContext context) {
    UserData userData = context.read<AppBloc>().userData;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<DatabaseBloc, DatabaseState>(
      listener: (context, state) {
        folderList = context.read<DatabaseBloc>().folderList ?? [];
      },
      builder: (context, state) {
        // if (state is Fetching) {
        //   return Container(
        //     color: colorScheme.primary,
        //   );
        // }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colorScheme.primary,
          body: Container(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfile(userData, colorScheme),
                Spacer(),
                MenuItem(
                  index: 0,
                  text: 'Passwords',
                  icon: Icons.password_rounded,
                ),
                MenuItem(
                  index: 1,
                  text: 'Payment Cards',
                  icon: Icons.credit_card_rounded,
                ),
                MenuItem(
                  index: 2,
                  text: 'Secure Notes',
                  icon: Icons.sticky_note_2_rounded,
                ),
                SizedBox(height: 20.w),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Tools',
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.secondary,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 5.w),
                MenuItem(
                  index: 3,
                  text: 'Password Generator',
                  icon: Icons.vpn_key_outlined,
                ),
                SizedBox(height: 15.w),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Folders',
                    style: TextStyle(
                      fontSize: 18,
                      color: colorScheme.secondary,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 5.w),
                const MenuItem(
                  index: 4,
                  text: 'All Folders',
                  icon: Icons.folder_open_outlined,
                ),
                for (int index = 0; index < (folderList.length>3?3:folderList.length); index++)
                  MenuItem(
                    index: index + 5,
                    text: folderList[index].split('/').last,
                    icon: Icons.folder_open_outlined,
                  ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.w, left: 10.w, top: 35.w),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: colorScheme.onPrimary,
                      size: 30.w,
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfile(UserData userData, ColorScheme colorScheme) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        userData = context.read<AppBloc>().userData;
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 5.w, left: 10.w),
          child: Row(
            children: [
              Container(
                height: 50.w,
                width: 50.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.3.w),
                    borderRadius: BorderRadius.circular(25.w)),
                padding: EdgeInsets.all(2.5.w),
                child: InkWell(
                  onTap: () async {
                    ZoomDrawer.of(context)!.toggle();
                    await Future.delayed(const Duration(milliseconds: 200));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfilePage()));
                  },
                  child: Container(
                    height: 46.w,
                    width: 46.w,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.w)),
                    child: Image.network(
                      userData.photoUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.w,
                  ),
                  Text(
                    '${userData.firstName} ${userData.lastName}',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, alignment: Alignment.topLeft),
                    child: Text(
                      'View profile',
                      style: TextStyle(
                        color: colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0.9.w,
                      ),
                    ),
                    onPressed: () async {
                      ZoomDrawer.of(context)!.toggle();
                      await Future.delayed(const Duration(milliseconds: 200));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfilePage()));
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String text;

  const MenuItem({Key? key, int? index, IconData? icon, String? text})
      : index = index ?? 0,
        icon = icon ?? Icons.add,
        text = text ?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool selected = context.read<MenuProvider>().currentPage == index;
    final colorScheme = Theme.of(context).colorScheme;
    return selected
        ? Container(
            width: 260.w,
            padding: EdgeInsets.only(left: 9.w),
            decoration: BoxDecoration(
              color: colorScheme.secondaryVariant.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15.w),
              // border: Border.all(
              //   width: 2.w,
              //   color: colorScheme.secondaryVariant,
              // ),
            ),
            child: _buildButton(context, selected),
          )
        : Padding(
            padding: EdgeInsets.only(left: 9.w),
            child: _buildButton(context, selected),
          );
  }

  TextButton _buildButton(BuildContext context, bool selected) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(5.w, 12.w, 10.w, 12.w),
      ),
      onPressed: () {
        context.read<MenuProvider>().updateCurrentPage(index);
        print(index);
        ZoomDrawer.of(context)!.close();
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 27.w,
            color: selected ? colorScheme.secondaryVariant : Colors.white,
          ),
          SizedBox(
            width: 25.w,
          ),
          Text(
            text,
            style: TextStyle(
              color: selected ? colorScheme.secondaryVariant : Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
