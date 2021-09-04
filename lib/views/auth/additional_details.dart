import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdditionalDetailsPage extends StatefulWidget {
  const AdditionalDetailsPage({Key? key}) : super(key: key);

  @override
  _AdditionalDetailsPageState createState() => _AdditionalDetailsPageState();
}

class _AdditionalDetailsPageState extends State<AdditionalDetailsPage> {
  String firstName = '';
  String lastName = '';
  String photoUrl = 'https://www.mgretails.com/assets/img/default.png';
  File file = File('');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is FullyAuthenticated) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushReplacementNamed(context, RoutesName.WRAPPER);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Additional Details',
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 43,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: customInputDecoration(
                        context: context, labelText: 'First Name'),
                    style: formTextStyle(context),
                    onSaved: (value) {
                      firstName = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: customInputDecoration(
                        context: context, labelText: 'Last Name'),
                    style: formTextStyle(context),
                    onSaved: (value) {
                      lastName = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                    },
                  ),
                  Center(
                    child: ElevatedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState?.save();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(showCustomSnackBar(context, ''));
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(UpdateUserData(firstName, lastName, photoUrl));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
