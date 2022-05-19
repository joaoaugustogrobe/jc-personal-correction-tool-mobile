part of 'exercice_bloc.dart';

class ExerciceState extends Equatable {
  const ExerciceState._({
    this.status = SubjectsStatus.unknown,
  });

  const ExerciceState.unknown() : this._();
  const ExerciceState.fetching() : this._(status: SubjectsStatus.fetching);
  const ExerciceState.listview() : this._(status: SubjectsStatus.listview);
  const ExerciceState.empty() : this._(status: SubjectsStatus.empty);

  final SubjectsStatus status;

  @override
  List<Object> get props => [status];
}
