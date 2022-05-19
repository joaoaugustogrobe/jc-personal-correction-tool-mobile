import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../repositories/subject_repository.dart';

import '../subjects.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';
// part 'login_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  SubjectsBloc({
    required SubjectRepository subjectRepository,
  })  : _subjectRepository = subjectRepository,
        super(const SubjectsState.unknown()) {
    // on<LoginSubmitted>(_onSubmitted);
    print('SubjectsBloc.constructor');
    on<SubjectsPageLoad>(_onPageLoad);
  }

  final SubjectRepository _subjectRepository;

  void _onPageLoad(
    SubjectsPageLoad event,
    Emitter<SubjectsState> emit,
  ) async {
    emit(const SubjectsState.fetching());
    try{
      await _subjectRepository.fetchSubjects();
      emit(const SubjectsState.listview());
    }catch(_){
      emit(const SubjectsState.empty());
    }
  }

  // void _onEmailChanged(
  //   LoginEmailChanged event,
  //   Emitter<SubjectsState> emit,
  // ) {
  //   final email = Email.dirty(event.email);
  //   emit(state.copyWith(
  //     email: email,
  //     status: Formz.validate([state.password, email]),
  //   ));
  // }

  // void _onPasswordChanged(
  //   LoginPasswordChanged event,
  //   Emitter<SubjectsState> emit,
  // ) {
  //   final password = Password.dirty(event.password);
  //   emit(state.copyWith(
  //     password: password,
  //     status: Formz.validate([password, state.email]),
  //   ));
  // }

  // void _onSubmitted(
  //   LoginSubmitted event,
  //   Emitter<SubjectsState> emit,
  // ) async {
  //   if (state.status.isValidated) {
  //     emit(state.copyWith(status: FormzStatus.submissionInProgress));
  //     try {
  //       await _authenticationRepository.logIn(
  //         email: state.email.value,
  //         password: state.password.value,
  //       );
  //       emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //     } catch (_) {
  //       emit(state.copyWith(status: FormzStatus.submissionFailure));
  //     }
  //   }
  // }
}
