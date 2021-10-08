import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/folder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/loading.dart';
import 'package:passmate/views/pages/passwords_page.dart';
import 'package:passmate/views/pages/payment_card_page.dart';
import 'package:passmate/views/pages/secure_notes_page.dart';

class FolderPage extends StatefulWidget {
  final String path;

  const FolderPage({Key? key, this.path = 'root'}) : super(key: key);

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  String _path = '';
  Folder _folder = Folder.empty;
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
    return BlocConsumer<DatabaseBloc, DatabaseState>(
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
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state is Fetching
                  ? <Widget>[
                      _buildAppBar(context),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        alignment: Alignment.center,
                        child: const LoadingSmall(),
                      ),
                    ]
                  : <Widget>[
                      _buildAppBar(context),
                      Padding(
                        padding: EdgeInsets.fromLTRB(22.w, 10.w, 20.w, 0),
                        child: Text(
                          _folder.folderName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 42,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader(context, 'Passwords'),
                                PasswordCardList(
                                    passwordList: _folder.passwordList),
                              ],
                            )
                          : const SizedBox.shrink(),
                      _folder.paymentCardList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader(context, 'Payment Cards'),
                                PaymentCardTileList(
                                    paymentCardList: _folder.paymentCardList),
                              ],
                            )
                          : const SizedBox.shrink(),
                      _folder.secureNotesList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader(context, 'Secure Notes'),
                                SecureNoteCardList(
                                    secureNoteList: _folder.secureNotesList),
                              ],
                            )
                          : const SizedBox.shrink(),
                      SizedBox(height: 100.w),
                    ],
            ),
          ),
        );
      },
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
              ZoomDrawer.of(context)!.toggle();
            },
          ),
        ],
      ),
    );
  }

  Padding _buildHeader(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(left: 22.w, top: 7.w, bottom: 11.w),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 21,
          fontWeight: FontWeight.w600,
        ),
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
      padding: EdgeInsets.fromLTRB(20.w, 1.w, 20.w, 10.w),
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: folder.subFolderList.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 20.w,
        childAspectRatio: 157.w / 100.w,
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
                onTap: () {},
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
          return Card(
            elevation: 3,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.only(right: 1.w, left: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: InkWell(
              onTap: () {
                context
                    .read<DatabaseBloc>()
                    .add(GetFolder(path: folder.subFolderList[index]));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(18.w, 18.w, 18.w, 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/folderIcon.png',
                      height: 27.w,
                      width: 34.w,
                    ),
                    SizedBox(
                      height: 14.w,
                    ),
                    Text(
                      folderName.replaceRange(0, 1, folderName[0].toUpperCase()),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
