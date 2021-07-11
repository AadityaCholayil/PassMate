import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final bool isSearch;
  final String? labelText;
  final String? Function(String? onSaved)? validator;
  final void Function(String? onSaved)? onSaved;
  final void Function(String? onSaved)? onChanged;
  final TextInputType? keyboardType;

  const CustomTextFormField(
      {Key? key,
      this.isSearch = false,
      this.labelText,
      this.validator,
      this.onSaved,
      this.keyboardType,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: isSearch?Padding(
          padding: EdgeInsets.only(right: 20.0.w),
          child: Icon(Icons.search, size: 30.w,),
        ):null,
        contentPadding: EdgeInsets.fromLTRB(25.w, 12.w, 25.w, 12.w),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isSearch?Colors.white:Theme.of(context).colorScheme.secondaryVariant,
            width: 1.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
        ),
        fillColor: Theme.of(context).colorScheme.surface,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 22),
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
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffd32f2f),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(17.0)),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final int style;

  const CustomElevatedButton({Key? key, this.onPressed, this.text='Submit', this.style = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: style==0?Theme.of(context).colorScheme.primary:Colors.white,
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
          'SignUp',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}


