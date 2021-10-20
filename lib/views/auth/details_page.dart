import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/auth/email_input_page.dart';
import 'package:passmate/views/auth/login_page.dart';
import 'package:passmate/views/auth/signup_page.dart';
import 'package:passmate/views/pages/temp_error.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String firstName = '';
  String lastName = '';
  XFile? file;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          /// Responsive
          print('Layout Changed');
          if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
            ///LandScape
            return const TempError(pageName: 'Additional Details Screen');
          }
          return _buildDetailsPortrait(context);
        }),
      ),
    );
  }

  Widget _buildDetailsPortrait(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25.w),
              const CustomBackButton(),
              SizedBox(height: 15.w),
              Column(
                children: [
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 43.5,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Center(
                    child: Container(
                      height: 116.w,
                      width: 116.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3.6.w),
                        borderRadius: BorderRadius.circular(58.w),
                      ),
                      padding: EdgeInsets.all(3.w),
                      child: Image.network(
                          'https://www.mgretails.com/assets/img/default.png'),
                    ),
                  ),
                  SizedBox(height: 25.w),
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
                  SizedBox(height: 20.w),
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
                  SizedBox(height: 30.w),
                  CustomElevatedButton(
                    text: 'Next',
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState?.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailInputPage(
                                  firstName: firstName, lastName: lastName)));
                    },
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  TextButton(
                    child: Text(
                      "Login!",
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
