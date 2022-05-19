import 'dart:async';
import 'dart:convert';
import 'package:correction_tool/models/subject.dart';
import 'package:uuid/uuid.dart';
import '../models/requests/exercices_list.dart';
import '../models/requests/subjects_enrolls.dart';
import '../services/http_client.dart';
import '/models/user.dart';
import '/models/subject.dart';
import '/models/exercice.dart';

enum SubjectsStatus { unknown, fetching, listview, empty }

class SubjectRepository {
  static List<Subject> _subjects = [];
  static List<Exercice> _exercices = [];

  List<Subject> getSubjects() {
    return _subjects;
  }

  List<Exercice> getExercices() {
    return _exercices;
  }

  //fetch subjects
  Future<void> fetchSubjects() async {
    var httpClient = HttpClient();
    try {
      var response = await httpClient.get(
        'matricula',
      );
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      var responseData = SubjectEnrollsRequest.fromJson(jsonData);
      if (responseData.status == 'error') throw Exception(responseData.message);
      // _user = responseData.payload?.user;
      _subjects = responseData.subjects;
    } catch (e) {
      print(e);
      throw Exception('Erro ao tentar fazer login');
    }
    // _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> fetchExercices() async {
    var httpClient = HttpClient();
    try {
      var response = await httpClient.get(
        'exercicio/show/all',
      );
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      var responseData = ExercicesListRequest.fromJson(jsonData);
      if (responseData.status == 'error') throw Exception(responseData.message);
      print(responseData.exercices);
      _exercices = responseData.exercices;
    } catch (e) {
      print(e);
      throw Exception('Erro ao tentar fazer login');
    }
    // _controller.add(AuthenticationStatus.authenticated);
  }
}
