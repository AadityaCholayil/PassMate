import 'package:flutter/material.dart';
import 'package:passmate/bloc/login_bloc/login_barrel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar showCustomSnackBar(BuildContext context, String message) {
  return SnackBar(
    margin: EdgeInsets.all(15.w),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    content: Row(
      children: [
        Text(
          message,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        message == LoginState.loading.message
            ? const SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            ))
            : const SizedBox.shrink(),
      ],
    ),
    action: message == LoginState.loading.message
        ? null
        : SnackBarAction(
      label: 'OK',
      textColor: Theme.of(context).colorScheme.secondary,
      onPressed: () {},
    ),
  );
}