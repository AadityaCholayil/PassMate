import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecureNoteFormPage extends StatefulWidget {
  final SecureNote? secureNote;

  const SecureNoteFormPage({Key? key, this.secureNote}) : super(key: key);

  @override
  _SecureNoteFormPageState createState() => _SecureNoteFormPageState();
}

class _SecureNoteFormPageState extends State<SecureNoteFormPage> {
  String _id = '';
  String _path = 'root/default';
  String _title = '';
  String _content = '';
  bool _favourite = false;
  int _usage = 0;
  Timestamp? _timeAdded;

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.secureNote != null) {
      _isUpdate = true;
      _id = widget.secureNote!.id;
      _path = widget.secureNote!.path;
      _title = widget.secureNote!.title;
      _content = widget.secureNote!.content;
      _favourite = widget.secureNote!.favourite;
      _usage = widget.secureNote!.usage;
      _timeAdded = widget.secureNote!.timeAdded;
    }
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: Text(
        _isUpdate ? 'Update' : 'Submit',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      onPressed: () {
        SecureNote secureNote = SecureNote(
          id: _id,
          path: _path,
          title: _title,
          content: _content,
          favourite: _favourite,
          usage: _usage,
          lastUsed: Timestamp.now(),
          timeAdded: _timeAdded,
        );
        SecureNote secureNote2 = SecureNote(
          id: widget.secureNote?.id ?? '',
          path: 'root/default',
          title: 'Test',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing. Quisque ligula neque, venenatis sit amet sem eget, vestibulum maximus turpis.',
          favourite: false,
          usage: 0,
          lastUsed: Timestamp.now(),
          timeAdded: Timestamp.now(),
        );
        if (!_isUpdate) {
          context.read<DatabaseBloc>().add(AddSecureNote(secureNote2));
        } else {
          context.read<DatabaseBloc>().add(
              UpdateSecureNote(secureNote2, true, widget.secureNote!.path));
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
            if (state is SecureNoteFormState) {
              if (state == SecureNoteFormState.success) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await Future.delayed(const Duration(milliseconds: 300));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(showCustomSnackBar(context, state.message));
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const Text(
                  'Add Secure Note',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                _buildSubmitButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
