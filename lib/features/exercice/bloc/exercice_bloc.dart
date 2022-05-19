import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/subject_repository.dart';


part 'exercice_event.dart';
part 'exercice_state.dart';

class ExerciceBloc extends Bloc<ExerciceEvent, ExerciceState> {
  ExerciceBloc({
    required SubjectRepository subjectRepository,
  })  : _subjectRepository = subjectRepository,
        super(const ExerciceState.unknown()) {
    print('BLOC SUBJECT CONSTRUCTOR');
    on<ExercicePageLoad>(_onPageLoad);
  }

  final SubjectRepository _subjectRepository;

  void _onPageLoad(
    ExercicePageLoad event,
    Emitter<ExerciceState> emit,
  ) async {
    print('SUBJECT PAGE LOAD');
    emit(const ExerciceState.fetching());
    try{
      await _subjectRepository.fetchExercices();
      emit(const ExerciceState.listview());
    }catch(_){
      emit(const ExerciceState.empty());
    }
  }
}
