import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/views/formpages/password_form.dart';
import 'package:passmate/views/formpages/payment_card_form.dart';
import 'package:passmate/views/formpages/secure_note_form.dart';
import 'package:passmate/views/pages/passwords_page.dart';
import 'package:passmate/views/pages/payment_card_page.dart';
import 'package:passmate/views/pages/secure_notes_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  late final String fName;

  Widget _buildButton({required IconData icon, void Function()? onPressed}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      padding: EdgeInsets.all(7.w),
      height: 62.w,
      width: 62.w,
      child: IconButton(
        icon: Icon(
          icon,
          size: 27.w,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fName = context.read<AuthenticationBloc>().userData.firstName??'';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        //TODO other events
        onRefresh: () async => context
            .read<DatabaseBloc>()
            .add(GetPasswords()),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              // bottom: PreferredSize(child: Container(color: Colors.red,), preferredSize: Size(100,40)),
              toolbarHeight: 65.w,
              elevation: 0,
              pinned: true,
              collapsedHeight: 65.w,
              backgroundColor: Colors.white,
              expandedHeight: 225.w,
              title: Container(
                height: 65.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 42.w,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.notes_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        ZoomDrawer.of(context)!.toggle();
                      },
                    ),
                    Spacer(),
                    IconButton(
                      iconSize: 36.w,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.settings_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        ZoomDrawer.of(context)!.toggle();
                      },
                    ),
                  ],
                ),
              ),
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: [StretchMode.zoomBackground],
                background: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.w, 100.w, 90.w, 42.w),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.onBackground,
                            height: 0.9,
                          ),
                        ),
                        Text(
                          '$fName',
                          style: TextStyle(
                            height: 1.25,
                            fontSize: 43,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, int) => Container(
                  color: Colors.white,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.w)),
                    ),
                    child: [
                      PasswordPage(),
                      PaymentCardPage(),
                      SecureNotesPage(),
                    ][context.read<MenuProvider>().currentPage],
                  ),
                ),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FabCircularMenu(
        key: fabKey,
        ringDiameter: 450.w,
        ringWidth: 130.w,
        fabSize: 65.w,
        fabOpenIcon: Icon(Icons.add, color: Colors.white, size: 42),
        fabCloseIcon: Icon(Icons.close, color: Colors.white, size: 37),
        ringColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        children: [
          _buildButton(
            icon: Icons.sticky_note_2_rounded,
            onPressed: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecureNoteForm()))
                  .then((value) => context
                      .read<DatabaseBloc>()
                      .add(GetPasswords()));
              fabKey.currentState!.close();
            },
          ),
          _buildButton(
            icon: Icons.credit_card_rounded,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentCardForm())).then((value) =>
                  context
                      .read<DatabaseBloc>()
                      .add(GetPasswords()));
              fabKey.currentState!.close();
            },
          ),
          _buildButton(
            icon: Icons.password_rounded,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordFormPage())).then((value) =>
                  context
                      .read<DatabaseBloc>()
                      .add(GetPasswords()));
              fabKey.currentState!.close();
            },
          )
        ],
      ),
    );
  }
}
