import 'dart:io';

import 'package:http/http.dart' as http;

class ErrorResponse {
  final String message;
  ErrorResponse({required this.message});
}

class ErrorHandler {
  static Future<void> handle(dynamic error, dynamic response) async {
    if (response != null) {
      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw ErrorResponse(
          message: "Client error occurred: ${response.statusCode}",
        );
      } else if (response.statusCode >= 500) {
        throw ErrorResponse(
          message: "Server error occurred: ${response.statusCode}",
        );
      } else if (error is http.ClientException) {
        throw ErrorResponse(
          message: "Network error occurred: ${error.message}",
        );
      } else if (error is IOException) {
        throw ErrorResponse(
          message: "No Internet connection.${error.toString()}",
        );
      } else {
        throw ErrorResponse(
          message: "An unexpected error occurred: ${error.toString()}",
        );
      }
    } 
  }
}
