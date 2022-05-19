part of 'subjects_bloc.dart';


abstract class SubjectsEvent extends Equatable {
  const SubjectsEvent();

  @override
  List<Object> get props => [];
}

class SubjectsPageLoad extends SubjectsEvent {
  const SubjectsPageLoad();
}

// class LoginEmailChanged extends SubjectsEvent {
//   const LoginEmailChanged(this.email);

//   final String email;

//   @override
//   List<Object> get props => [email];
// }

// class LoginPasswordChanged extends SubjectsEvent {
//   const LoginPasswordChanged(this.password);

//   final String password;

//   @override
//   List<Object> get props => [password];
// }

// class LoginSubmitted extends SubjectsEvent {
//   const LoginSubmitted();
// }