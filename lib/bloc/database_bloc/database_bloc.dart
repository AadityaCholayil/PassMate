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

    } else if(event is UpdatePassword){

    } else if(event is DeletePassword){

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

}