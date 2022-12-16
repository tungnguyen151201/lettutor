class HttpResponse {
  final int statusCode;
  final String message;

  HttpResponse({required this.statusCode, required this.message});

  factory HttpResponse.fromJson(Map<String, dynamic> json) {
    return HttpResponse(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
