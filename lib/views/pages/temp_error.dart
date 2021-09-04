import 'package:flutter/material.dart';

class TempError extends StatefulWidget {
  final String pageName;

  const TempError({Key? key, required this.pageName}) : super(key: key);

  @override
  _TempErrorState createState() => _TempErrorState();
}

class _TempErrorState extends State<TempError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          '${widget.pageName}\nLandscape mode is coming soon.',
          style: TextStyle(
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
