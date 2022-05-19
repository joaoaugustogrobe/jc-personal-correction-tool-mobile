part of 'exercice_bloc.dart';


abstract class ExerciceEvent extends Equatable {
  const ExerciceEvent();

  @override
  List<Object> get props => [];
}

class ExercicePageLoad extends ExerciceEvent {
  const ExercicePageLoad(this.id);

  final String id;
  @override
  List<Object> get props => [id];
}
