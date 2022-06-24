import 'dart:io';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

class Test extends Equatable {
  String id;
  List<String> input;
  int version;
  bool isPrivate;
  String errorMessage;
  String name;
  String output;
  ExecutionInstance executionInstance;

  //fromJson
  Test.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        input = json['input'],
        version = json['versao'],
        isPrivate = json['isPrivate'],
        errorMessage = json['mensagemErro'],
        name = json['nome'],
        output = json['output'],
        executionInstance = ExecutionInstance.fromJson(json['testeresolucao']);


  //getter inputs as string
  String getInputsAsString() {
    String result = "";
    for (String input in this.input) {
      result += input + ",";
    }
    return result;
  }


  List<Object> get props => [id];
}

class ExecutionInstance {
  bool isError;
  String output;

  ExecutionInstance.fromJson(Map<String, dynamic> json)
      : isError = json['isError'],
        output = json['output'];
}
