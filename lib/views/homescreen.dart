import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/views/home_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _zoomController = ZoomDrawerController();
  final rtl = ZoomDrawer.isRTL();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuProvider>(
      create: (context)=> MenuProvider(),
      builder: (context, child){
        return child??Container();
      },
      child: SafeArea(
        child: GestureDetector(
          child: Consumer<MenuProvider>(
            builder: (context, provider, child){
              return ZoomDrawer(
                controller: _zoomController,
                slideWidth: MediaQuery.of(context).size.width*.60,
                menuScreen: MenuScreen(),
                mainScreen: HomePage(),
              );
            },
          ),
          onHorizontalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              _zoomController.open!();
            } else if(details.delta.dx < -sensitivity){
              _zoomController.close!();
            }
          }
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              child: Text('Passwords'),
              onPressed: () {
                context.read<MenuProvider>().updateCurrentPage(0);
                ZoomDrawer.of(context)!.close();
              },
            ),
            TextButton(
              child: Text('Payment Cards'),
              onPressed: () {
                context.read<MenuProvider>().updateCurrentPage(1);
                ZoomDrawer.of(context)!.close();
              },
            ),
            TextButton(
              child: Text('Secure Notes'),
              onPressed: () {
                context.read<MenuProvider>().updateCurrentPage(2);
                ZoomDrawer.of(context)!.close();
              },
            ),
          ],
        ),
      ),
    );
  }
}



