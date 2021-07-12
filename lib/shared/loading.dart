import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  final double size;

  const LoadingSmall({double? size, Key? key})
      : this.size=size ?? 90,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SpinKitCircle(
        size: size,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

