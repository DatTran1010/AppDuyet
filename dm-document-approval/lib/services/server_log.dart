import 'dart:convert';

import 'package:http/http.dart' as http;

class ServerLog {
  final bool success;
  final dynamic message;
  final dynamic data;
  final dynamic code;

  ServerLog({this.success = false, this.message, this.data, this.code});

  factory ServerLog.fromReponse(http.Response response) {
    if (response.body.isNotEmpty) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (res.containsKey('success')) {
          return ServerLog.s200(res);
        }
        if (res.containsKey("response")) {
          return ServerLog.s200(res);
        }
        return ServerLog.serverError();
      } else if (response.statusCode >= 400) {
        if (res.containsKey('success')) {
          return ServerLog.s400(res);
        }
        if (response.statusCode == 401) {
          return ServerLog.s401();
        }
        return ServerLog.serverError();
      }
    }
    if (response.statusCode == 401) {
      return ServerLog.s401();
    }
    return ServerLog.serverError();
  }

  // Status code = 200
  factory ServerLog.s200(Map<String, dynamic> json) {
    if (json.containsKey("response")) {
      if (json["response"].containsKey("success")) {
        return ServerLog(
          success: json["response"]['success'],
          message: json["response"]['message'],
          data: json["response"]['data'],
        );
      }
      return ServerLog.serverError();
    }
    return ServerLog(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  // Status code = 500
  factory ServerLog.s500(json) {
    return ServerLog(
        success: json['StatusCode'], message: json['ErrorMessage']);
  }

  // Status code = 400
  factory ServerLog.s400(json) {
    return ServerLog(success: json['success'], data: json['errors']);
  }

  factory ServerLog.s401() {
    return ServerLog(success: false, code: 401, message: "Unauthorized");
  }

  factory ServerLog.serverError() {
    return ServerLog(
      success: false,
      message: 'Server Errors',
    );
  }

  @override
  String toString() {
    return """ServerLog:
    data: $data,
    success: $success""";
  }
}
