import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/model/sort_methods.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';
import 'package:passmate/views/formpages/secure_note_form.dart';

class SecureNotesPage extends StatefulWidget {
  const SecureNotesPage({Key? key}) : super(key: key);

  @override
  _SecureNotesPageState createState() => _SecureNotesPageState();
}

class _SecureNotesPageState extends State<SecureNotesPage> {
  SortMethod sortMethod = SortMethod.recentlyAdded;
  String sortLabel = '';
  String? searchLabel;
  List<SecureNote> completeSecureNoteList = [];
  List<SecureNote> secureNoteList = [];
  bool favourites = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBloc, DatabaseState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if(state is SecureNotesPageState){
          if(state.pageState == PageState.loading){
            return const FixedLoading();
          }
          if(state.pageState == PageState.error){
            return const FixedLoading();
          }
          if (state.pageState == PageState.success){
            secureNoteList = state.list;
            favourites = state.favourites;
            sortMethod = state.sortMethod;
            sortLabel = sortMethodMessages[sortMethod.index];
            if (!favourites) {
              completeSecureNoteList = state.completeList;
            }
            if (state.completeList != state.list) {
              completeSecureNoteList = state.completeList;
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 28.w, top: 13.w),
                  child: Text(
                    'Secure Notes',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                SizedBox(height: 13.w),
                _buildSearch(context),
                SizedBox(height: 5.w),
                completeSecureNoteList.isNotEmpty
                    ? _buildSortDropDownBox(context)
                    : const SizedBox.shrink(),
                SizedBox(height: 5.w),
                state is Fetching
                    ? Container(
                  height: 180.w,
                  alignment: Alignment.center,
                  child: const LoadingSmall(),
                )
                    : completeSecureNoteList.isEmpty
                    ? Container(
                  alignment: Alignment.center,
                  height: 420.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Start adding Notes',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'All your Notes will be secure\nusing AES-256 encryption.',
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
                  SecureNoteCardList(secureNoteList: secureNoteList),
                ),
                SizedBox(
                  height: secureNoteList.length < 3
                      ? (3 - secureNoteList.length) * 110.w
                      : 0,
                ),
              ],
            );
          }
        }
        return const FixedLoading();
      },
    );
  }

  Padding _buildSearch(BuildContext context) {
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
            context.read<DatabaseBloc>().add(GetSecureNotes(
                  search: val,
                  list: completeSecureNoteList,
                ));
          },
        ),
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
              .add(GetSecureNotes(sortMethod: sortMethod));
        },
      ),
    );
  }
}

class SecureNoteCardList extends StatelessWidget {
  const SecureNoteCardList({
    Key? key,
    required this.secureNoteList,
  }) : super(key: key);

  final List<SecureNote> secureNoteList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: secureNoteList.length,
      itemBuilder: (context, index) {
        SecureNote secureNote = secureNoteList[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SecureNoteCard(secureNote: secureNote),
        );
      },
    );
  }
}

class SecureNoteCard extends StatelessWidget {
  const SecureNoteCard({
    Key? key,
    required this.secureNote,
  }) : super(key: key);

  final SecureNote secureNote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 13.w),
      // height: 110.w,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: InkWell(
          onTap: () async {
            if (!ZoomDrawer.of(context)!.isOpen()) {
              secureNote.lastUsed = Timestamp.now();
              secureNote.usage++;
              var res = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SecureNoteFormPage(secureNote: secureNote)),
              );
              if(res == 'Updated'){
                context.read<DatabaseBloc>().add(GetSecureNotes());
              } else if(res!='Deleted') {
                print('Updating');
                context
                    .read<DatabaseBloc>()
                    .add(UpdateSecureNote(secureNote, false, secureNote.path));
              }
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 18.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  secureNote.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 3.w),
                Text(
                  secureNote.content,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
