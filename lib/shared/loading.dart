import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: CircularProgressIndicator()
        ),
      ),
    );
  }
}

class LoadingSmall extends StatelessWidget {
  final double height;

  const LoadingSmall({double? height, Key? key})
      : this.height=height ?? 50,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      child: CircularProgressIndicator(),
    );
  }
}

