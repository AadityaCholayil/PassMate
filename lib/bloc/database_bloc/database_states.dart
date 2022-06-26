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

class PasswordPageState extends DatabaseState {
  final List<Password> list;
  final List<Password> completeList;
  final String? search;
  final PasswordCategory passwordCategory;
  final SortMethod sortMethod;
  final bool favourites;
  final PageState pageState;

  PasswordPageState({
    this.list = const [],
    this.completeList = const [],
    this.search = '',
    this.passwordCategory = PasswordCategory.all,
    this.sortMethod = SortMethod.frequentlyUsed,
    this.favourites = false,
    this.pageState = PageState.init,
  });

  @override
  String toString() {
    // return '$list, $completeList, $search, $passwordCategory, $sortMethod, $favourites, $pageState';
    return 'PasswordPageState';
  }

  @override
  List<Object?> get props =>
      [list, completeList, search, passwordCategory, sortMethod, favourites];
}

class PaymentCardPageState extends DatabaseState {
  final List<PaymentCard> list;
  final List<PaymentCard> completeList;
  final String? search;
  final PaymentCardType paymentCardType;
  final SortMethod sortMethod;
  final bool favourites;
  final PageState pageState;

  PaymentCardPageState({
    this.list = const [],
    this.completeList = const [],
    this.search,
    this.paymentCardType = PaymentCardType.all,
    this.sortMethod = SortMethod.frequentlyUsed,
    this.favourites = false,
    this.pageState = PageState.init,
  });

  @override
  List<Object?> get props => [
        list,
        completeList,
        search,
        paymentCardType,
        sortMethod,
        favourites,
      ];
  
  @override
  String toString() {
    // return '$list, $completeList, $search, $passwordCategory, $sortMethod, $favourites, $pageState';
    return 'PaymentCardPageState';
  }
}

class SecureNotesPageState extends DatabaseState {
  final List<SecureNote> list;
  final List<SecureNote> completeList;
  final String? search;
  final SortMethod sortMethod;
  final bool favourites;
  final PageState pageState;

  SecureNotesPageState({
    this.list = const [],
    this.completeList = const [],
    this.search,
    this.sortMethod = SortMethod.frequentlyUsed,
    this.favourites = false,
    this.pageState = PageState.init,
  });

  @override
  List<Object?> get props => [
        list,
        completeList,
        search,
        sortMethod,
        favourites,
      ];

  @override
  String toString() {
    // return '$list, $completeList, $search, $passwordCategory, $sortMethod, $favourites, $pageState';
    return 'SecureNotesPageState';
  }
}

class FolderPageState extends DatabaseState {
  final Folder folder;
  final PageState pageState;

  FolderPageState({required this.folder, this.pageState = PageState.init});

  @override
  List<Object?> get props => [folder, pageState];
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

enum PageState { init, loading, success, error }
