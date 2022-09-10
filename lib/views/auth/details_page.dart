import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/auth/email_input_page.dart';
import 'package:passmate/views/auth/login_page.dart';
import 'package:passmate/shared/temp_error.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String firstName = '';
  String lastName = '';
  File? _image;

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
        padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        height: 1.25,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.w),
                  _buildProfile(Theme.of(context).colorScheme, context),
                  SizedBox(height: 25.w),
                  CustomShadow(
                    child: TextFormField(
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
                  ),
                  SizedBox(height: 20.w),
                  CustomShadow(
                    child: TextFormField(
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
                                    firstName: firstName,
                                    lastName: lastName,
                                    image: _image,
                                  )));
                    },
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  TextButton(
                    child: Text(
                      "Login!",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(ColorScheme colors, BuildContext context) {
    return Center(
      child: SizedBox(
        height: 116.w,
        width: 116.w,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: colors.primary, width: 3.6.w),
                borderRadius: BorderRadius.circular(58.w),
              ),
              padding: EdgeInsets.all(3.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(58.w),
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.25),
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return _buildBottomCard(colors);
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55.w),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _image != null
                          ? SizedBox(
                              height: 110.w,
                              width: 110.w,
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox(
                              height: 110.w,
                              width: 110.w,
                              child: Image.network(
                                'https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                      _image != null
                          ? const SizedBox.shrink()
                          : Container(
                              height: 40.w,
                              color: Colors.black45,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                size: 25.w,
                                color: colors.surface,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            _image != null
                ? Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 44.w,
                      width: 44.w,
                      decoration: BoxDecoration(
                        color: colors.surface,
                        border: Border.all(color: colors.primary, width: 2.5.w),
                        borderRadius: BorderRadius.circular(22.w),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 24.w,
                        ),
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.25),
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return _buildBottomCard(colors);
                            },
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  // choose image from camera
  Future<File?> _imageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File? image = File(pickedFile.path);
      return image;
    } else {
      return null;
    }
  }

  // choose image from gallery
  Future<File?> _imageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? image = File(pickedFile.path);
      return image;
    } else {
      return null;
    }
  }

  Widget _buildBottomCard(ColorScheme colors) {
    return Card(
      margin: EdgeInsets.all(15.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.camera_alt_outlined, color: colors.onSurface),
              title: Text(
                'Camera',
                style: TextStyle(fontSize: 17, color: colors.onSurface),
              ),
              onTap: () async {
                File? image = await _imageFromCamera();
                if (image != null) {
                  setState(() {
                    _image = image;
                  });
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            Divider(
              indent: 10.w,
              endIndent: 10.w,
              height: 8.w,
              thickness: 1.5.w,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.add_photo_alternate_outlined,
                  color: colors.onSurface),
              title: Text(
                'Gallery',
                style: TextStyle(fontSize: 17, color: colors.onSurface),
              ),
              onTap: () async {
                File? image = await _imageFromGallery();
                if (image != null) {
                  setState(() {
                    _image = image;
                  });
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
