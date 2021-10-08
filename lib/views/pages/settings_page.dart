import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text('Settings Page'),
            TextButton(
              child: const Text('Logout'),
              onPressed: (){
                context.read<AppBloc>().add(LoggedOut());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
