import 'package:equatable/equatable.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';

class DatabaseState extends Equatable{
  @override
  List<Object?> get props => [];
}

class Fetching extends DatabaseState{

}

class PasswordList extends DatabaseState{
  final List<Password> list;

  PasswordList(this.list);
}

class PaymentCardList extends DatabaseState{
  final List<PaymentCard> list;

  PaymentCardList(this.list);
}

class SecureNotesList extends DatabaseState{
  final List<SecureNote> list;

  SecureNotesList(this.list);
}