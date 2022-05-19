import '../user.dart';

class StudentLoginResponse {
  String? status;
  String? message;
  StudentLoginPayload? payload;

  StudentLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    payload = json['data'] != null
        ? StudentLoginPayload.fromJson(json['data'])
        : null;
  }
}

class StudentLoginPayload {
  String? token;
  User? user;

  StudentLoginPayload.fromJson(Map<String, dynamic> json) {
    print('create payload, $json');
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  
}