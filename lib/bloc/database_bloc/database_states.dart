import 'package:equatable/equatable.dart';
import 'package:passmate/model/folder.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/model/sort_methods.dart';

abstract class DatabaseState extends Equatable {}

class Fetching extends DatabaseState {
  @override
  List<Object?> get props => ['Fetching'];
}

class PasswordList extends DatabaseState {
  final List<Password> list;
  final List<Password> completeList;
  final String? search;
  final PasswordCategory passwordCategory;
  final SortMethod sortMethod;
  final bool favourites;

  PasswordList(
    this.list,
    this.completeList,
    this.search,
    this.passwordCategory,
    this.sortMethod,
    this.favourites,
  );

  @override
  List<Object?> get props => ['PasswordList'];
}

class PaymentCardList extends DatabaseState {
  final List<PaymentCard> list;
  final List<PaymentCard> completeList;
  final String? search;
  final PaymentCardType paymentCardType;
  final SortMethod sortMethod;
  final bool favourites;

  PaymentCardList(
    this.list,
    this.completeList,
    this.search,
    this.paymentCardType,
    this.sortMethod,
    this.favourites,
  );

  @override
  List<Object?> get props => ['PaymentCardList'];
}

class SecureNotesList extends DatabaseState {
  final List<SecureNote> list;
  final List<SecureNote> completeList;
  final String? search;
  final SortMethod sortMethod;
  final bool favourites;

  SecureNotesList(this.list, this.completeList, this.search, this.sortMethod,
      this.favourites);

  @override
  List<Object?> get props => ['SecureNotesList'];
}

class FolderListState extends DatabaseState {
  final Folder folder;

  FolderListState(this.folder);

  @override
  List<Object?> get props => ['FolderListState'];
}

class PasswordFormState extends DatabaseState {
  final String message;

  PasswordFormState(this.message);

  static PasswordFormState loading = PasswordFormState('Loading');

  static PasswordFormState errorOccurred =
      PasswordFormState('Something went wrong');

  static PasswordFormState success = PasswordFormState('Success');

  @override
  List<Object?> get props => [message];
}

class PaymentCardFormState extends DatabaseState {
  final String message;

  PaymentCardFormState(this.message);

  static PaymentCardFormState loading = PaymentCardFormState('Loading');

  static PaymentCardFormState errorOccurred =
      PaymentCardFormState('Something went wrong');

  static PaymentCardFormState success = PaymentCardFormState('Success');

  @override
  List<Object?> get props => [message];
}

class SecureNoteFormState extends DatabaseState {
  final String message;

  SecureNoteFormState(this.message);

  static SecureNoteFormState loading = SecureNoteFormState('Loading');

  static SecureNoteFormState errorOccurred =
      SecureNoteFormState('Something went wrong');

  static SecureNoteFormState success = SecureNoteFormState('Success');

  static SecureNoteFormState deleted = SecureNoteFormState('Deleted');

  @override
  List<Object?> get props => [message];
}
