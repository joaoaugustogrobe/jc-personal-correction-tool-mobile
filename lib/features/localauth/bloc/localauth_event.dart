part of 'localauth_bloc.dart';

abstract class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();

  @override
  List<Object> get props => [];
}


class LocalAuthAccepted extends LocalAuthEvent {
  const LocalAuthAccepted();
}

class LocalAuthRefused extends LocalAuthEvent {
  const LocalAuthRefused();
}