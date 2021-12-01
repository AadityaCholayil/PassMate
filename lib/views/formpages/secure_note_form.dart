import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/temp_error.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<DatabaseBloc, DatabaseState>(
      listener: (context, state) async {
        if (state is SecureNoteFormState) {
          if (state == SecureNoteFormState.success) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // await Future.delayed(const Duration(milliseconds: 300));
            Navigator.pop(context, 'Updated');
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(showCustomSnackBar(context, state.message));
          }
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive
              print('Layout Changed');
              if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                // LandScape
                return const TempError(pageName: 'Secure Note Form Screen');
              }
              return _buildSecureNoteFormPortrait(context, colorScheme);
            }
          ),
        );
      },
    );
  }

  Scaffold _buildSecureNoteFormPortrait(
      BuildContext context, ColorScheme colorScheme) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.w),
              Row(
                children: [
                  const CustomBackButton(),
                  const Spacer(),
                  IconButton(
                    // padding: EdgeInsets.fromLTRB(0, 9.w, 0.w, 9.w),
                    iconSize: 33.w,
                    color: Theme.of(context).primaryColor,
                    icon: const Icon(Icons.folder_outlined),
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                  ),
                  _isUpdate
                      ? IconButton(
                          // padding: EdgeInsets.fromLTRB(0, 9.w, 0.w, 9.w),
                          iconSize: 33.w,
                          color: Theme.of(context).primaryColor,
                          icon: const Icon(Icons.delete_outlined),
                          onPressed: () {
                            BlocProvider.of<DatabaseBloc>(context)
                                .add(DeleteSecureNote(widget.secureNote!));
                            Navigator.pop(context, 'Deleted');
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 12.w),
              TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
                initialValue: _title,
                onSaved: (value) {
                  _title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value == '') {
                    return 'This field cannot be empty!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 7.w),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Start typing here..',
                    hintStyle: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  // maxLines: 15,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  initialValue: _content,
                  onSaved: (value) {
                    _content = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'This field cannot be empty!';
                    }
                    return null;
                  },
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 5.w),
              //   child: Text(
              //     'Add Secure Notes',
              //     style: TextStyle(
              //       color: Theme.of(context).colorScheme.onBackground,
              //       fontSize: 42,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(7.w),
        height: 65.w,
        width: 65.w,
        child: IconButton(
          icon: Icon(
            Icons.check,
            size: 32.w,
            color: colorScheme.onPrimary,
          ),
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            setState(() {
              _formKey.currentState!.save();
            });
            SecureNote secureNote = SecureNote(
              id: _id,
              path: _path,
              title: _title,
              content: _content,
              favourite: _favourite,
              usage: _usage,
              lastUsed: Timestamp.now(),
              timeAdded: _timeAdded ?? Timestamp.now(),
            );
            // SecureNote secureNote2 = SecureNote(
            //   id: widget.secureNote?.id ?? '',
            //   path: 'root/default',
            //   title: 'Test',
            //   content:
            //       'Lorem ipsum dolor sit amet, consectetur adipiscing. Quisque ligula neque, venenatis sit amet sem eget, vestibulum maximus turpis.',
            //   favourite: false,
            //   usage: 0,
            //   lastUsed: Timestamp.now(),
            //   timeAdded: Timestamp.now(),
            // );
            if (!_isUpdate) {
              context.read<DatabaseBloc>().add(AddSecureNote(secureNote));
            } else {
              context.read<DatabaseBloc>().add(
                  UpdateSecureNote(secureNote, true, widget.secureNote!.path));
            }
          },
        ),
      ),
    );
  }
}
