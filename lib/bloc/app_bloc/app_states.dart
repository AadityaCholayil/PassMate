import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/user.dart';

@immutable
abstract class AppState extends Equatable {

  final UserData userData;
  AppState(this.userData, [List props = const []]) : super();
}

class Uninitialized extends AppState{
  final UserData userData;

  Uninitialized({required this.userData}) : super(userData);

  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [this.toString()];
}

class Unauthenticated extends AppState{
  final UserData userData;

  Unauthenticated({required this.userData}) : super(userData);

  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object?> get props => [this.toString()];
}

class PartiallyAuthenticated extends AppState{
  final UserData userData;

  PartiallyAuthenticated({required this.userData}) : super(userData);

  @override
  String toString() => 'PartiallyAuthenticated';

  @override
  List<Object?> get props => [this.toString()];
}

class FullyAuthenticated extends AppState{
  final UserData userData;

  FullyAuthenticated({required this.userData}) : super(userData);

  @override
  String toString() => 'FullyAuthenticated';

  @override
  List<Object?> get props => [this.toString()];
}
