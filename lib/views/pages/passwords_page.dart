import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:like_button/like_button.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/old_password.dart';
import 'package:passmate/model/user/sort_methods.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/theme/theme.dart';
import 'package:passmate/views/formpages/password_form.dart';
import 'package:passmate/shared/custom_animated_app_bar.dart';

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
  List<OldPassword> completePasswordList = [];
  List<OldPassword> passwordList = [];
  bool favourites = false;

  @override
  void initState() {
    super.initState();
    SortMethod sortMethod =
        context.read<AppBloc>().userData.sortMethod ?? SortMethod.recentlyAdded;
    context.read<DatabaseBloc>().add(GetPasswords(sortMethod: sortMethod));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const CustomFAB(),
        body: CustomAnimatedAppBar(
          child: BlocBuilder<DatabaseBloc, DatabaseState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is PasswordPageState) {
                if (state.pageState == PageState.loading) {
                  return const FixedLoading();
                }
                if (state.pageState == PageState.error) {
                  return const FixedLoading();
                }
                if (state.pageState == PageState.success) {
                  passwordList = state.list.toList();
                  passwordCategory = state.passwordCategory;
                  favourites = state.favourites;
                  sortMethod = state.sortMethod;
                  searchLabel = state.search;
                  sortLabel = sortMethodMessages[sortMethod.index];
                  if (passwordCategory == PasswordCategory.all && !favourites) {
                    completePasswordList = state.completeList.toList();
                  }
                  if (state.completeList != state.list) {
                    completePasswordList = state.completeList.toList();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 32.w, top: 20.w),
                        child: Text(
                          'Passwords',
                          style: TextStyle(
                            fontSize: 27,
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
                                SizedBox(height: 20.w),
                                _buildChipRow(),
                                // SizedBox(height: 5.w),
                                _buildSortDropDownBox(context),
                                SizedBox(height: 5.w),
                              ],
                            )
                          : const SizedBox.shrink(),
                      completePasswordList.isEmpty
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
                              child:
                                  PasswordCardList(passwordList: passwordList),
                            ),
                      SizedBox(
                        height: passwordList.length < 3
                            ? (3 - passwordList.length) * 70.w
                            : 0,
                      ),
                    ],
                  );
                }
              }
              return const FixedLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomShadow(
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
      height: 54.w,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 24.w),
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
            category = PasswordCategory.values[index];
            label = getPasswordCategoryStr(category);
            if (index == 0) {
              label = 'Favourites';
              fav = true;
            }
          } else {
            selectedIndex = passwordCategory.index;
            if (selectedIndex == 0) {
              //favourites
              if (index != 0) {
                category = PasswordCategory.values[index];
                label = getPasswordCategoryStr(category);
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
                  category = PasswordCategory.values[index - 1];
                  label = getPasswordCategoryStr(category);
                }
              } else {
                selected = true;
                label = getPasswordCategoryStr(passwordCategory);
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
            margin: EdgeInsets.only(right: 15.w, bottom: 10.w),
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
              child: Container(
                height: 44.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: CustomTheme.cardShadow,
                      blurRadius: 8,
                      offset: Offset(4.w, 4.w),
                    ),
                  ],
                  border: Border.all(
                      color:
                          selected ? CustomTheme.secondary : Colors.transparent,
                      width: 2.w),
                  color: CustomTheme.card,
                  borderRadius: BorderRadius.circular(40.w),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Icon(
                      passwordCategoryIcon[label],
                      size: 24.w,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      label,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected
                        ? Padding(
                            padding: EdgeInsets.only(left: 6.w, right: 10.w),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<DatabaseBloc>()
                                    .add(GetPasswords());
                              },
                              child: Icon(
                                Icons.highlight_remove,
                                size: 25.w,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          )
                        : SizedBox(width: 22.w),
                  ],
                ),
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
        left: 32.w,
      ),
      child: DropdownButton<SortMethod>(
        value: sortMethod,
        itemHeight: 50.w,
        items: <SortMethod>[
          SortMethod.values[0],
          SortMethod.values[1],
          SortMethod.values[2],
        ].map<DropdownMenuItem<SortMethod>>((value) {
          String label = sortMethodMessages[value.index];
          return DropdownMenuItem(
            value: value,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 2.w, 10.w, 2.w),
              child: Text(
                label,
                style: value == sortMethod
                    ? TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : TextStyle(
                        fontSize: 21,
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

  final List<OldPassword> passwordList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: passwordList.length,
      itemBuilder: (context, index) {
        OldPassword password = passwordList[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
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

  final OldPassword password;

  @override
  Widget build(BuildContext context) {
    return CustomShadow(
      height: 96.w,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.w),
        height: 96.w,
        decoration: BoxDecoration(
          color: CustomTheme.card,
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
              if (res != 'Deleted' && res != 'Updated') {
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
                  height: 78.w,
                  width: 78.w,
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
                    const SizedBox(height: 3),
                    Text(
                      password.email,
                      style: const TextStyle(fontSize: 14),
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

  final OldPassword password;

  @override
  State<PasswordDetailCard> createState() => _PasswordDetailCardState();
}

class _PasswordDetailCardState extends State<PasswordDetailCard> {
  late OldPassword password;
  bool showPassword = false;
  late String categoryText;

  @override
  void initState() {
    super.initState();
    password = widget.password;
    categoryText = getPasswordCategoryStr(password.category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.w,
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
                    height: 55.w,
                    width: 55.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.5.w,
                      ),
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                    child: Container(
                      height: 45.w,
                      width: 45.w,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: Image.network(
                        password.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, trace) {
                          print(error);
                          return Center(
                            child: Image.asset(
                              "assets/error.png",
                              width: 70.w,
                              height: 70.w,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    password.siteName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                  const Spacer(),
                  LikeButton(
                    size: 32.w,
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
                height: 245.w,
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
                              icon: Icon(Icons.copy, size: 25.w),
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
                                  size: 25.w),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.copy, size: 25.w),
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
                                passwordCategoryIcon[
                                    getPasswordCategoryStr(password.category)],
                                size: 24.w,
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
                          Navigator.pop(context, 'Updated');
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
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
