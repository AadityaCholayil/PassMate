import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/theme/theme.dart';
import 'package:passmate/views/settings/settings_page.dart';

InputDecoration customInputDecoration(
    {required BuildContext context,
    String labelText = '',
    bool isSearch = false}) {
  return InputDecoration(
    suffixIcon: isSearch
        ? Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Icon(
              Icons.search,
              size: 25.w,
            ),
          )
        : null,
    contentPadding: EdgeInsets.fromLTRB(24.w, 20.w, 22.w, 20.w),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: isSearch ? CustomTheme.card : CustomTheme.card,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.w)),
    ),
    fillColor: CustomTheme.card,
    labelText: labelText,
    labelStyle: TextStyle(
        fontSize: 16, color: CustomTheme.t2, fontWeight: FontWeight.w400),
    alignLabelWithHint: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    helperStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: const TextStyle(
      color: Color(0xffd32f2f),
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    isCollapsed: false,
    prefixStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: const TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xffd32f2f),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0.w)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.primary,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0.w)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xffd32f2f),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0.w)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0.w)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0.w)),
    ),
  );
}

TextStyle formTextStyle(BuildContext context) => TextStyle(
    fontSize: 16, color: CustomTheme.primary, fontWeight: FontWeight.w500);

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final int style;
  final double fontSize;

  const CustomElevatedButton(
      {Key? key,
      this.onPressed,
      this.text = 'Submit',
      this.style = 0,
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        primary: style == 0 ? CustomTheme.primary : CustomTheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 60.w,
        child: Text(
          text,
          style: TextStyle(
              color: style == 0 ? CustomTheme.t3 : CustomTheme.primary,
              fontSize: fontSize,
              fontWeight: FontWeight.w500),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final Widget? child;

  const CustomBackButton({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0.w),
          child: IconButton(
            padding: EdgeInsets.fromLTRB(0, 9.w, 15.w, 9.w),
            iconSize: 30.w,
            color: CustomTheme.primary,
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}

class CustomShadow extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? borderRadius;

  const CustomShadow({
    Key? key,
    required this.child,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height ?? 60.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: CustomTheme.cardShadow,
                blurRadius: 10,
                offset: Offset(4.w, 4.w),
              ),
            ],
            color: CustomTheme.card,
            borderRadius: BorderRadius.circular(borderRadius ?? 20.w),
          ),
        ),
        child,
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final Widget child;
  final AppBarType type;

  const CustomAppBar({
    Key? key,
    required this.child,
    this.type = AppBarType.back,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 90.w,
          padding: EdgeInsets.only(
              left: type == AppBarType.menu ? 20.w : 17.w, right: 20.w),
          child: Row(
            children: [
              type == AppBarType.menu
                  ? IconButton(
                      onPressed: () => ZoomDrawer.of(context)!.toggle(),
                      icon: Icon(
                        Icons.menu_rounded,
                        size: 34.w,
                        color: CustomTheme.primary,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        if (type == AppBarType.backToHome) {
                          // context.read<AppBloc>().add(const GetHomePageContents());
                          context.read<MenuProvider>().updateCurrentPage(0);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 28.w,
                        color: CustomTheme.primary,
                      ),
                      padding: EdgeInsets.zero,
                    ),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                ),
                icon: Icon(
                  Icons.menu_rounded,
                  size: 34.w,
                  color: CustomTheme.primary,
                ),
              )
            ],
          ),
        ),
        child,
      ],
    );
  }
}

enum AppBarType { back, menu, backToHome }

// void backToHome(BuildContext context) {
//   // context.read<AppBloc>().add(const GetHomePageContents());
//   context.read<MenuProvider>().updateCurrentPage(0);
// }
