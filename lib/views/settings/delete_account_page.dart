import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/model/auth_credentials.dart';
import 'package:passmate/routes/routes_name.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/theme/theme.dart';

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
    return BlocConsumer<OldAppBloc, OldAppState>(
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
        if (state is Unauthenticated) {
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
      padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        height: 1.25.w,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      'Please re-enter your credentials',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: CustomTheme.secondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomShadow(
                    child: TextFormField(
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
                  ),
                  SizedBox(height: 20.w),
                  CustomShadow(
                    child: TextFormField(
                      decoration: customInputDecoration(
                          context: context, labelText: 'Master Password'),
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
                  ),
                  SizedBox(height: 25.w),
                  CustomElevatedButton(
                    text: 'Delete Account',
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState?.save();
                      dynamic res = await showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.25),
                        builder: (context) {
                          return const ConfirmDialog(
                              heading: 'Delete Account?',
                              content:
                                  'All your credentials will be deleted permanently. This action cannot be undone!');
                        },
                      );
                      if (res == 'confirm') {
                        // print('delete acc');
                        BlocProvider.of<OldAppBloc>(context)
                            .add(DeleteUser(email: email, password: password));
                      }
                      // print(stateMessage);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     showCustomSnackBar(context, stateMessage));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}

class ConfirmDialog extends StatefulWidget {
  final String heading;
  final String content;

  const ConfirmDialog({Key? key, required this.heading, required this.content})
      : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  String heading = '';
  String content = '';

  @override
  void initState() {
    super.initState();
    heading = widget.heading;
    content = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // height: 335.w,
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.all(15.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.w)),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5.w),
                SizedBox(
                  height: 100.w,
                  width: 100.w,
                  child: Image.network(
                      'https://www.freeiconspng.com/uploads/orange-error-icon-0.png'),
                ),
                SizedBox(height: 15.w),
                Text(
                  heading,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 5.w),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.w),
                Row(
                  children: [
                    Flexible(
                      child: CustomElevatedButton(
                        style: 1,
                        text: 'Cancel',
                        fontSize: 17,
                        onPressed: () {
                          Navigator.pop(context, 'cancel');
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: CustomElevatedButton(
                        text: 'Confirm',
                        fontSize: 17,
                        onPressed: () {
                          Navigator.pop(context, 'confirm');
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
