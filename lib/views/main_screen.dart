import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 30, 0, 30),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.notes_rounded, size: 40, color: Theme.of(context).colorScheme.primary,),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
            ),
          ),
          Expanded(
            child: [
              PasswordPage(),
              PaymentCardPage(),
              SecureNotesPage(),
            ][context.read<MenuProvider>().currentPage],
          ),
        ],
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
                      .add(GetPasswords(PasswordCategory.All)));
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
                      .add(GetPasswords(PasswordCategory.All)));
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
                      .add(GetPasswords(PasswordCategory.All)));
              fabKey.currentState!.close();
            },
          )
        ],
      ),
    );
  }
}
