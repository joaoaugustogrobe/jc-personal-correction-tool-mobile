import 'package:bloc/bloc.dart';
import 'package:correction_tool/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import '../localauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

part 'localauth_event.dart';
part 'localauth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LocalAuthState()) {
    on<LocalAuthAccepted>(_onLocalAuthAccepted);
    on<LocalAuthRefused>(_onLocalAuthRefused);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onLocalAuthAccepted(
    LocalAuthAccepted event,
    Emitter<LocalAuthState> emit,
  ) async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'KEY_ALLOW_LOCAL_AUTH', value: 'true');
    } catch (e) {
      print(e);
    }
  }

  void _onLocalAuthRefused(
    LocalAuthRefused event,
    Emitter<LocalAuthState> emit,
  ) async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'KEY_ALLOW_LOCAL_AUTH', value: 'false');
    } catch (e) {
      print(e);
    }
  }
}
