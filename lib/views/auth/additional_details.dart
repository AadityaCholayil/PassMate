import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/auth/signup_page.dart';
import 'package:passmate/views/pages/temp_error.dart';

class AdditionalDetailsPage extends StatefulWidget {
  const AdditionalDetailsPage({Key? key}) : super(key: key);

  @override
  _AdditionalDetailsPageState createState() => _AdditionalDetailsPageState();
}

class _AdditionalDetailsPageState extends State<AdditionalDetailsPage> {
  String firstName = '';
  String lastName = '';
  String photoUrl = 'https://www.mgretails.com/assets/img/default.png';
  XFile? file;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        /// Responsive
        print('Layout Changed');
        if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
          ///LandScape
          return const TempError(pageName: 'Additional Details Screen');
        }
        return _buildAdditionalDetailsPortrait(context);
      }),
    );
  }

  Container _buildAdditionalDetailsPortrait(BuildContext context) {
    return Container(
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
                color: Theme
                    .of(context)
                    .colorScheme
                    .onBackground,
              ),
            ),
            SizedBox(
              height: 15.w,
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
              height: 15.w,
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
                child: const Text('Next'),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState?.save();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage(firstName: firstName, lastName: lastName)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
