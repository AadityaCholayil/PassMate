import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        size: 100,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SpinKitCircle(
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class LoadingSmall extends StatelessWidget {
  final double size;

  const LoadingSmall({double? size, Key? key})
      : size=size ?? 90,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      child: SpinKitCircle(
        size: size,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class FixedLoading extends StatelessWidget {
  final double? height;

  const FixedLoading({
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 250.w,
      alignment: Alignment.center,
      child: const LoadingSmall(),
    );
  }
}

