import 'package:flutter/material.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/main_screen_provider.dart';
import 'package:provider/provider.dart';

class TempError extends StatefulWidget {
  final String pageName;

  const TempError({Key? key, required this.pageName}) : super(key: key);

  @override
  _TempErrorState createState() => _TempErrorState();
}

class _TempErrorState extends State<TempError> {
  @override
  Widget build(BuildContext context) {
    String page = '';
    if (widget.pageName=='HomeScreen') {
      int pageNo = context.read<MenuProvider>().currentPage;
      page = ['Passwords', 'Payment Cards', 'Secure Notes', 'Password Generator', 'Folders', for (String path in context.read<DatabaseBloc>().folderList??[]) 'Folder: $path'][pageNo];
      print('$pageNo: $page');
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PassMate'),
      // ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.pageName} ${widget.pageName=='HomeScreen'?'($page)':''}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Landscape mode is coming soon.\nTill then kindly open on a Smartphone.',
              style: TextStyle(
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
