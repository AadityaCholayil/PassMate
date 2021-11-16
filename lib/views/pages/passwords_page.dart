import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:like_button/like_button.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/model/sort_methods.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/formpages/password_form.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  PasswordCategory passwordCategory = PasswordCategory.all;
  SortMethod sortMethod = SortMethod.recentlyAdded;
  String sortLabel = '';
  String? searchLabel;
  List<Password> completePasswordList = [];
  List<Password> passwordList = [];
  bool favourites = false;

  @override
  void initState() {
    super.initState();
    sortMethod =
        context.read<AppBloc>().userData.sortMethod ?? SortMethod.recentlyAdded;
    sortLabel = sortMethodMessages[sortMethod.index];
    context.read<DatabaseBloc>().add(GetPasswords(
        sortMethod: sortMethod, passwordCategory: passwordCategory));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseBloc, DatabaseState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        print('widget rebuilt');
        if (state is PasswordList) {
          passwordList = state.list;
          passwordCategory = state.passwordCategory;
          favourites = state.favourites;
          sortMethod = state.sortMethod;
          searchLabel = state.search;
          sortLabel = sortMethodMessages[sortMethod.index];
          if (passwordCategory == PasswordCategory.all && !favourites) {
            completePasswordList = state.completeList;
          }
          if (state.completeList != state.list) {
            completePasswordList = state.completeList;
          }
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 28.w, top: 13.w),
              child: Text(
                'Passwords',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            SizedBox(height: 13.w),
            completePasswordList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearch(context),
                      SizedBox(height: 15.w),
                      _buildChipRow(),
                      SizedBox(height: 10.w),
                      _buildSortDropDownBox(context),
                      SizedBox(height: 10.w),
                    ],
                  )
                : const SizedBox.shrink(),
            state is Fetching
                ? Container(
                    height: 180.w,
                    alignment: Alignment.center,
                    child: const LoadingSmall(),
                  )
                : completePasswordList.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        height: 320.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Start Adding Passwords',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'All your passwords will be secure\nusing AES-256 encryption.',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Flexible(
                        child: PasswordCardList(passwordList: passwordList),
                      ),
            SizedBox(
              height: passwordList.length < 3
                  ? passwordList.isEmpty
                      ? 30.h
                      : 250.h
                  : 0,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Material(
        borderRadius: BorderRadius.circular(15.w),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        child: TextFormField(
          initialValue: searchLabel,
          decoration: customInputDecoration(
            context: context,
            labelText: 'Search',
            isSearch: true,
          ),
          style: formTextStyle(context),
          onChanged: (val) {
            context.read<DatabaseBloc>().add(GetPasswords(
                  search: val,
                  passwordCategory: passwordCategory,
                  list: completePasswordList,
                ));
          },
        ),
      ),
    );
  }

  Widget _buildChipRow() {
    bool isDefault =
        passwordCategory == PasswordCategory.all && favourites == false;
    return SizedBox(
      height: 45.w,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20.w),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: (!isDefault && !favourites)
            ? PasswordCategory.values.length + 1
            : PasswordCategory.values.length,
        itemBuilder: (context, index) {
          bool selected = false;
          bool fav = false;
          String label = '';
          int? selectedIndex;
          PasswordCategory category = PasswordCategory.all;
          if (passwordCategory == PasswordCategory.all && !favourites) {
            label = PasswordCategory.values[index].toString().substring(17);
            category = PasswordCategory.values[index];
            if (index == 0) {
              label = 'Favourites';
              fav = true;
            }
          } else {
            selectedIndex = passwordCategory.index;
            if (selectedIndex == 0) {
              //favourites
              if (index != 0) {
                label = PasswordCategory.values[index].toString().substring(17);
                category = PasswordCategory.values[index];
              } else {
                selected = true;
                label = 'Favourites';
                fav = true;
              }
            } else {
              if (index != 0) {
                if (index == 1) {
                  label = 'Favourites';
                  fav = true;
                } else {
                  label = PasswordCategory.values[index - 1]
                      .toString()
                      .substring(17);
                  category = PasswordCategory.values[index - 1];
                }
              } else {
                selected = true;
                label = passwordCategory.toString().substring(17);
                category = PasswordCategory.values[index];
              }
            }
          }
          if (selectedIndex != null) {
            if (selectedIndex + 1 == index && selectedIndex != 0) {
              return const SizedBox.shrink();
            }
          }
          return Container(
            margin: EdgeInsets.only(right: 9.w),
            child: InkWell(
              onTap: () {
                print(category);
                context.read<DatabaseBloc>().add(GetPasswords(
                      search: searchLabel,
                      passwordCategory: category,
                      favourites: fav,
                      list: completePasswordList,
                    ));
              },
              child: Chip(
                elevation: 2,
                side: selected
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2)
                    : null,
                avatar: Icon(
                  passwordCategoryIcon[index],
                  size: 23.w,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                backgroundColor: Theme.of(context).cardColor,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.w),
                // padding: EdgeInsets.fromLTRB(12.w, 7.w, 12.w, 7.w),
                labelPadding: EdgeInsets.fromLTRB(10.w, 0, 6.w, 0),
                label: Text(
                  label.replaceRange(0, 1, label.substring(0, 1).toUpperCase()),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                  ),
                ),
                deleteIcon: Icon(
                  Icons.highlight_remove,
                  size: 25.w,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onDeleted: !selected
                    ? null
                    : () {
                        context.read<DatabaseBloc>().add(GetPasswords());
                      },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSortDropDownBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
      ),
      child: DropdownButton<SortMethod>(
        value: sortMethod,
        itemHeight: 55.w,
        items: <SortMethod>[
          SortMethod.values[0],
          SortMethod.values[1],
          SortMethod.values[2],
        ].map<DropdownMenuItem<SortMethod>>((value) {
          String label = sortMethodMessages[value.index];
          return DropdownMenuItem(
            value: value,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 7.w, 10.w, 7.w),
              child: Text(
                label,
                style: value == sortMethod
                    ? TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
              ),
            ),
          );
        }).toList(),
        underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down),
        iconEnabledColor: Theme.of(context).primaryColor,
        iconSize: 30.w,
        onChanged: (val) {
          sortMethod = val ?? sortMethod;
          context
              .read<DatabaseBloc>()
              .add(GetPasswords(sortMethod: sortMethod));
        },
      ),
    );
  }
}

