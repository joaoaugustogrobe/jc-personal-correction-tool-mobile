import 'package:bloc/bloc.dart';
import 'package:correction_tool/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import '../reset_password.dart';
import 'package:formz/formz.dart';


part 'reset_event.dart';
part 'reset_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const ResetPasswordState()) {
    on<ResetPasswordEmailChanged>(_onEmailChanged);
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    ResetPasswordEmailChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email]),
    ));
  }

  void _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.forgotPassword(
          email: state.email.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}