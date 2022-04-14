import 'dart:async';
import 'package:correction_tool/models/subject.dart';
import 'package:uuid/uuid.dart';
import '/models/user.dart';
import '/models/subject.dart';

class SubjectRepository {
  static final List<Subject> _subjects = [
    Subject(
      name: 'Math',
      teacher: User(name: 'Mr. Doe', id: '1'),
    ),
    Subject(
      name: 'English',
      teacher: User(name: 'Mr. Smith', id: '2'),
    ),
    Subject(
      name: 'History',
      teacher: User(name: 'Mr. John', id: '3'),
    ),
  ];

  static List<Subject> getSubjects() {
    return _subjects;
  }
}
