import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/theme/theme.dart';
import 'package:passmate/views/formpages/password_form.dart';
import 'package:passmate/views/formpages/payment_card_form.dart';
import 'package:passmate/views/formpages/secure_note_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/settings/settings_page.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
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
                (value) => context.read<DatabaseBloc>().add(GetSecureNotes()));
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
                (value) => context.read<DatabaseBloc>().add(GetPaymentCards()));
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
    );
  }

  Widget _buildSubFAB({required IconData icon, void Function()? onPressed}) {
    return Container(
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
}

class CustomAnimatedAppBar extends StatefulWidget {
  final Widget child;

  const CustomAnimatedAppBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<CustomAnimatedAppBar> createState() => _CustomAnimatedAppBarState();
}

class _CustomAnimatedAppBarState extends State<CustomAnimatedAppBar> {
  @override
  Widget build(BuildContext context) {
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
            toolbarHeight: 60.w,
            elevation: 0,
            pinned: true,
            collapsedHeight: 60.w,
            backgroundColor: CustomTheme.card,
            expandedHeight: 235.w,
            title: Container(
              height: 60.w,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.notes_rounded,
                      color: CustomTheme.primary,
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
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
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
                          fontSize: 27,
                          fontWeight: FontWeight.normal,
                          color: colorScheme.onBackground,
                          height: 0.9,
                        ),
                      ),
                      BlocBuilder<AppBloc, AppState>(builder: (context, state) {
                        String fName =
                            context.read<AppBloc>().userData.firstName ?? '';
                        return Text(
                          fName,
                          style: TextStyle(
                            height: 1.25,
                            fontSize: 44,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onBackground,
                          ),
                        );
                      }),
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
                  child: widget.child,
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
