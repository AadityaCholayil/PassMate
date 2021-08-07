import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({Key? key}) : super(key: key);

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseBloc, DatabaseState>(
      listenWhen: (previous, current) => previous!=current,
      buildWhen: (previous, current) => previous!=current,
      listener: (context, state){

      },
      builder: (context, state){
        return Container(

        );
      },
    );
  }
}
