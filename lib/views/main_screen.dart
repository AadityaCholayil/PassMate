import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/views/formpages/password_form.dart';
import 'package:passmate/views/formpages/payment_card_form.dart';
import 'package:passmate/views/formpages/secure_note_form.dart';
import 'package:passmate/views/pages/folders_page.dart';
import 'package:passmate/views/pages/password_generator.dart';
import 'package:passmate/views/pages/passwords_page.dart';
import 'package:passmate/views/pages/payment_card_page.dart';
import 'package:passmate/views/pages/secure_notes_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/settings/settings_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  Widget _buildSubFAB({required IconData icon, void Function()? onPressed}) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      padding: EdgeInsets.all(7.w),
      height: 60.w,
      width: 60.w,
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
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: context.read<MenuProvider>().currentPage < 3
          // ignore: prefer_const_constructors
          ? const MainListPage()
          : [
              const PasswordGeneratorPage(),
              const FolderPage(),
              // for (String path in context.read<DatabaseBloc>().folderList??[])
              //   FolderPage(path: path),
            ][context.read<MenuProvider>().currentPage-3],
      floatingActionButton: FabCircularMenu(
        key: fabKey,
        ringDiameter: 445.w,
        ringWidth: 130.w,
        fabSize: 65.w,
        fabOpenIcon: const Icon(Icons.add, color: Colors.white, size: 42),
        fabCloseIcon: const Icon(Icons.close, color: Colors.white, size: 37),
        ringColor: colorScheme.secondary.withOpacity(0.3),
        children: [
          _buildSubFAB(
            icon: Icons.sticky_note_2_rounded,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecureNoteFormPage())).then(
                  (value) =>
                      context.read<DatabaseBloc>().add(GetSecureNotes()));
              fabKey.currentState!.close();
            },
          ),
          _buildSubFAB(
            icon: Icons.credit_card_rounded,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentCardFormPage())).then(
                  (value) =>
                      context.read<DatabaseBloc>().add(GetPaymentCards()));
              fabKey.currentState!.close();
            },
          ),
          _buildSubFAB(
            icon: Icons.password_rounded,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PasswordFormPage())).then(
                  (value) => context.read<DatabaseBloc>().add(GetPasswords()));
              fabKey.currentState!.close();
            },
          )
        ],
      ),
    );
  }
}

class MainListPage extends StatefulWidget {
  const MainListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainListPage> createState() => _MainListPageState();
}

class _MainListPageState extends State<MainListPage> {
  String fName = '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    fName = context.read<AppBloc>().userData.firstName ?? '';
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<DatabaseBloc>(context).add([
        GetPasswords(),
        GetPaymentCards(),
        GetSecureNotes(),
      ][context.read<MenuProvider>().currentPage]),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            // bottom: PreferredSize(child: Container(color: Colors.red,), preferredSize: Size(100,40)),
            toolbarHeight: 70.w,
            elevation: 0,
            pinned: true,
            collapsedHeight: 70.w,
            backgroundColor: Colors.white,
            expandedHeight: 235.w,
            title: Container(
              height: 70.w,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  InkWell(
                    // splashRadius: 32.w,
                    // padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.notes_rounded,
                      color: colorScheme.primary,
                      size: 36.w,
                    ),
                    onTap: () {
                      ZoomDrawer.of(context)!.toggle();
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    iconSize: 32.w,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.settings_rounded,
                      color: colorScheme.primary,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsPage())
                      );
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const [StretchMode.zoomBackground],
              background: FittedBox(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(24.w, 105.w, 80.w, 47.w),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: colorScheme.onBackground,
                          height: 0.9,
                        ),
                      ),
                      Text(
                        fName,
                        style: TextStyle(
                          height: 1.25,
                          fontSize: 43,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onBackground,
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
              (context, index) => Container(
                color: Colors.white,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: colorScheme.background,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.w)),
                  ),
                  child: [
                    const PasswordPage(),
                    const PaymentCardPage(),
                    const SecureNotesPage(),
                  ][context.read<MenuProvider>().currentPage],
                ),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
