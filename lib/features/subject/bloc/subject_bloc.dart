import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/subject_repository.dart';


part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc({
    required SubjectRepository subjectRepository,
  })  : _subjectRepository = subjectRepository,
        super(const SubjectState.unknown()) {
    print('BLOC SUBJECT CONSTRUCTOR');
    on<SubjectPageLoad>(_onPageLoad);
  }

  final SubjectRepository _subjectRepository;

  void _onPageLoad(
    SubjectPageLoad event,
    Emitter<SubjectState> emit,
  ) async {
    print('SUBJECT PAGE LOAD');
    emit(const SubjectState.fetching());
    try{
      await _subjectRepository.fetchExercices();
      emit(const SubjectState.listview());
    }catch(_){
      emit(const SubjectState.empty());
    }
  }
}
