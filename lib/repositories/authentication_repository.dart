import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, resettingPassword }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 700),
      () => _controller.add(AuthenticationStatus.unauthenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void requestResetPassword() {
    _controller.add(AuthenticationStatus.resettingPassword);
  }

  void dispose() => _controller.close();

}