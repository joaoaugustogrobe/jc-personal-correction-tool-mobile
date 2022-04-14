import 'package:correction_tool/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Subject extends Equatable {
  Subject({required String name, required User teacher})
      : id = const Uuid().v4(),
        name = name ?? '',
        teacher = teacher;

  String id;
  String name;
  User teacher;

  @override
  List<Object> get props => [id];
}