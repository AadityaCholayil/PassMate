import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/views/main_screen.dart';
import 'package:passmate/views/pages/temp_error.dart';
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
        child: GestureDetector(
          child: Consumer<MenuProvider>(
            builder: (context, provider, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  /// Responsive
                  print('Layout Changed');
                  if (constraints.maxHeight < 1.5 * constraints.maxWidth) {
                    return TempError(pageName: 'HomeScreen');
                  }
                  return ZoomDrawer(
                    controller: _zoomController,
                    borderRadius: 35.w,
                    slideWidth: MediaQuery.of(context).size.width * .60,
                    menuScreen: MenuScreen(),
                    mainScreen: MainScreen(),
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
    return BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, state) {
      folderList = context.read<DatabaseBloc>().folderList ?? [];
    }, builder: (context, state) {
      if (state is Fetching) {
        return Container();
      }
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
              SizedBox(height: 20.w),
              Text(
                'Tools',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                  // fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.w),
              MenuItem(
                index: 3,
                text: 'Password Generator',
                icon: Icons.vpn_key_outlined,
              ),
              SizedBox(height: 15.w),
              Text(
                'Folders',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                  // fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.w),
              MenuItem(
                index: 4,
                text: 'All Folders',
                icon: Icons.folder_open_outlined,
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: folderList.length,
                itemBuilder: (context, index) {
                  String folderName = folderList[index].split('/').last;
                  return MenuItem(
                    index: index + 5,
                    text: folderName,
                    icon: Icons.folder_open_outlined,
                  );
                },
              ),
              SizedBox(height: 15.w),
            ],
          ),
        ),
      );
    });
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
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(5.w, 12.w, 10.w, 12.w),
      ),
      onPressed: () {
        context.read<MenuProvider>().updateCurrentPage(index);
        ZoomDrawer.of(context)!.close();
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 27.w,
            color: Colors.white,
          ),
          SizedBox(
            width: 25.w,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
