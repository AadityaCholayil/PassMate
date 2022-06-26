import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/folder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';
import 'package:passmate/theme/theme.dart';
import 'package:passmate/views/pages/passwords_page.dart';
import 'package:passmate/views/pages/payment_card_page.dart';
import 'package:passmate/views/pages/secure_notes_page.dart';
import 'package:passmate/views/settings/settings_page.dart';

class FolderPage extends StatefulWidget {
  final String path;

  const FolderPage({Key? key, this.path = 'root'}) : super(key: key);

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  String _path = '';
  Folder _folder = Folder.empty();
  List<String> pathList = [];
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    if (_path == '') {
      _path = widget.path;
    }
    context.read<DatabaseBloc>().add(GetFolder(path: _path));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.path != _path && _path != '') {
      _path = widget.path;
      context.read<DatabaseBloc>().add(GetFolder(path: _path));
    }
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<DatabaseBloc, DatabaseState>(
          listenWhen: (previous, current) => previous != current,
          buildWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is PasswordPageState ||
                state is PaymentCardPageState ||
                state is SecureNotesPageState) {
              context.read<DatabaseBloc>().add(GetFolder(path: _path));
            }
          },
          builder: (context, state) {
            if (state is FolderPageState) {
              if (state.pageState == PageState.loading) {
                return const FixedLoading();
              }
              if (state.pageState == PageState.error) {
                return const FixedLoading();
              }
              if (state.pageState == PageState.success) {
                _folder = state.folder;
                List<String> list = _folder.path.split('/');
                pathList = [];
                _path = _folder.path;
                for (var path in list) {
                  if (path == 'root') {
                    pathList.add('My Folders');
                  } else {
                    pathList
                        .add(path.replaceRange(0, 1, path[0].toUpperCase()));
                  }
                }
                return WillPopScope(
                  onWillPop: () {
                    print('pop');
                    if (_path != 'root') {
                      _path = _path.substring(
                          0, _path.length - _folder.folderName.length - 1);
                      context.read<DatabaseBloc>().add(GetFolder(path: _path));
                      return Future.value(false);
                    } else {
                      return Future.value(true);
                    }
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAppBar(context),
                        state is Fetching
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                alignment: Alignment.center,
                                child: const LoadingSmall(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        28.w, 10.w, 20.w, 0),
                                    child: Text(
                                      _folder.folderName,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  _buildFolderPath(),
                                  SizedBox(height: 10.w),
                                  _buildHeader(context, 'Folders'),
                                  FolderList(folder: _folder),
                                  SizedBox(height: 5.w),
                                  _folder.passwordList.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildHeader(context, 'Passwords'),
                                            PasswordCardList(
                                                passwordList:
                                                    _folder.passwordList),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  _folder.paymentCardList.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildHeader(
                                                context, 'Payment Cards'),
                                            PaymentCardTileList(
                                                paymentCardList:
                                                    _folder.paymentCardList),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  _folder.secureNotesList.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildHeader(
                                                context, 'Secure Notes'),
                                            SecureNoteCardList(
                                                secureNoteList:
                                                    _folder.secureNotesList),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(height: 100.w),
                                ],
                              ),
                      ],
                    ),
                  ),
                );
              }
            }
            return const FixedLoading();
          },
        ),
      ),
    );
  }

  Padding _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Row(
        children: [
          IconButton(
            iconSize: 38.w,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notes_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 38.w,
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
          const Spacer(),
          IconButton(
            iconSize: 34.w,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.settings_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
        ],
      ),
    );
  }

  Padding _buildHeader(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(left: 28.w, top: 7.w, bottom: 11.w),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFolderPath() {
    return Container(
      padding: EdgeInsets.only(left: 28.w),
      height: 30.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.separated(
              controller: _controller,
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
                if (index == pathList.length - 1) {
                  Timer(
                      const Duration(milliseconds: 100),
                      () => _controller.animateTo(
                            _controller.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                          ));
                }
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
}

class FolderList extends StatelessWidget {
  final Folder folder;

  const FolderList({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(24.w, 1.w, 24.w, 10.w),
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: folder.subFolderList.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.w,
        childAspectRatio: 157.w / 98.w,
      ),
      itemBuilder: (context, index) {
        if (folder.subFolderList.length == index) {
          return DottedBorder(
            radius: Radius.circular(20.w),
            dashPattern: [7.w, 4.w],
            borderType: BorderType.RRect,
            strokeWidth: 2.w,
            color: Theme.of(context).primaryColor,
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(20.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.w),
                onTap: () async {
                  await showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.25),
                    // backgroundColor: Colors.transparent,
                    builder: (context) {
                      return AddFolderDialog(currentPath: folder.path);
                    },
                  );
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 32.w,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'New',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          String folderName = folder.subFolderList[index].split('/').last;
          return InkWell(
            onTap: () {
              context
                  .read<DatabaseBloc>()
                  .add(GetFolder(path: folder.subFolderList[index]));
            },
            onLongPress: () async {
              await showModalBottomSheet(
                context: context,
                barrierColor: Colors.black.withOpacity(0.25),
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return FolderDetails(
                      currentPath: folder.path,
                      path: folder.subFolderList[index]);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(18.w, 18.w, 18.w, 5.w),
              decoration: BoxDecoration(
                color: CustomTheme.card,
                borderRadius: BorderRadius.circular(20.w),
                boxShadow: shadow,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/folderIcon.png',
                    height: 27.w,
                    width: 34.w,
                  ),
                  // SizedBox(
                  //   height: 14.w,
                  // ),
                  const Spacer(),
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
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class AddFolderDialog extends StatefulWidget {
  final String currentPath;

  const AddFolderDialog({Key? key, required this.currentPath})
      : super(key: key);

  @override
  State<AddFolderDialog> createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String folderName = '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Card(
        margin: EdgeInsets.all(10.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
        child: Container(
          padding: EdgeInsets.all(15.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Folder',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.w, bottom: 20.w),
                  child: TextFormField(
                    style: formTextStyle(context),
                    decoration: customInputDecoration(
                      context: context,
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'This field cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      folderName = value ?? '';
                    },
                  ),
                ),
                CustomElevatedButton(
                  text: 'Confirm',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    context.read<DatabaseBloc>().add(AddFolder(
                        currentPath: widget.currentPath,
                        newFolderName: folderName));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FolderDetails extends StatefulWidget {
  final String currentPath;
  final String path;

  const FolderDetails({Key? key, required this.currentPath, required this.path})
      : super(key: key);

  @override
  _FolderDetailsState createState() => _FolderDetailsState();
}

class _FolderDetailsState extends State<FolderDetails> {
  String currentPath = '';
  String path = '';

  @override
  void initState() {
    super.initState();
    currentPath = widget.currentPath;
    path = widget.path;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.all(10.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              path
                  .split('/')
                  .last
                  .replaceRange(0, 1, path.split('/').last[0].toUpperCase()),
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 10.w),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Rename',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.drive_file_rename_outline,
                size: 26.w,
                color: colorScheme.primary,
              ),
              onTap: () async {
                Navigator.pop(context);
                await showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.25),
                  // backgroundColor: Colors.transparent,
                  builder: (context) {
                    return RenameFolderDialog(
                      path: path,
                      currentPath: currentPath,
                    );
                  },
                );
              },
            ),
            Divider(thickness: 2.w),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Delete',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.delete_outlined,
                size: 26.w,
                color: colorScheme.primary,
              ),
              onTap: () {
                context
                    .read<DatabaseBloc>()
                    .add(DeleteFolder(path: path, currentPath: currentPath));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RenameFolderDialog extends StatefulWidget {
  final String currentPath;
  final String path;

  const RenameFolderDialog(
      {Key? key, required this.currentPath, required this.path})
      : super(key: key);

  @override
  _RenameFolderDialogState createState() => _RenameFolderDialogState();
}

class _RenameFolderDialogState extends State<RenameFolderDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String currentPath = '';
  String path = '';
  String newFolderName = '';

  @override
  void initState() {
    super.initState();
    path = widget.path;
    currentPath = widget.currentPath;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Card(
        margin: EdgeInsets.all(10.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
        child: Container(
          padding: EdgeInsets.all(15.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rename Folder',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.w, bottom: 20.w),
                  child: TextFormField(
                    initialValue: path.split('/').last.replaceRange(
                        0, 1, path.split('/').last[0].toUpperCase()),
                    style: formTextStyle(context),
                    decoration: customInputDecoration(
                      context: context,
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'This field cannot be empty!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      newFolderName = value ?? '';
                    },
                  ),
                ),
                CustomElevatedButton(
                  text: 'Confirm',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    String oldPath = path;
                    String newPath = '$currentPath/$newFolderName';
                    context.read<DatabaseBloc>().add(RenameFolder(
                        currentPath: currentPath,
                        oldPath: oldPath,
                        newPath: newPath));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
