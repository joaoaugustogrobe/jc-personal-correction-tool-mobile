class GenericRequest {
  late String status;
  late String message;

  GenericRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
