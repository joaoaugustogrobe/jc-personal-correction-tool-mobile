import 'package:correction_tool/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Subject extends Equatable {
  Subject({required String name, required User teacher, bool enabled = true})
      : id = const Uuid().v4(),
        name = name,
        enabled = enabled,
        teacher = teacher;

  String id;
  String name;
  User teacher;
  bool enabled;

  Subject.fromJson(Map<String, dynamic> json)
    : id = json.containsKey('_id') ? json['_id'] : '',
      enabled = json.containsKey('status') ? json['status'] : true,
      name = json.containsKey('nome') ? json['nome'] : '',
      teacher = User.fromJson(json['professor']);

  @override
  List<Object> get props => [id];
}
