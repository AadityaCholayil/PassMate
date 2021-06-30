import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String? labelText;
  final String? Function(String? onSaved)? validator;
  final void Function(String? onSaved)? onSaved;
  final TextInputType? keyboardType;

  const CustomTextFormField({Key? key, this.labelText, this.validator, this.onSaved, this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 1.4, style: BorderStyle.solid, ),
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
            color: Colors.purple,
            width: 2,
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
    );
  }
}
