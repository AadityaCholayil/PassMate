import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/model/old_secure_note.dart';
import 'package:passmate/model/user/sort_methods.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';
import 'package:passmate/theme/theme.dart';
import 'package:passmate/views/formpages/secure_note_form.dart';
import 'package:passmate/shared/custom_animated_app_bar.dart';

class SecureNotesPage extends StatefulWidget {
  const SecureNotesPage({Key? key}) : super(key: key);

  @override
  _SecureNotesPageState createState() => _SecureNotesPageState();
}

class _SecureNotesPageState extends State<SecureNotesPage> {
  SortMethod sortMethod = SortMethod.recentlyAdded;
  String sortLabel = '';
  String? searchLabel;
  List<OldSecureNote> completeSecureNoteList = [];
  List<OldSecureNote> secureNoteList = [];
  bool favourites = false;

  @override
  void initState() {
    super.initState();
    SortMethod sortMethod =
        context.read<AppBloc>().userData.sortMethod ?? SortMethod.recentlyAdded;
    context.read<DatabaseBloc>().add(GetSecureNotes(sortMethod: sortMethod));
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
              if (state is SecureNotesPageState) {
                if (state.pageState == PageState.loading) {
                  return const FixedLoading();
                }
                if (state.pageState == PageState.error) {
                  return const FixedLoading();
                }
                if (state.pageState == PageState.success) {
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
                        padding: EdgeInsets.only(left: 32.w, top: 20.w),
                        child: Text(
                          'Secure Notes',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      SizedBox(height: 13.w),
                      _buildSearch(context),
                      SizedBox(height: 8.w),
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
                                  child: SecureNoteCardList(
                                      secureNoteList: secureNoteList),
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
          ),
        ),
      ),
    );
  }

  Padding _buildSearch(BuildContext context) {
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
              padding: EdgeInsets.fromLTRB(0, 7.w, 10.w, 7.w),
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

  final List<OldSecureNote> secureNoteList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              for (int i = 0; i < secureNoteList.length; i++)
                if (i % 2 == 0) SecureNoteCard(secureNote: secureNoteList[i]),
            ],
          ),
          SizedBox(width: 20.w),
          Column(
            children: [
              for (int i = 0; i < secureNoteList.length; i++)
                if (i % 2 == 1) SecureNoteCard(secureNote: secureNoteList[i]),
            ],
          ),
        ],
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 14.w),
    //   child: Wrap(
    //     children: [
    //       for (var secureNote in secureNoteList)
    //         Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 10.w),
    //           child: SecureNoteCard(secureNote: secureNote),
    //         ),
    //     ],
    //   ),
    // );
  }
}

class SecureNoteCard extends StatelessWidget {
  const SecureNoteCard({
    Key? key,
    required this.secureNote,
  }) : super(key: key);

  final OldSecureNote secureNote;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!ZoomDrawer.of(context)!.isOpen()) {
          secureNote.lastUsed = Timestamp.now();
          secureNote.usage++;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SecureNoteFormPage(secureNote: secureNote)),
          );
        }
      },
      child: Container(
        width: 173.w,
        padding: EdgeInsets.fromLTRB(15.w, 13.w, 15.w, 17.w),
        margin: EdgeInsets.only(bottom: 20.w),
        decoration: BoxDecoration(
          color: CustomTheme.card,
          borderRadius: BorderRadius.circular(20.w),
          boxShadow: [
            BoxShadow(
              color: CustomTheme.cardShadow,
              blurRadius: 10,
              offset: Offset(4.w, 4.w),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              secureNote.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 6.w),
            Text(
              secureNote.content,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 4.w),
          ],
        ),
      ),
    );
  }
}
