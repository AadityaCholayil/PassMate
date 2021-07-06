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

class PasswordFormState extends DatabaseState{
  final String message;

  PasswordFormState(this.message);

  static PasswordFormState loading = PasswordFormState('Loading');

  static PasswordFormState errorOccurred = PasswordFormState('Something went wrong');

  static PasswordFormState success = PasswordFormState('Success');
}

class PaymentCardFormState extends DatabaseState{
  final String message;

  PaymentCardFormState(this.message);

  static PaymentCardFormState loading = PaymentCardFormState('Loading');

  static PaymentCardFormState errorOccurred = PaymentCardFormState('Something went wrong');

  static PaymentCardFormState success = PaymentCardFormState('Success');
}

class SecureNoteFormState extends DatabaseState{
  final String message;

  SecureNoteFormState(this.message);

  static SecureNoteFormState loading = SecureNoteFormState('Loading');

  static SecureNoteFormState errorOccurred = SecureNoteFormState('Something went wrong');

  static SecureNoteFormState success = SecureNoteFormState('Success');
}