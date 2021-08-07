import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/shared/custom_snackbar.dart';

class PasswordFormPage extends StatefulWidget {
  final Password? password;

  const PasswordFormPage({Key? key, this.password}) : super(key: key);

  @override
  _PasswordFormPageState createState() => _PasswordFormPageState();
}

class _PasswordFormPageState extends State<PasswordFormPage> {
  String _id = '';
  String _path = '/default';
  String _siteName = '';
  String _siteUrl = '';
  String _email = '';
  String _password = '';
  String _imageUrl = 'https://api.faviconkit.com/google.com/144';
  String _note = '';
  PasswordCategory _category = PasswordCategory.others;
  bool _favourite = false;
  int _usage = 0;
  Timestamp? _timeAdded;

  bool _isUpdate = false;

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
      _imageUrl = widget.password!.imageUrl;
      _note = widget.password!.note;
      _category = widget.password!.category;
      _favourite = widget.password!.favourite;
      _usage = widget.password!.usage;
      _timeAdded = widget.password!.timeAdded;
    }
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: Text(
        _isUpdate ? 'Update' : 'Submit',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      onPressed: () {
        Password password = Password(
          id: _id,
          path: _path,
          siteName: _siteName,
          siteUrl: _siteUrl,
          email: _email,
          password: _password,
          imageUrl: _imageUrl,
          note: _note,
          category: _category,
          favourite: _favourite,
          usage: _usage,
          lastUsed: Timestamp.now(),
          timeAdded: _timeAdded,
        );
        Password password2 = Password(
          id: widget.password?.id??'',
          path: '/default',
          siteName: 'Google',
          siteUrl: 'www.google.com',
          email: 'aaditya@xyz.com',
          password: 'aadi123',
          imageUrl: 'https://api.faviconkit.com/www.google.com/144',
          note: 'Bruh',
          category: PasswordCategory.social,
          favourite: false,
          usage: 3,
          lastUsed: Timestamp.now(),
          timeAdded: Timestamp.now(),
        );
        if (!_isUpdate) {
          context.read<DatabaseBloc>().add(AddPassword(password2));
        } else {
          context
              .read<DatabaseBloc>()
              .add(UpdatePassword(password2, true, widget.password!.path));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<DatabaseBloc, DatabaseState>(
          listener: (context, state) async {
            if (state is PasswordFormState) {
              if (state == PasswordFormState.success) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await Future.delayed(Duration(milliseconds: 300));
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
              child: Column(
                children: [
                  Text(
                    'Add Password',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  _buildSubmitButton(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
