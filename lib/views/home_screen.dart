import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/model/sort_methods.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/views/main_screen.dart';
import 'package:passmate/views/pages/folders_page.dart';
import 'package:passmate/views/pages/password_generator.dart';
import 'package:passmate/views/pages/passwords_page.dart';
import 'package:passmate/views/pages/payment_card_page.dart';
import 'package:passmate/views/pages/secure_notes_page.dart';
import 'package:passmate/views/settings/edit_profile_page.dart';
import 'package:passmate/views/settings/settings_page.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWrapper extends StatefulWidget {
  const DrawerWrapper({Key? key}) : super(key: key);

  @override
  _DrawerWrapperState createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> {
  final _zoomController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();
    print('homeScreenInit');
    SortMethod sortMethod =
        context.read<AppBloc>().userData.sortMethod ?? SortMethod.recentlyAdded;
    context.read<DatabaseBloc>().add(GetPasswords(sortMethod: sortMethod));
  }

  @override
  Widget build(BuildContext context) {
    print('homeScreenBuild');

    return ChangeNotifierProvider<MenuProvider>(
      create: (context) => MenuProvider(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: GestureDetector(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive
                print('Layout Changed');
                if (constraints.maxHeight < 1.5 * constraints.maxWidth) {
                  return const TempError(pageName: 'HomeScreen');
                }
                return Consumer<MenuProvider>(
                  builder: (context, menu, child) {
                    return ZoomDrawer(
                      // style: DrawerStyle.Style9,
                      controller: _zoomController,
                      angle: 0,
                      borderRadius: 45.w,
                      slideWidth: MediaQuery.of(context).size.width * .535,
                      menuScreen: const MenuScreen(),
                      mainScreen: <Widget>[
                        const PasswordPage(),
                        const PaymentCardPage(),
                        const SecureNotesPage(),
                        const PasswordGeneratorPage(),
                        const FolderPage(),
                        for (String path
                            in context.read<DatabaseBloc>().folderList ?? [])
                          FolderPage(path: path),
                      ][menu.currentPage],
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
                SortMethod sortMethod =
                    context.read<AppBloc>().userData.sortMethod ??
                        SortMethod.recentlyAdded;
                // switch (context.read<MenuProvider>().currentPage) {
                //   case 0:
                //     context
                //         .read<DatabaseBloc>()
                //         .add(GetPasswords(sortMethod: sortMethod));
                //     break;
                //   case 1:
                //     context
                //         .read<DatabaseBloc>()
                //         .add(GetPaymentCards(sortMethod: sortMethod));
                //     break;
                //   case 2:
                //     context
                //         .read<DatabaseBloc>()
                //         .add(GetSecureNotes(sortMethod: sortMethod));
                //     break;
                // }
                _zoomController.close!();
              }
            },
          ),
        );
      }),
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
    return Consumer<MenuProvider>(
      builder: (context, provider, child) {
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
                    const Spacer(),
                    const MenuItem(
                      index: 0,
                      text: 'Passwords',
                      icon: Icons.password_rounded,
                    ),
                    const MenuItem(
                      index: 1,
                      text: 'Payment Cards',
                      icon: Icons.credit_card_rounded,
                    ),
                    const MenuItem(
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
                    const MenuItem(
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
                    for (int index = 0;
                        index < (folderList.length > 3 ? 3 : folderList.length);
                        index++)
                      MenuItem(
                        index: index + 5,
                        text: folderList[index].split('/').last,
                        icon: Icons.folder_open_outlined,
                      ),
                    const Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: 20.w, left: 10.w, top: 35.w),
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
      },
    );
  }

  Widget _buildProfile(UserData userData, ColorScheme colorScheme) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserData userData = context.read<AppBloc>().userData;
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
                      await Future.delayed(const Duration(milliseconds: 200));
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfilePage()));
                      SortMethod sortMethod =
                          context.read<AppBloc>().userData.sortMethod ??
                              SortMethod.recentlyAdded;
                      switch (context.read<MenuProvider>().currentPage) {
                        case 0:
                          context
                              .read<DatabaseBloc>()
                              .add(GetPasswords(sortMethod: sortMethod));
                          break;
                        case 1:
                          context
                              .read<DatabaseBloc>()
                              .add(GetPaymentCards(sortMethod: sortMethod));
                          break;
                        case 2:
                          context
                              .read<DatabaseBloc>()
                              .add(GetSecureNotes(sortMethod: sortMethod));
                          break;
                      }
                      ZoomDrawer.of(context)!.close();
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
        SortMethod sortMethod = context.read<AppBloc>().userData.sortMethod ??
            SortMethod.recentlyAdded;
        switch (context.read<MenuProvider>().currentPage) {
          case 0:
            context
                .read<DatabaseBloc>()
                .add(GetPasswords(sortMethod: sortMethod));
            break;
          case 1:
            context
                .read<DatabaseBloc>()
                .add(GetPaymentCards(sortMethod: sortMethod));
            break;
          case 2:
            context
                .read<DatabaseBloc>()
                .add(GetSecureNotes(sortMethod: sortMethod));
            break;
        }
        ZoomDrawer.of(context)!.close();
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 27.w,
            color: selected ? colorScheme.secondaryContainer : Colors.white,
          ),
          SizedBox(
            width: 25.w,
          ),
          Text(
            text,
            style: TextStyle(
              color: selected ? colorScheme.secondaryContainer : Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
