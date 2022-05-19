import '../exercice.dart';

class ExercicesListRequest {
  String status = 'success';
  String message = '';
  List<Exercice> exercices = [];

  ExercicesListRequest.fromJson(Map<String, dynamic> json) {
    Iterable exercicesIterable = json['exercicios'];
    exercices = List<Exercice>.from(
        exercicesIterable.map((model) => Exercice.fromJson(model)));
  }
}
