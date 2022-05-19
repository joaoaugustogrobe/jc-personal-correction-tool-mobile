import '../subject.dart';

class SubjectEnrollsRequest {
  String? status;
  String? message;
  List<Subject> subjects = [];

  SubjectEnrollsRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    Iterable subjectEnrollsIterable = json['data'];
    subjects = List<Subject>.from(
        subjectEnrollsIterable.map((model) => Subject.fromJson(model['materia'])));
  }
}
