import 'package:equatable/equatable.dart';
import 'package:passmate/model/old_password.dart';
import 'package:passmate/model/old_payment_card.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/model/user/sort_methods.dart';

class DatabaseEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPasswords extends DatabaseEvents {
  final List<OldPassword>? list;
  final PasswordCategory passwordCategory;
  final bool favourites;
  final String? search;
  final SortMethod? sortMethod;

  GetPasswords({
    this.list,
    this.passwordCategory = PasswordCategory.all,
    this.favourites = false,
    this.search,
    this.sortMethod,
  });
}

class AddPassword extends DatabaseEvents {
  final OldPassword password;

  AddPassword(this.password);
}

class UpdatePassword extends DatabaseEvents {
  final OldPassword password;
  final bool fromForm;
  final String oldPath;

  UpdatePassword(
    this.password,
    this.fromForm,
    this.oldPath,
  );
}

class DeletePassword extends DatabaseEvents {
  final OldPassword password;

  DeletePassword(this.password);
}

class GetPaymentCards extends DatabaseEvents {
  final List<OldPaymentCard>? list;
  final PaymentCardType paymentCardType;
  final bool favourites;
  final String? search;
  final SortMethod? sortMethod;

  GetPaymentCards({
    this.list,
    this.paymentCardType = PaymentCardType.all,
    this.favourites = false,
    this.search,
    this.sortMethod,
  });
}

class AddPaymentCard extends DatabaseEvents {
  final OldPaymentCard paymentCard;

  AddPaymentCard(this.paymentCard);
}

class UpdatePaymentCard extends DatabaseEvents {
  final bool fromForm;
  final OldPaymentCard paymentCard;
  final String oldPath;

  UpdatePaymentCard(
    this.paymentCard,
    this.fromForm,
    this.oldPath,
  );
}

class DeletePaymentCard extends DatabaseEvents {
  final OldPaymentCard paymentCard;

  DeletePaymentCard(this.paymentCard);
}

class GetSecureNotes extends DatabaseEvents {
  final List<SecureNote>? list;
  final bool favourites;
  final String? search;
  final SortMethod? sortMethod;

  GetSecureNotes({
    this.list,
    this.favourites = false,
    this.search,
    this.sortMethod,
  });
}

class AddSecureNote extends DatabaseEvents {
  final SecureNote secureNote;

  AddSecureNote(this.secureNote);
}

class UpdateSecureNote extends DatabaseEvents {
  final SecureNote secureNote;
  final bool fromForm;
  final String oldPath;

  UpdateSecureNote(
    this.secureNote,
    this.fromForm,
    this.oldPath,
  );
}

class DeleteSecureNote extends DatabaseEvents {
  final SecureNote secureNote;

  DeleteSecureNote(this.secureNote);
}

class GetFolder extends DatabaseEvents {
  final String path;

  GetFolder({
    this.path = 'root',
  });
}

class AddFolder extends DatabaseEvents {
  final String currentPath;
  final String newFolderName;

  AddFolder({
    required this.currentPath,
    required this.newFolderName,
  });
}

class RenameFolder extends DatabaseEvents {
  final String currentPath;
  final String oldPath;
  final String newPath;

  RenameFolder({
    this.currentPath = '/',
    this.oldPath = '/',
    this.newPath = '/',
  });
}

class DeleteFolder extends DatabaseEvents {
  final String currentPath;
  final String path;

  DeleteFolder({
    this.currentPath = '/',
    this.path = '/',
  });
}
