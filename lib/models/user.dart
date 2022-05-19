import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  const User({required String id, required String name, required String role})
      : id = id,
        name = name,
        role = role;

  final String id;
  final String name;
  final String role;

  User.fromJson(Map<String, dynamic> json)
      : id = json.containsKey('_id') ? json['_id'] : '',
        name = json.containsKey('nome') ? json['nome'] : '',
        role = json.containsKey('role') ? json['role'] : '';

  @override
  List<Object> get props => [id];

  static const empty = User(id: '', name: '', role: '');
}
