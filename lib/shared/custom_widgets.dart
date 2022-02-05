import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/theme/theme.dart';

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
    contentPadding: EdgeInsets.fromLTRB(24.w, 18.w, 15.w, 18.w),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: isSearch
            ? CustomTheme.surface
            : CustomTheme.secondaryVariant,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    fillColor: CustomTheme.surface,
    labelText: labelText,
    labelStyle: const TextStyle(fontSize: 16.5),
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
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.primary,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xffd32f2f),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
  );
}

InputDecoration customInputDecoration2(
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
    contentPadding: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 15.w),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: isSearch
            ? CustomTheme.surface
            : CustomTheme.secondaryVariant,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    fillColor: CustomTheme.surface,
    labelText: labelText,
    labelStyle: const TextStyle(fontSize: 16.5),
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
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.primary,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xffd32f2f),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
  );
}

TextStyle formTextStyle(BuildContext context) =>
    TextStyle(fontSize: 17, color: CustomTheme.primary, fontWeight: FontWeight.w500);

TextStyle formTextStyle2(BuildContext context) =>
    TextStyle(fontSize: 16, color: CustomTheme.onSurface);

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final int style;
  final double fontSize;

  const CustomElevatedButton(
      {Key? key, this.onPressed, this.text = 'Submit', this.style = 0, this.fontSize=18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        primary:
            style == 0 ? CustomTheme.primary : CustomTheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: CustomTheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12.w),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 60.w,
        child: Text(
          text,
          style: TextStyle(
              color: style == 0
                  ? CustomTheme.onPrimary
                  : CustomTheme.primary,
              fontSize: fontSize,
              fontWeight: FontWeight.w500),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.fromLTRB(0, 9.w, 15.w, 9.w),
      iconSize: 32.w,
      color: CustomTheme.primary,
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
