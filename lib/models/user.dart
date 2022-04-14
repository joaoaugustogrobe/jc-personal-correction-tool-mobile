import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  const User({required String id, required String name})
      : id = id,
        name = name;

  final String id;
  final String name;

  @override
  List<Object> get props => [id];

  static const empty = User(id: '', name: '');
}
