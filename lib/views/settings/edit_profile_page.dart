import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/temp_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/theme/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String firstName = '';
  String lastName = '';
  String photoUrl = '';
  File? _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    UserData userData = context.read<AppBloc>().userData;
    firstName = userData.firstName ?? '';
    lastName = userData.lastName ?? '';
    photoUrl = userData.photoUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) async {
          if (state is EditProfilePageState) {
            if (state.message == 'Success!') {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              print('Navigating..');
              await Future.delayed(const Duration(milliseconds: 300));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(showCustomSnackBar(context, state.message));
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: LayoutBuilder(builder: (context, constraints) {
                // Responsive
                print('Layout Changed');
                if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                  // LandScape
                  return const TempError(
                      pageName: 'Additional EditProfile Screen');
                }
                return _buildEditProfilePortrait(context);
              }),
            ),
          );
        });
  }

  Widget _buildEditProfilePortrait(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
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
              SizedBox(height: 25.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: colors.onBackground,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  _buildProfile(colors, context),
                  SizedBox(height: 20.w),
                  Padding(
                    padding: EdgeInsets.only(left: 14.w, bottom: 4.w),
                    child: Text(
                      'First Name',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: CustomTheme.secondary,
                      ),
                    ),
                  ),
                  CustomShadow(
                    child: TextFormField(
                      initialValue: firstName,
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
                  SizedBox(height: 12.w),
                  Padding(
                    padding: EdgeInsets.only(left: 14.w, bottom: 4.w),
                    child: Text(
                      'Last Name',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: CustomTheme.secondary,
                      ),
                    ),
                  ),
                  CustomShadow(
                    child: TextFormField(
                      initialValue: lastName,
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
                    text: 'Update Profile',
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState?.save();
                      BlocProvider.of<AppBloc>(context)
                          .add(UpdateUserData(firstName, lastName, _image));
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.w),
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
                                photoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
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
