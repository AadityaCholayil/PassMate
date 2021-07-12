import 'package:equatable/equatable.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/model/sort_methods.dart';

class DatabaseEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPasswords extends DatabaseEvents {
  final PasswordCategory passwordCategory;
  final bool favourites;
  final String? search;
  final List<Password>? list;
  final List<Password>? completeList;
  final SortMethod? sortMethod;

  GetPasswords(
      {this.passwordCategory = PasswordCategory.all,
      this.favourites = false,
      this.search,
      this.list,
      this.completeList,
      this.sortMethod});
}

class AddPassword extends DatabaseEvents {
  final Password password;

  AddPassword(this.password);
}

class UpdatePassword extends DatabaseEvents {
  final bool fromForm;
  final Password password;
  final String oldPath;

  UpdatePassword(this.fromForm, this.password, this.oldPath);
}

class DeletePassword extends DatabaseEvents {
  final Password password;
  final PasswordCategory passwordCategory;

  DeletePassword(this.password, this.passwordCategory);
}

class GetPaymentCards extends DatabaseEvents {
  final CardType cardType;

  GetPaymentCards(this.cardType);
}

class AddPaymentCard extends DatabaseEvents {
  final PaymentCard paymentCard;

  AddPaymentCard(this.paymentCard);
}

class UpdatePaymentCard extends DatabaseEvents {
  final PaymentCard paymentCard;

  UpdatePaymentCard(this.paymentCard);
}

class DeletePaymentCard extends DatabaseEvents {
  final PaymentCard paymentCard;

  DeletePaymentCard(this.paymentCard);
}

class GetSecureNote extends DatabaseEvents {}

class AddSecureNote extends DatabaseEvents {
  final SecureNote secureNote;

  AddSecureNote(this.secureNote);
}

class UpdateSecureNote extends DatabaseEvents {
  final SecureNote secureNote;

  UpdateSecureNote(this.secureNote);
}

class DeleteSecureNote extends DatabaseEvents {
  final SecureNote secureNote;

  DeleteSecureNote(this.secureNote);
}
