
import 'dart:io';
import 'package:intl/intl.dart';


import 'package:equatable/equatable.dart';

enum ExerciceStatus {
  pending
}


class Exercice extends Equatable{
  String id;
  String title;
  String description;
  ExerciceStatus status;
  int tries;
  String signature;
  DateTime dueDate;

  //fromJson
  Exercice.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
    title = json['titulo'],
    description = json['descricao'],
    status = json['status'] == 'pending' ? ExerciceStatus.pending : ExerciceStatus.pending,
    tries = json['submissoesCount'],
    signature =  json['nomeFuncao'],
    dueDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(json['prazo']) * 1000);
  

  //dueDate getter
  String get dueOn {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dueDate);
  }

  bool get isDue {
    return dueDate.isBefore(DateTime.now());
  }

  List<Object> get props => [id];
}