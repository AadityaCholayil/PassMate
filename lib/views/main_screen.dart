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
      padding: EdgeInsets.all(7),
      height: 70,
      width: 70,
      child: IconButton(
        icon: Icon(
          icon,
          size: 35,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: [
          PasswordPage(),
          PaymentCardPage(),
          SecureNotesPage(),
        ][context.read<MenuProvider>().currentPage],
      ),
      floatingActionButton: FabCircularMenu(
        key: fabKey,
        // ringDiameter: 500,
        // ringWidth: 150,
        fabSize: 72,
        fabOpenIcon: Icon(Icons.add, size: 45),
        fabCloseIcon: Icon(Icons.close, size: 40),
        ringColor: Colors.purple[100],
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
      // floatingActionButton: Container(
      //   height: 75,
      //   width: 75,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => PasswordFormPage()))
      //           .then((value) => context.read<DatabaseBloc>()
      //           .add(GetPasswords(PasswordCategory.All)));
      //     },
      //     child: Icon(
      //       Icons.add,
      //       size: 50,
      //     ),
      //   ),
      // ),
    );
  }
}
