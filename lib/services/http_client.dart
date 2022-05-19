import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClient {
  static final HttpClient _singleton = HttpClient._internal();
  static const String _host = 'joaocastilho.com.br';
  static const String _basepath = '/api/';
  static Map<String, String> headers = {
    "Content-type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Credentials": "true",
  };

  factory HttpClient() {
    return _singleton;
  }

  HttpClient._internal();

  Future<http.Response> get(String route) async {
    var uri = Uri.https(_host, '$_basepath$route');
    bool hasToken = headers.containsKey("authorization");
    print('get $hasToken');
    return await http.get(uri, headers: headers);
  }

  Future<http.Response> post(String route,
      {required Map<String, String> body}) async {
    var uri = Uri.https(_host, '$_basepath$route');
    bool hasToken = headers.containsKey("authorization");
    print('post $hasToken');
    return await http.post(uri, body: json.encode(body), headers: headers);
  }

  //function to add a header to the request
  void authenticate(String token) {
    headers['authorization'] = 'Bearer $token';
    print('header added');
    print(headers);
  }
}
