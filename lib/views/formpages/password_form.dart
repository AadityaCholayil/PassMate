import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';

class PasswordFormPage extends StatefulWidget {
  final Password? password;

  const PasswordFormPage({Key? key, this.password}) : super(key: key);

  @override
  _PasswordFormPageState createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {
  String _id = '';
  String _path = 'root/default';
  String _siteName = '';
  String _siteUrl = '';
  String _email = '';
  String _password = '';
  String? _imageUrl;
  String _note = '';
  PasswordCategory _category = PasswordCategory.others;
  bool _favourite = false;
  int _usage = 0;
  Timestamp? _timeAdded;

  bool _isUpdate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.password != null) {
      _isUpdate = true;
      _id = widget.password!.id;
      _path = widget.password!.path;
      _siteName = widget.password!.siteName;
      _siteUrl = widget.password!.siteUrl;
      _email = widget.password!.email;
      _password = widget.password!.password;
      _imageUrl = widget.password!.imageUrl;
      _note = widget.password!.note;
      _category = widget.password!.category;
      _favourite = widget.password!.favourite;
      _usage = widget.password!.usage;
      _timeAdded = widget.password!.timeAdded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<DatabaseBloc, DatabaseState>(
            listener: (context, state) async {
              if (state is PasswordFormState) {
                if (state == PasswordFormState.success) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.w),
                      const CustomBackButton(),
                      SizedBox(height: 12.w),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          'Add Password',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.w),
                      _buildHeader('Site Name'),
                      _buildSiteName(context),
                      _buildHeader('Site Url'),
                      _buildSiteUrl(context),
                      _buildHeader('Username / Email'),
                      _buildEmail(context),
                      _buildHeader('Password'),
                      _buildPassword(context),
                      _buildHeader('Category'),
                      _buildCategory(),
                      _buildHeader('Path'),
                      _buildFolderPath(),
                      _buildHeader('Note (Optional)'),
                      _buildNote(context),
                      SizedBox(height: 25.w),
                      _buildSubmitButton(),
                      SizedBox(height: 100.w),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 5.w),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondaryVariant,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String? validateText(String? value) {
    if (value == null || value == '') {
      return 'This field cannot be empty!';
    }
    return null;
  }

  Widget _buildSiteName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: TextFormField(
        initialValue: _siteName,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. Google',
        ),
        onSaved: (value) {
          _siteName = value ?? '';
        },
        validator: validateText,
      ),
    );
  }

  Widget _buildSiteUrl(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: TextFormField(
        initialValue: _siteUrl,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. www.google.com',
        ),
        onSaved: (value) {
          _siteUrl = value ?? '';
        },
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null) {
            return 'This field cannot be empty!';
          }
          if (value.isNotEmpty &&
              !RegExp(r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)')
                  .hasMatch(value)) {
            return 'Invalid URL format';
          }
        },
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: TextFormField(
        initialValue: _email,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Username or Email',
        ),
        onSaved: (value) {
          _email = value ?? '';
        },
        validator: validateText,
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: TextFormField(
        initialValue: _password,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Password',
        ),
        onSaved: (value) {
          _password = value ?? '';
        },
        validator: validateText,
      ),
    );
  }

  Widget _buildNote(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: TextFormField(
        initialValue: _note,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. Google',
        ),
        maxLines: 3,
        onSaved: (value) {
          _note = value ?? '';
        },
      ),
    );
  }

  Widget _buildCategory() {
    String label = _category.toString().substring(17);
    label = label.replaceRange(0, 1, label[0].toUpperCase());
    return Container(
      margin: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.w),
        onTap: () async {
          var res = await showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.25),
            backgroundColor: Colors.transparent,
            builder: (context) {
              return _buildCategoryCard();
            },
          );
          if (res != null) {
            setState(() {
              _category = res;
            });
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 55.w,
          padding: EdgeInsets.only(left: 18.w, right: 7.w),
          // padding: EdgeInsets.fromLTRB(18.w, 11.w, 15.w, 11.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryVariant,
              width: 2.w,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            children: [
              Icon(
                passwordCategoryIcon[_category.index],
                size: 23.w,
              ),
              SizedBox(width: 10.w),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              SizedBox(width: 5.w),
              const Icon(
                Icons.expand_more,
                size: 35,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard() {
    return StatefulBuilder(
      builder: (context, setState) {
        PasswordCategory category = _category;
        return Card(
          margin: EdgeInsets.all(10.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                // Divider(thickness: 1,),
                SizedBox(height: 17.w),
                Wrap(
                  runSpacing: 8.w,
                  spacing: 8.w,
                  children: [
                    for (int index = 1;
                        index < PasswordCategory.values.length;
                        index++)
                      Builder(
                        builder: (context) {
                          String label = PasswordCategory.values[index]
                              .toString()
                              .substring(17);
                          label =
                              label.replaceRange(0, 1, label[0].toUpperCase());
                          bool selected =
                              category == PasswordCategory.values[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                category = PasswordCategory.values[index];
                              });
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                Navigator.pop(context, category);
                              });
                            },
                            child: Chip(
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 0.8),
                              avatar: Icon(
                                passwordCategoryIcon[index],
                                size: 23.w,
                                color: !selected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).cardColor,
                              ),
                              backgroundColor: selected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).cardColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11.w, vertical: 7.w),
                              // padding: EdgeInsets.fromLTRB(12.w, 7.w, 12.w, 7.w),
                              labelPadding: EdgeInsets.fromLTRB(8.w, 0, 6.w, 0),
                              label: Text(
                                label,
                                style: TextStyle(
                                  color: !selected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).cardColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                SizedBox(height: 5.w),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFolderPath() {
    List<String> pathList = [];
    _path.split('/').forEach((path) {
      if (path == 'root') {
        pathList.add('My Folders');
      } else {
        pathList.add(path.replaceRange(0, 1, path[0].toUpperCase()));
      }
    });
    return Container(
      margin: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.w),
        onTap: () {
          print('change path');
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 55.w,
          padding: EdgeInsets.only(left: 18.w, right: 7.w),
          // padding: EdgeInsets.fromLTRB(18.w, 11.w, 15.w, 11.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryVariant,
              width: 2.w,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: pathList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (pathList.length == index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    } else {
                      return Center(
                        child: Text(
                          pathList[index],
                          style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.w,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 5.w),
              const Icon(
                Icons.expand_more,
                size: 35,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return CustomElevatedButton(
      style: 0,
      text: _isUpdate ? 'Update' : 'Submit',
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        setState(() {
          _formKey.currentState!.save();
        });
        Password password = Password(
          id: _id,
          path: _path,
          siteName: _siteName,
          siteUrl: _siteUrl,
          email: _email,
          password: _password,
          imageUrl: 'https://api.faviconkit.com/$_siteUrl/144',
          note: _note == '' ? 'null' : _note,
          category: _category,
          favourite: _favourite,
          usage: _usage,
          lastUsed: Timestamp.now(),
          timeAdded: _timeAdded ?? Timestamp.now(),
        );
        print(password);
        // Password password2 = Password(
        //   id: widget.password?.id ?? '',
        //   path: 'root/default',
        //   siteName: 'Google',
        //   siteUrl: 'www.google.com',
        //   email: 'aaditya@xyz.com',
        //   password: 'aadi123',
        //   imageUrl: 'https://api.faviconkit.com/www.google.com/144',
        //   note: 'Bruh',
        //   category: PasswordCategory.social,
        //   favourite: false,
        //   usage: 3,
        //   lastUsed: Timestamp.now(),
        //   timeAdded: Timestamp.now(),
        // );
        if (!_isUpdate) {
          context.read<DatabaseBloc>().add(AddPassword(password));
        } else {
          context
              .read<DatabaseBloc>()
              .add(UpdatePassword(password, true, widget.password!.path));
        }
      },
    );
  }
}

enum FormFieldType { siteName, siteUrl, email, password, note }
