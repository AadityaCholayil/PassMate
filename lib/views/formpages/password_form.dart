import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/folder.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';

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
  String _note = '';
  PasswordCategory _category = PasswordCategory.others;
  String _imageUrl = '';
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
      _note = widget.password!.note == 'null' ? '' : widget.password!.note;
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
                      _buildHeader(
                          'Site Name', Icons.drive_file_rename_outline),
                      _buildSiteName(context),
                      _buildHeader('Site Url', Icons.link),
                      _buildSiteUrl(context),
                      _buildHeader('Username / Email', Icons.person_outlined),
                      _buildEmail(context),
                      _buildHeader('Password', Icons.password_outlined),
                      _buildPassword(context),
                      _buildHeader('Category', Icons.category_outlined),
                      _buildCategory(),
                      _buildHeader('Path', Icons.folder_outlined),
                      _buildFolderPath(),
                      _buildHeader(
                          'Note (Optional)', Icons.sticky_note_2_outlined),
                      _buildNote(context),
                      SizedBox(height: 25.w),
                      _buildSubmitButton(context),
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

  Widget _buildHeader(String title, IconData iconData) {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 5.w),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 16.w,
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
          labelText: 'Eg. For Google',
        ),
        maxLines: 3,
        onSaved: (value) {
          _note = value ?? '';
        },
      ),
    );
  }

  Widget _buildCategory() {
    String label = getPasswordCategoryStr(_category);
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
                passwordCategoryIcon[getPasswordCategoryStr(_category)],
                size: 23.w,
              ),
              SizedBox(width: 10.w),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
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
                          String label = getPasswordCategoryStr(PasswordCategory.values[index]);
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
                                passwordCategoryIcon[label],
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
        onTap: () async {
          print('change path');
          var res = await showDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(0.25),
            // backgroundColor: Colors.transparent,
            builder: (context) {
              return SelectFolderDialog(startPath: _path);
            },
          );
          if (res != null) {
            setState(() {
              _path = res;
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

  Future<String?> getFavicon(String domain) async {
    Client _client = Client();
    Response response = await _client.get(Uri.https(
      'favicongrabber.com',
      '/api/grab/$domain',
    ));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      try {
        String url = data['icons'][0]['src'];
        print(url);
        return url;
      } on Exception catch (_) {
        return null;
      } on Error catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }

  Widget _buildSubmitButton(BuildContext context) {
    return CustomElevatedButton(
      style: 0,
      text: _isUpdate ? 'Update' : 'Submit',
      onPressed: () async {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        setState(() {
          _formKey.currentState!.save();
        });
        String? imageUrl = await getFavicon(_siteUrl);
        if (imageUrl != null) {
          _imageUrl = imageUrl;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, 'Please try again!'));
          return;
        }
        Password password = Password(
          id: _id,
          path: _path,
          siteName: _siteName,
          siteUrl: _siteUrl,
          email: _email,
          password: _password,
          imageUrl: _imageUrl,
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

class SelectFolderDialog extends StatefulWidget {
  final String startPath;

  const SelectFolderDialog({Key? key, required this.startPath})
      : super(key: key);

  @override
  _SelectFolderDialogState createState() => _SelectFolderDialogState();
}

class _SelectFolderDialogState extends State<SelectFolderDialog> {
  String _path = '';
  Folder _folder = Folder.empty;
  List<String> pathList = [];
  int selectedIndex = 999;
  String selectedPath = '';

  @override
  void initState() {
    super.initState();
    if (_path == '') {
      _path = widget.startPath;
      selectedPath = _path;
    }
    String path = selectedPath.substring(
        0, selectedPath.length - selectedPath.split('/').last.length - 1);
    print(path);
    context.read<DatabaseBloc>().add(GetFolder(path: path));
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: BlocConsumer<DatabaseBloc, DatabaseState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is FolderListState) {
            _folder = state.folder;
            List<String> list = _folder.path.split('/');
            pathList = [];
            _path = _folder.path;
            for (var path in list) {
              if (path == 'root') {
                pathList.add('My Folders');
              } else {
                pathList.add(path.replaceRange(0, 1, path[0].toUpperCase()));
              }
            }
          } else if (state is PasswordList ||
              state is PaymentCardList ||
              state is SecureNotesList) {
            context.read<DatabaseBloc>().add(GetFolder(path: _path));
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: 550.w,
            child: Card(
              color: Theme.of(context).backgroundColor,
              margin: EdgeInsets.all(10.w),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.w)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  state is Fetching
                      ? Container(
                          height: 414.w,
                          alignment: Alignment.center,
                          child: const LoadingSmall(),
                        )
                      : SizedBox(
                          height: 414.w,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(22.w, 10.w, 20.w, 0),
                                  child: Text(
                                    'Select Folder',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                _buildFolderPath(),
                                SizedBox(height: 10.w),
                                _buildFolderList(_folder),
                              ],
                            ),
                          ),
                        ),
                  Container(
                    height: 60.w,
                    padding: EdgeInsets.only(right: 20.w),
                    color: Theme.of(context).cardColor,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        selectedIndex != 999
                            ? TextButton(
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, selectedPath);
                                },
                              )
                            : const SizedBox.shrink(),
                        SizedBox(width: 10.w),
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 56.w,
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.fromLTRB(10.w, 0.w, 13.w, 0.w),
      alignment: Alignment.centerLeft,
      child: IconButton(
        iconSize: 34.w,
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 26.w,
        ),
        onPressed: () {
          if (_path != 'root') {
            _path = _path.substring(
                0, _path.length - _folder.folderName.length - 1);
            context.read<DatabaseBloc>().add(GetFolder(path: _path));
          }
        },
      ),
    );
  }

  Widget _buildFolderPath() {
    return Container(
      padding: EdgeInsets.only(left: 22.w),
      height: 30.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: pathList.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (pathList.length == index) {
                  return SizedBox(
                    width: 80.w,
                  );
                } else {
                  return Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Text(
                        pathList[index],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        if (index != pathList.length - 1) {
                          List<String> pathList2 = _folder.path.split('/');
                          String newPath = pathList2[0];
                          for (int i = 1; i <= index; i++) {
                            newPath = newPath + '/' + pathList2[i];
                          }
                          _path = newPath;
                          setState(() {
                            selectedIndex = 999;
                            selectedPath = widget.startPath;
                          });
                          context
                              .read<DatabaseBloc>()
                              .add(GetFolder(path: _path));
                        }
                      },
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
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFolderList(Folder folder) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20.w, 1.w, 20.w, 10.w),
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: folder.subFolderList.length,
      itemBuilder: (context, index) {
        String folderName = folder.subFolderList[index].split('/').last;
        if (selectedPath == folder.subFolderList[index]) {
          selectedIndex = index;
        }
        return InkWell(
          onTap: () {
            setState(() {
              if (selectedIndex != index) {
                selectedIndex = index;
                selectedPath = folder.subFolderList[index];
              } else {
                selectedIndex = 999;
              }
            });
          },
          borderRadius: BorderRadius.circular(18.w),
          child: Container(
            height: 68.w,
            padding: EdgeInsets.only(
                top: 11.w,
                bottom: 11.w,
                left: selectedIndex != index ? 5.w : 15.w,
                right: selectedIndex != index ? 0.w : 5.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(18.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/folderIcon.png',
                  height: 27.w,
                  width: 34.w,
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  folderName.replaceRange(0, 1, folderName[0].toUpperCase()),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.w,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedIndex = 999;
                    });
                    context
                        .read<DatabaseBloc>()
                        .add(GetFolder(path: folder.subFolderList[index]));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
