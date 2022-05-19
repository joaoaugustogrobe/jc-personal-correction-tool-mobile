part of 'subject_bloc.dart';

class SubjectState extends Equatable {
  const SubjectState._({
    this.status = SubjectsStatus.unknown,
  });

  const SubjectState.unknown() : this._();
  const SubjectState.fetching() : this._(status: SubjectsStatus.fetching);
  const SubjectState.listview() : this._(status: SubjectsStatus.listview);
  const SubjectState.empty() : this._(status: SubjectsStatus.empty);

  final SubjectsStatus status;

  @override
  List<Object> get props => [status];
}
