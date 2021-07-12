import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/repositories/encryption_repository.dart';

class DatabaseBloc extends Bloc<DatabaseEvents, DatabaseState> {
  UserData userData;
  DatabaseRepository databaseRepository;
  EncryptionRepository encryptionRepository;

  DatabaseBloc(
      {required this.userData,
      required this.databaseRepository,
      required this.encryptionRepository})
      : super(Fetching());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvents event) async* {
    if (event is GetPasswords) {
      yield* _mapGetPasswordsToState(event);
    } else if (event is AddPassword) {
      yield* _mapAddPasswordToState(event);
    } else if (event is UpdatePassword) {
      yield* _mapUpdatePasswordToState(event);
    } else if (event is DeletePassword) {
      yield* _mapDeletePasswordToState(event);
    } else if (event is GetPaymentCards) {
    } else if (event is AddPaymentCard) {
    } else if (event is UpdatePaymentCard) {
    } else if (event is DeletePaymentCard) {
    } else if (event is GetSecureNote) {
    } else if (event is AddSecureNote) {
    } else if (event is UpdateSecureNote) {
    } else if (event is DeleteSecureNote) {}
  }

  Stream<DatabaseState> _mapGetPasswordsToState(GetPasswords event) async* {
    yield Fetching();
    List<Password> list = [];
    if (event.list == null) {
      print('hello');
      list = await databaseRepository.getPasswords(event.passwordCategory);
      list.forEach((element) async {
        await element.decrypt(encryptionRepository);
      });
    } else {
      if (event.favourites) {
        list = event.list!.where((element) => element.favourite).toList();
      }
      if (event.passwordCategory != PasswordCategory.all) {
        list = event.list!
            .where((password) => password.category == event.passwordCategory)
            .toList();
      }
    }
    list.sort((pass1, pass2) {
      if (event.sortMethod!.index==0) {
        return pass2.timeAdded!.compareTo(pass1.timeAdded!);
      } else if(event.sortMethod!.index==1) {
        return pass2.usage.compareTo(pass2.usage);
      } else {
        return pass2.lastUsed!.compareTo(pass1.lastUsed!);
      }
    });
    yield PasswordList(list, event.passwordCategory, event.favourites);
  }

  Stream<DatabaseState> _mapAddPasswordToState(AddPassword event) async* {
    yield PasswordFormState.loading;
    await event.password.encrypt(encryptionRepository);
    print(event.password);
    String res = await databaseRepository.addPassword(event.password);
    print(res);
    if (res == 'Success') {
      yield PasswordFormState.success;
    } else {
      yield PasswordFormState.errorOccurred;
    }
  }

  Stream<DatabaseState> _mapUpdatePasswordToState(UpdatePassword event) async* {
    await event.password.encrypt(encryptionRepository);
    if (event.fromForm) {
      yield PasswordFormState.loading;
      String res = await databaseRepository.updatePassword(
          event.password, event.oldPath);
      if (res == 'Success') {
        yield PasswordFormState.success;
      } else {
        yield PasswordFormState.errorOccurred;
      }
    } else {
      await databaseRepository.updatePassword(event.password, event.oldPath);
      await event.password.decrypt(encryptionRepository);
    }
  }

  Stream<DatabaseState> _mapDeletePasswordToState(DeletePassword event) async* {
    yield Fetching();
    await event.password.encrypt(encryptionRepository);
    await databaseRepository.deletePassword(event.password);
    add(GetPasswords(passwordCategory: event.passwordCategory));
  }
}
