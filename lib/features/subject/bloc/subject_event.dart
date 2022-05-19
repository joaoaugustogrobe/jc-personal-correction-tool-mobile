part of 'subject_bloc.dart';


abstract class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

class SubjectPageLoad extends SubjectEvent {
  const SubjectPageLoad(this.id);

  final String id;
  @override
  List<Object> get props => [id];
}