class PasswordCardList extends StatelessWidget {
  const PasswordCardList({
    Key? key,
    required this.passwordList,
  }) : super(key: key);

  final List<Password> passwordList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: passwordList.length,
      itemBuilder: (context, index) {
        Password password = passwordList[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: PasswordCard(password: password),
        );
      },
    );
  }
}

class PasswordCard extends StatelessWidget {
  const PasswordCard({
    Key? key,
    required this.password,
  }) : super(key: key);

  final Password password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.w),
      height: 87.w,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.w),
        ),
        child: InkWell(
          onTap: () async {
            if (!ZoomDrawer.of(context)!.isOpen()) {
              password.printDetails();
              password.lastUsed = Timestamp.now();
              password.usage++;
              dynamic res = await showModalBottomSheet(
                context: context,
                barrierColor: Colors.black.withOpacity(0.25),
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return PasswordDetailCard(password: password);
                },
              );
              if (res != 'Deleted') {
                context
                    .read<DatabaseBloc>()
                    .add(UpdatePassword(password, false, password.path));
              }
            }
          },
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.w),
            ),
            child: Row(
              children: [
                Container(
                  height: 65.w,
                  width: 65.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(15.w),
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2))),
                  padding: EdgeInsets.all(9.w),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Image.network(
                      password.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 19.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      password.siteName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      password.email,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordDetailCard extends StatefulWidget {
  const PasswordDetailCard({
    Key? key,
    required this.password,
  }) : super(key: key);

  final Password password;

  @override
  State<PasswordDetailCard> createState() => _PasswordDetailCardState();
}

class _PasswordDetailCardState extends State<PasswordDetailCard> {
  late Password password;
  bool showPassword = false;
  late String categoryText;

  @override
  void initState() {
    super.initState();
    password = widget.password;
    categoryText = password.category.toString().substring(17).replaceRange(
        0, 1, password.category.toString().substring(17)[0].toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700.w,
      child: Card(
        margin: EdgeInsets.all(10.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
        child: Container(
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5.w),
                    height: 60.w,
                    width: 60.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.5.w,
                      ),
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                    child: Container(
                      height: 50.w,
                      width: 50.w,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: Image.network(
                        password.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    password.siteName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                  const Spacer(),
                  LikeButton(
                    size: 35.w,
                    isLiked: password.favourite,
                    onTap: (value) async {
                      password.favourite = !value;
                      print(password.favourite);
                      context
                          .read<DatabaseBloc>()
                          .add(UpdatePassword(password, false, password.path));
                      return !value;
                    },
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
              SizedBox(height: 13.w),
              SizedBox(
                height: 195.w,
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(context, 'Site URL'),
                        _buildContent(context, password.siteUrl),
                        SizedBox(height: 10.w),
                        _buildLabel(context, 'Email/Username'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildContent(context, password.email),
                            IconButton(
                              icon: Icon(Icons.copy, size: 28.w),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: password.email));
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        _buildLabel(context, 'Password'),
                        Row(
                          children: [
                            _buildContent(
                                context,
                                showPassword
                                    ? password.password
                                    : '•' * password.password.length),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 28.w),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.copy, size: 28.w),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: password.password));
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        _buildLabel(context, 'Category'),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.w),
                          child: Row(
                            children: [
                              Icon(
                                passwordCategoryIcon[password.category.index],
                                size: 28.w,
                              ),
                              SizedBox(width: 20.w),
                              _buildContent(context, categoryText),
                            ],
                          ),
                        ),
                        password.note != 'null'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.w),
                                  _buildLabel(context, 'Note'),
                                  _buildContent(context, password.note),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 55.w,
                      width: 55.w,
                      child: Icon(
                        Icons.delete_outline_rounded,
                        size: 31.w,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<DatabaseBloc>(context)
                          .add(DeletePassword(password));
                      Navigator.pop(context, 'Deleted');
                    },
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomElevatedButton(
                      style: 0,
                      text: 'Edit Password',
                      onPressed: () {
                        print(password.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PasswordFormPage(password: password)),
                        ).then((value) {
                          BlocProvider.of<DatabaseBloc>(context)
                              .add(GetPasswords());
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.secondaryVariant,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text _buildContent(BuildContext context, String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
