import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/authentication_bloc/auth_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:passmate/model/password.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  PasswordCategory passwordCategory = PasswordCategory.All;

  @override
  void initState() {
    super.initState();
    context
        .read<DatabaseBloc>()
        .add(GetPasswords(passwordCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<DatabaseBloc, DatabaseState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is PasswordList) {
            state.list.forEach((element) {
              print(element);
            });
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Passwords\n${context.read<MenuProvider>().currentPage}',
                  style: TextStyle(fontSize: 25),
                ),
                ElevatedButton(
                  child: Text('Logout'),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                ),
                ElevatedButton(
                  child: Text('Bruh'),
                  onPressed: () {

                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
