import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/folder.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/repositories/encryption_repository.dart';

class DatabaseBloc extends Bloc<DatabaseEvents, DatabaseState> {
  UserData userData;
  DatabaseRepository databaseRepository;
  EncryptionRepository encryptionRepository;
  List<String>? folderList;

  DatabaseBloc({
    required this.userData,
    required this.databaseRepository,
    required this.encryptionRepository,
  }) : super(Fetching()) {
    if (userData != UserData.empty) {
      updateFolderList();
    }
  }

  Future updateFolderList() async {
    folderList = [];
    FolderData data = await databaseRepository.getFolder();
    for (var path in data.folderList) {
      if (path.split('/').length == 2) {
        folderList!.add(path);
      }
    }
  }

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvents event) async* {
    if (folderList == null && userData != UserData.empty) {
      await updateFolderList();
    }
    if (event is GetPasswords) {
      yield* _mapGetPasswordsToState(event);
    } else if (event is AddPassword) {
      yield* _mapAddPasswordToState(event);
    } else if (event is UpdatePassword) {
      yield* _mapUpdatePasswordToState(event);
    } else if (event is DeletePassword) {
      yield* _mapDeletePasswordToState(event);
    } else if (event is GetPaymentCards) {
      yield* _mapGetPaymentCardsToState(event);
    } else if (event is AddPaymentCard) {
      yield* _mapAddPaymentCardToState(event);
    } else if (event is UpdatePaymentCard) {
      yield* _mapUpdatePaymentCardToState(event);
    } else if (event is DeletePaymentCard) {
      yield* _mapDeletePaymentCardToState(event);
    } else if (event is GetSecureNotes) {
      yield* _mapGetSecureNotesToState(event);
    } else if (event is AddSecureNote) {
      yield* _mapAddSecureNoteToState(event);
    } else if (event is UpdateSecureNote) {
      yield* _mapUpdateSecureNoteToState(event);
    } else if (event is DeleteSecureNote) {
      yield* _mapDeleteSecureNoteToState(event);
    } else if (event is GetFolder) {
      yield* _mapGetFolderToState(event);
    } else if (event is AddFolder) {
      yield* _mapAddFolderToState(event);
    } else if (event is RenameFolder) {
      yield* _mapRenameFolderToState(event);
    } else if (event is DeleteFolder) {
      yield* _mapDeleteFolderToState(event);
    }
  }

  Stream<DatabaseState> _mapGetPasswordsToState(GetPasswords event) async* {
    yield Fetching();
    if (userData.sortMethod == null) {
      userData = await databaseRepository.completeUserData;
    }
    if (event.sortMethod != null) {
      if (event.sortMethod != userData.sortMethod) {
        UserData userData2 = UserData(
          uid: userData.uid,
          email: userData.email,
          firstName: userData.firstName,
          lastName: userData.lastName,
          photoUrl: userData.photoUrl,
          pinSet: userData.pinSet,
          sortMethod: event.sortMethod,
        );
        userData = userData2;
        databaseRepository.updateUserData(userData2);
      }
    }
    List<Password> list = [];
    List<Password> completeList = [];
    if (event.list == null) {
      list = await databaseRepository.getPasswords();
      for (var element in list) {
        await element.decrypt(encryptionRepository);
      }
      completeList = list;
    } else {
      completeList = event.list ?? [];
      list = event.list ?? [];
      if (event.favourites) {
        list = event.list!.where((element) => element.favourite).toList();
      }
      if (event.passwordCategory != PasswordCategory.all) {
        list = event.list!
            .where((password) => password.category == event.passwordCategory)
            .toList();
      }
      if (event.search != null) {
        print('search: ${event.search}');
        list = list.where((element) {
          return element.siteName.toLowerCase().contains('${event.search}');
        }).toList();
        print(list);
      }
    }
    list.sort((pass1, pass2) {
      if (userData.sortMethod!.index == 0) {
        return pass2.timeAdded!.compareTo(pass1.timeAdded!);
      } else if (userData.sortMethod!.index == 1) {
        return pass2.usage.compareTo(pass1.usage);
      } else {
        return pass2.lastUsed!.compareTo(pass1.lastUsed!);
      }
    });
    yield PasswordList(list, completeList, event.search, event.passwordCategory,
        userData.sortMethod!, event.favourites);
  }

  Stream<DatabaseState> _mapAddPasswordToState(AddPassword event) async* {
    yield PasswordFormState.loading;
    String? imageUrl = await getFavicon(event.password.siteUrl);
    if (imageUrl != null) {
      event.password.imageUrl = imageUrl;
    } else {
      event.password.imageUrl = await databaseRepository
          .getFaviconFromStorage(event.password.siteName);
    }
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
    Password _password = event.password;
    if (event.fromForm) {
      yield PasswordFormState.loading;
      String? imageUrl = await getFavicon(_password.siteUrl);
      if (imageUrl != null) {
        _password.imageUrl = imageUrl;
      } else {
        _password.imageUrl = await databaseRepository
            .getFaviconFromStorage(_password.siteName);
      }
      await _password.encrypt(encryptionRepository);
      print(_password);
      String res =
          await databaseRepository.updatePassword(_password, event.oldPath);
      print(res);
      if (res == 'Success') {
        yield PasswordFormState.success;
      } else {
        yield PasswordFormState.errorOccurred;
      }
    } else {
      await _password.encrypt(encryptionRepository);
      await databaseRepository.updatePassword(_password, event.oldPath);
      await _password.decrypt(encryptionRepository);
    }
  }

  Stream<DatabaseState> _mapDeletePasswordToState(DeletePassword event) async* {
    yield Fetching();
    await event.password.encrypt(encryptionRepository);
    await databaseRepository.deletePassword(event.password);
    add(GetPasswords());
  }

  Stream<DatabaseState> _mapGetPaymentCardsToState(
      GetPaymentCards event) async* {
    yield Fetching();
    if (userData.sortMethod == null) {
      userData = await databaseRepository.completeUserData;
    }
    if (event.sortMethod != null) {
      if (event.sortMethod != userData.sortMethod) {
        UserData userData2 = UserData(
          uid: userData.uid,
          email: userData.email,
          firstName: userData.firstName,
          lastName: userData.lastName,
          photoUrl: userData.photoUrl,
          pinSet: userData.pinSet,
          sortMethod: event.sortMethod,
        );
        userData = userData2;
        databaseRepository.updateUserData(userData2);
      }
    }
    List<PaymentCard> list = [];
    List<PaymentCard> completeList = [];
    if (event.list == null) {
      list = await databaseRepository.getPaymentCards();
      for (var element in list) {
        await element.decrypt(encryptionRepository);
      }
      completeList = list;
    } else {
      completeList = event.list ?? [];
      list = event.list ?? [];
      if (event.favourites) {
        list = event.list!.where((element) => element.favourite).toList();
      }
      if (event.paymentCardType != PaymentCardType.all) {
        list = event.list!
            .where(
                (paymentCard) => paymentCard.cardType == event.paymentCardType)
            .toList();
      }
      if (event.search != null) {
        print('search: ${event.search}');
        list = list.where((element) {
          return element.bankName.toLowerCase().contains('${event.search}');
        }).toList();
        print(list);
      }
    }
    list.sort((card1, card2) {
      if (userData.sortMethod!.index == 0) {
        return card2.timeAdded!.compareTo(card1.timeAdded!);
      } else if (userData.sortMethod!.index == 1) {
        return card2.usage.compareTo(card1.usage);
      } else {
        return card2.lastUsed!.compareTo(card1.lastUsed!);
      }
    });
    yield PaymentCardList(list, completeList, event.search,
        event.paymentCardType, userData.sortMethod!, event.favourites);
  }

  Stream<DatabaseState> _mapAddPaymentCardToState(AddPaymentCard event) async* {
    yield PaymentCardFormState.loading;
    await event.paymentCard.encrypt(encryptionRepository);
    print(event.paymentCard);
    String res = await databaseRepository.addPaymentCard(event.paymentCard);
    print(res);
    if (res == 'Success') {
      yield PaymentCardFormState.success;
    } else {
      yield PaymentCardFormState.errorOccurred;
    }
  }

  Stream<DatabaseState> _mapUpdatePaymentCardToState(
      UpdatePaymentCard event) async* {
    await event.paymentCard.encrypt(encryptionRepository);
    if (event.fromForm) {
      yield PaymentCardFormState.loading;
      String res = await databaseRepository.updatePaymentCard(
          event.paymentCard, event.oldPath);
      if (res == 'Success') {
        yield PaymentCardFormState.success;
      } else {
        yield PaymentCardFormState.errorOccurred;
      }
    } else {
      await databaseRepository.updatePaymentCard(
          event.paymentCard, event.oldPath);
      await event.paymentCard.decrypt(encryptionRepository);
    }
  }

  Stream<DatabaseState> _mapDeletePaymentCardToState(
      DeletePaymentCard event) async* {
    yield Fetching();
    await event.paymentCard.encrypt(encryptionRepository);
    await databaseRepository.deletePaymentCard(event.paymentCard);
    add(GetPaymentCards());
  }

  Stream<DatabaseState> _mapGetSecureNotesToState(GetSecureNotes event) async* {
    yield Fetching();
    if (userData.sortMethod == null) {
      userData = await databaseRepository.completeUserData;
    }
    if (event.sortMethod != null) {
      if (event.sortMethod != userData.sortMethod) {
        UserData userData2 = UserData(
          uid: userData.uid,
          email: userData.email,
          firstName: userData.firstName,
          lastName: userData.lastName,
          photoUrl: userData.photoUrl,
          pinSet: userData.pinSet,
          sortMethod: event.sortMethod,
        );
        userData = userData2;
        databaseRepository.updateUserData(userData2);
      }
    }
    List<SecureNote> list = [];
    List<SecureNote> completeList = [];
    if (event.list == null) {
      list = await databaseRepository.getSecureNotes();
      for (var element in list) {
        await element.decrypt(encryptionRepository);
      }
      completeList = list;
    } else {
      completeList = event.list ?? [];
      list = event.list ?? [];
      if (event.favourites) {
        list = event.list!.where((element) => element.favourite).toList();
      }
      if (event.search != null) {
        print('search: ${event.search}');
        list = list.where((element) {
          return element.title.toLowerCase().contains('${event.search}');
        }).toList();
        print(list);
      }
    }
    list.sort((note1, note2) {
      if (userData.sortMethod!.index == 0) {
        return note2.timeAdded!.compareTo(note1.timeAdded!);
      } else if (userData.sortMethod!.index == 1) {
        return note2.usage.compareTo(note1.usage);
      } else {
        return note2.lastUsed!.compareTo(note1.lastUsed!);
      }
    });
    yield SecureNotesList(list, completeList, event.search,
        userData.sortMethod!, event.favourites);
  }

  Stream<DatabaseState> _mapAddSecureNoteToState(AddSecureNote event) async* {
    yield SecureNoteFormState.loading;
    await event.secureNote.encrypt(encryptionRepository);
    print(event.secureNote);
    String res = await databaseRepository.addSecureNote(event.secureNote);
    print(res);
    if (res == 'Success') {
      yield SecureNoteFormState.success;
    } else {
      yield SecureNoteFormState.errorOccurred;
    }
  }

  Stream<DatabaseState> _mapUpdateSecureNoteToState(
      UpdateSecureNote event) async* {
    await event.secureNote.encrypt(encryptionRepository);
    if (event.fromForm) {
      yield SecureNoteFormState.loading;
      String res = await databaseRepository.updateSecureNote(
          event.secureNote, event.oldPath);
      if (res == 'Success') {
        yield SecureNoteFormState.success;
      } else {
        yield SecureNoteFormState.errorOccurred;
      }
    } else {
      await databaseRepository.updateSecureNote(
          event.secureNote, event.oldPath);
      await event.secureNote.decrypt(encryptionRepository);
      add(GetSecureNotes());
    }
  }

  Stream<DatabaseState> _mapDeleteSecureNoteToState(
      DeleteSecureNote event) async* {
    yield Fetching();
    await event.secureNote.encrypt(encryptionRepository);
    await databaseRepository.deleteSecureNote(event.secureNote);
    add(GetSecureNotes());
  }

  Stream<DatabaseState> _mapGetFolderToState(GetFolder event) async* {
    yield Fetching();
    FolderData data = await databaseRepository.getFolder();
    List<String> folderList = [];
    List<Password> passwordList = [];
    List<PaymentCard> paymentCardList = [];
    List<SecureNote> secureNoteList = [];
    String folderName = event.path.split('/').last;
    if (event.path != 'root') {
      passwordList = await databaseRepository.getPasswords(path: event.path);
      for (var element in passwordList) {
        await element.decrypt(encryptionRepository);
      }
      paymentCardList =
          await databaseRepository.getPaymentCards(path: event.path);
      for (var element in paymentCardList) {
        await element.decrypt(encryptionRepository);
      }
      secureNoteList =
          await databaseRepository.getSecureNotes(path: event.path);
      for (var element in secureNoteList) {
        await element.decrypt(encryptionRepository);
      }
      for (var path in data.folderList) {
        List<String> pathList = path.split('/');
        if (pathList[pathList.length - 2] == folderName) {
          folderList.add(path);
        }
      }
    } else {
      for (var path in data.folderList) {
        if (path.split('/').length == 2) {
          folderList.add(path);
        }
      }
    }
    if (folderName == 'root') {
      folderName = 'My Folders';
    }
    Folder folder = Folder(
      folderName: folderName.replaceRange(0, 1, folderName[0].toUpperCase()),
      path: event.path,
      subFolderList: folderList,
      passwordList: passwordList,
      paymentCardList: paymentCardList,
      secureNotesList: secureNoteList,
    );
    yield FolderListState(folder);
  }

  Stream<DatabaseState> _mapAddFolderToState(AddFolder event) async* {
    yield Fetching();
    String newFolderPath = '${event.currentPath}/${event.newFolderName}';
    String newFolderPathTemp = newFolderPath;
    try {
      for (int i = 2; i < 100; i++) {
        if (!folderList!.contains(newFolderPathTemp)) {
          await databaseRepository.addFolder(folderName: newFolderPathTemp);
          break;
        } else {
          newFolderPathTemp = '$newFolderPath($i)';
        }
      }
    } on Exception catch (_) {}
    add(GetFolder(path: event.currentPath));
  }

  Stream<DatabaseState> _mapRenameFolderToState(RenameFolder event) async* {
    yield Fetching();
    try {
      await databaseRepository.renameFolder(
          oldPath: event.oldPath, newPath: event.newPath);
    } on Exception catch (_) {}
    add(GetFolder(path: event.currentPath));
  }

  Stream<DatabaseState> _mapDeleteFolderToState(DeleteFolder event) async* {
    yield Fetching();
    try {
      await databaseRepository.deleteFolder(folderName: event.path);
    } on Exception catch (_) {}
    add(GetFolder(path: event.currentPath));
  }
}
