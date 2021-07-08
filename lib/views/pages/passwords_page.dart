import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/shared/loading.dart';

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
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Passwords',
                  style: TextStyle(fontSize: 40),
                ),
                state is Fetching
                    ? LoadingSmall()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: passwordList.length,
                          itemBuilder: (context, index) {
                            Password password = passwordList[index];
                            return PasswordCard(password: password);
                          },
                        ),
                      )
              ],
            ),
          );
        },
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
      margin: EdgeInsets.only(bottom: 5),
      height: 120,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
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
                  return Container(
                    height: 450,
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
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
                                    BlocProvider.of<DatabaseBloc>(context).add(DeletePassword(password, PasswordCategory.All));
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('Edit Password'),
                                  onPressed: () {
                                    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      password.imageUrl,
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    )),
                SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${password.siteName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      '${password.email}',
                      style: TextStyle(fontSize: 21),
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
