import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/repositories/encryption_repository.dart';

class DatabaseBloc extends Bloc<DatabaseEvents, DatabaseState>{

  final UserData userData;
  final DatabaseRepository databaseRepository;
  final EncryptionRepository encryptionRepository;

  DatabaseBloc({required this.userData, required this.databaseRepository, required this.encryptionRepository}) : super(Fetching());

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvents event) async* {
    if(event is GetPasswords){
      yield* _mapGetPasswordsToState(event);
    } else if(event is AddPassword){
      yield* _mapAddPasswordToState(event);
    } else if(event is UpdatePassword){
      yield* _mapUpdatePasswordToState(event);
    } else if(event is DeletePassword){
      yield* _mapDeletePasswordToState(event);
    } else if(event is GetPaymentCards){

    } else if(event is AddPaymentCard){

    } else if(event is UpdatePaymentCard){

    } else if(event is DeletePaymentCard){

    } else  if(event is GetSecureNote){

    } else if(event is AddSecureNote){

    } else if (event is UpdateSecureNote){

    } else if(event is DeleteSecureNote){

    }
  }

  Stream<DatabaseState> _mapGetPasswordsToState(GetPasswords event) async* {
    yield Fetching();
    List<Password> list = await databaseRepository.getPasswords(event.passwordCategory);
    yield PasswordList(list);
  }

  Stream<DatabaseState> _mapAddPasswordToState(AddPassword event) async* {
    yield PasswordFormState.loading;
    String res = await databaseRepository.addPassword(event.password);
    if(res=='Success'){
      yield PasswordFormState.success;
    } else {
      yield PasswordFormState.errorOccurred;
    }
  }

  Stream<DatabaseState> _mapUpdatePasswordToState(UpdatePassword event) async* {
    yield PasswordFormState.loading;
    String res =
        await databaseRepository.updatePassword(event.password, event.oldPath);
    if (res == 'Success') {
      yield PasswordFormState.success;
    } else {
      yield PasswordFormState.errorOccurred;
    }
  }

  Stream<DatabaseState> _mapDeletePasswordToState(DeletePassword event) async* {
    yield Fetching();
    await databaseRepository.deletePassword(event.password);
    List<Password> list = await databaseRepository.getPasswords(event.passwordCategory);
    yield PasswordList(list);
  }



}