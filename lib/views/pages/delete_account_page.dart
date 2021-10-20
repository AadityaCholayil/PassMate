import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/views/pages/temp_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  String email = '';
  String password = '';
  String stateMessage = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) async {
        if (state is DeleteAccountPageState) {
          stateMessage = state.message;
          print(stateMessage);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, state.message));
        }
        if (state is Uninitialized) {
          stateMessage = 'Success!';
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          print('Navigating..');
          Navigator.popUntil(context, ModalRoute.withName(RoutesName.wrapper));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive
                print('Layout Changed');
                if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                  // LandScape
                  return const TempError(pageName: 'Delete Account');
                }
                return _buildDeleteAccountPortrait(context);
              },
            ),
          ),
        );
      },
    );
  }

  Container _buildDeleteAccountPortrait(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            const CustomBackButton(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Delete Account',
                    style: TextStyle(
                      height: 1.25.w,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  TextFormField(
                    decoration: customInputDecoration(
                        context: context, labelText: 'Email'),
                    style: formTextStyle(context),
                    onSaved: (value) {
                      email = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!AuthEmail(value).isValid) {
                        return 'Invalid email format';
                      }
                    },
                  ),
                  SizedBox(height: 20.w),
                  TextFormField(
                    decoration: customInputDecoration(
                        context: context, labelText: 'Password'),
                    style: formTextStyle(context),
                    onSaved: (value) {
                      password = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                    },
                  ),
                  SizedBox(height: 25.w),
                  CustomElevatedButton(
                    text: 'Confirm',
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState?.save();
                      print(stateMessage);
                      ScaffoldMessenger.of(context).showSnackBar(
                          showCustomSnackBar(context, stateMessage));
                      BlocProvider.of<AppBloc>(context)
                          .add(DeleteUser(email: email, password: password));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
