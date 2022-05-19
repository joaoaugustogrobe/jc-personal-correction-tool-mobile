part of 'subjects_bloc.dart';

class SubjectsState extends Equatable {
  const SubjectsState._({
    this.status = SubjectsStatus.unknown,
  });

  const SubjectsState.unknown() : this._();
  const SubjectsState.fetching() : this._(status: SubjectsStatus.fetching);
  const SubjectsState.listview() : this._(status: SubjectsStatus.listview);
  const SubjectsState.empty() : this._(status: SubjectsStatus.empty);

  final SubjectsStatus status;

  @override
  List<Object> get props => [status];
}
