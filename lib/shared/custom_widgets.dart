import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    contentPadding: EdgeInsets.fromLTRB(22.w, 15.w, 15.w, 15.w),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: isSearch
            ? Theme.of(context).cardColor
            : Theme.of(context).colorScheme.secondaryVariant,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    fillColor: Theme.of(context).colorScheme.surface,
    labelText: labelText,
    labelStyle: TextStyle(fontSize: 19),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    helperStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffd32f2f),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffd32f2f),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 2.w,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
    ),
  );
}

TextStyle formTextStyle(BuildContext context) => TextStyle(
  fontSize: 19,
  color: Theme.of(context).primaryColor
);

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final int style;

  const CustomElevatedButton(
      {Key? key, this.onPressed, this.text = 'Submit', this.style = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary:
            style == 0 ? Theme.of(context).colorScheme.primary : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12.w),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 55.w,
        child: Text(
          text,
          style: TextStyle(
              color: style == 0 ?Theme.of(context).colorScheme.onPrimary: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600),
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
      padding: EdgeInsets.fromLTRB(0, 8.w, 15.w, 8.w),
      iconSize: 35.w,
      color: Theme.of(context).primaryColor,
      icon: Icon(Icons.arrow_back_ios_rounded),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
}

