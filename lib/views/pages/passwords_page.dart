import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/shared/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/views/formpages/password_form.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  PasswordCategory passwordCategory = PasswordCategory.All;
  List<Password> passwordList = [];

  @override
  void initState() {
    super.initState();
    context.read<DatabaseBloc>().add(GetPasswords(passwordCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(25.w)
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocConsumer<DatabaseBloc, DatabaseState>(
            listenWhen: (previous, current) => previous != current,
            buildWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state is PasswordList) {
                passwordList = state.list;
                state.list.forEach((element) {
                  print(element);
                });
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      'Passwords',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground
                      ),
                    ),
                  ),
                  state is Fetching
                      ? LoadingSmall()
                      : Flexible(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: passwordList.length,
                            itemBuilder: (context, index) {
                              Password password = passwordList[index];
                              return PasswordCard(password: password);
                            },
                          ),
                        )
                ],
              );
            },
          ),
        ),
      ),
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
                    border: Border.all(color: Color(0xFFF5E9F3))
                  ),
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
                          .add(DeletePassword(password, PasswordCategory.All));
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
                            .add(GetPasswords(PasswordCategory.All));
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
