import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
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
  List<Password> passwordList = [];
  bool favourites = false;

  @override
  void initState() {
    super.initState();
    context.read<DatabaseBloc>().add(GetPasswords(passwordCategory: passwordCategory));
  }

  SizedBox _buildChipRow() {
    bool isDefault =
        passwordCategory == PasswordCategory.all && favourites==false;
    return SizedBox(
      height: 45.w,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20.w),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: (!isDefault && !favourites)?PasswordCategory.values.length+1:PasswordCategory.values.length,
        itemBuilder: (context, index) {
          bool selected = false;
          bool fav = false;
          String label = '';
          int? selectedIndex;
          PasswordCategory category = PasswordCategory.all;
          if (passwordCategory == PasswordCategory.all && !favourites) {
            label = PasswordCategory.values[index].toString().substring(17);
            category = PasswordCategory.values[index];
            if(index==0){
              label = 'Favourites';
              fav = true;
            }
          } else {
            selectedIndex = passwordCategory.index;
            if(selectedIndex==0){
              //favourites
              if (index!=0) {
                label = PasswordCategory.values[index].toString().substring(17);
                category = PasswordCategory.values[index];
              } else {
                selected = true;
                label = 'Favourites';
                fav = true;
              }
            } else {
              if (index!=0) {
                if(index==1){
                  label = 'Favourites';
                  fav = true;
                } else {
                  label = PasswordCategory.values[index-1].toString().substring(17);
                  category = PasswordCategory.values[index-1];
                }
              } else {
                selected = true;
                label = passwordCategory.toString().substring(17);
                category = PasswordCategory.values[index];
              }
            }
          }
          if (selectedIndex!=null) {
            if(selectedIndex+1==index&&selectedIndex!=0){
              return SizedBox.shrink();
            }
          }
          return Container(
            margin: EdgeInsets.only(right: 7.w),
            child: InkWell(
              onTap: () {
                  context
                      .read<DatabaseBloc>()
                      .add(GetPasswords(passwordCategory: category, favourites: fav));
              },
              child: Chip(
                side: selected
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2)
                    : null,
                avatar: Icon(
                  Icons.favorite_border_rounded,
                  size: 25.w,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                backgroundColor: Colors.white,
                // padding: EdgeInsets.symmetric(horizontal: 12.w,),
                padding: EdgeInsets.fromLTRB(12.w, 7.w, 12.w, 7.w),
                labelPadding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 2.w),
                label: Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 17,
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
                        context
                            .read<DatabaseBloc>()
                            .add(GetPasswords());
                      },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseBloc, DatabaseState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is PasswordList) {
          passwordList = state.list;
          passwordCategory = state.passwordCategory;
          favourites = state.favourites;
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 22.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextFormField(
                isSearch: true,
                labelText: 'Search',
                onChanged: (val) {
                  context
                      .read<DatabaseBloc>()
                      .add(GetPasswords(passwordCategory: passwordCategory, search: val));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.w, top: 13.w, bottom: 3.w),
              child: Text(
                'Passwords',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            _buildChipRow(),
            SizedBox(height: 10.w),
            Padding(
              padding: EdgeInsets.only(left: 28.w, bottom: 10.w),
              child: Text(
                'Frequently Used',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            state is Fetching
                ? Center(child: LoadingSmall())
                : Flexible(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: passwordList.length,
                      itemBuilder: (context, index) {
                        Password password = passwordList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: PasswordCard(password: password),
                        );
                      },
                    ),
                  )
          ],
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
      margin: EdgeInsets.only(bottom: 13.w),
      height: 87.w,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.w),
        ),
        child: InkWell(
          onTap: () {
            if (!ZoomDrawer.of(context)!.isOpen()) {
              password.lastUsed = Timestamp.now();
              password.usage++;
              context
                  .read<DatabaseBloc>()
                  .add(UpdatePassword(false, password, password.path));
              showModalBottomSheet(
                context: context,
                barrierColor: Colors.black.withOpacity(0.25),
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return PasswordDetailCard(password: password);
                },
              );
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
                      color: Color(0xFFFFF5FD),
                      borderRadius: BorderRadius.circular(15.w),
                      border: Border.all(color: Color(0xFFF5E9F3))),
                  padding: EdgeInsets.all(9.w),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Image.network(
                      password.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 17.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${password.siteName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      '${password.email}',
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
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

class PasswordDetailCard extends StatelessWidget {
  const PasswordDetailCard({
    Key? key,
    required this.password,
  }) : super(key: key);

  final Password password;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.w,
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      BlocProvider.of<DatabaseBloc>(context)
                          .add(DeletePassword(password, PasswordCategory.all));
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Edit Password'),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
