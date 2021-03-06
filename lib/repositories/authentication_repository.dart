import 'dart:async';
import 'package:correction_tool/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/requests/generic_request.dart';
import '../models/requests/student_login.dart';
import '../services/http_client.dart';
import 'dart:convert';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  resettingPassword,
  requestLocalAuthPermission,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  User? _user;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  void logInWithToken(String token) {
    _user = const User(
      id: '',
      name: '',
      role: '',
    ); //read this data from token using JWT
    var httpClient = HttpClient();
    httpClient.authenticate(token);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    var httpClient = HttpClient();
    try {
      var response = await httpClient.post(
        'aluno/login',
        body: {
          'email': email,
          'password': password,
        },
      );
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      var responseData = StudentLoginResponse.fromJson(jsonData);
      httpClient.authenticate(responseData.payload!.token.toString());

      if (responseData.status == 'error') throw Exception(responseData.message);
      _user = responseData.payload?.user;
    } catch (e) {
      print(e);
      throw Exception('Erro ao tentar fazer login');
    }

    _controller.add(AuthenticationStatus.authenticated);
    try{
      final storage = new FlutterSecureStorage();
      final allowLocalAuth = await storage.read(key: 'KEY_ALLOW_LOCAL_AUTH');

      if(allowLocalAuth == null){
        _controller.add(AuthenticationStatus.requestLocalAuthPermission);
      }

      if(allowLocalAuth != 'false'){
        await storage.write(key: 'KEY_EMAIL', value: email);
        await storage.write(key: 'KEY_PASSWORD', value: password);
      }

    }catch(e){
      print(e);
    }
  }

  //User getter
  User? get user => _user;

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      var response = await HttpClient().post(
        'aluno/forgot_password',
        body: {
          'email': email,
        },
      );
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      var responseData = GenericRequest.fromJson(jsonData);
      if (responseData.status != 'success')
        throw Exception(responseData.message);
      _controller.add(AuthenticationStatus.unauthenticated);
    } catch (e) {
      print(e);
      throw Exception('Erro ao tentar recuperar senha');
    }

    //   const Duration(milliseconds: 700),
    //   () => _controller.add(AuthenticationStatus.unauthenticated),
    // );
  }

  void logOut() async {
    // final storage = new FlutterSecureStorage();
    // storage.delete(key: 'KEY_ALLOW_LOCAL_AUTH');

    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void requestResetPassword() {
    _controller.add(AuthenticationStatus.resettingPassword);
  }

  void dispose() => _controller.close();
}
