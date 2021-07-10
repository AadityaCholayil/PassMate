import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/views/main_screen.dart';
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
      builder: (context, child) {
        return child ?? Container();
      },
      child: SafeArea(
        child: GestureDetector(child: Consumer<MenuProvider>(
          builder: (context, provider, child) {
            return ZoomDrawer(
              controller: _zoomController,
              borderRadius: 35.w,
              slideWidth: MediaQuery.of(context).size.width * .60,
              menuScreen: MenuScreen(),
              mainScreen: MainScreen(),
            );
          },
        ), onHorizontalDragUpdate: (details) {
          int sensitivity = 8;
          if (details.delta.dx > sensitivity) {
            _zoomController.open!();
          } else if (details.delta.dx < -sensitivity) {
            _zoomController.close!();
          }
        }),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Spacer(),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String text;

  const MenuItem({Key? key, int? index, IconData? icon, String? text})
      : index=index??0,
        icon=icon??Icons.add,
        text=text??'',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 27.w,
          color: Colors.white,
        ),
        SizedBox(width: 20.w,),
        TextButton(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),
          ),
          onPressed: () {
            context.read<MenuProvider>().updateCurrentPage(index);
            ZoomDrawer.of(context)!.close();
          },
        ),
      ],
    );
  }
}
