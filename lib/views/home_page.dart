import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/views/formpages/password_form.dart';
import 'package:passmate/views/pages/passwords_page.dart';
import 'package:passmate/views/pages/payment_card_page.dart';
import 'package:passmate/views/pages/secure_notes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: Container(
        child: [
          PasswordPage(),
          PaymentCardPage(),
          SecureNotesPage(),
        ][context.read<MenuProvider>().currentPage],
      ),
      floatingActionButton: Container(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PasswordFormPage()))
                .then((value) => context.read<DatabaseBloc>()
                .add(GetPasswords(PasswordCategory.All)));
          },
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
