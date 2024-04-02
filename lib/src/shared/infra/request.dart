import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:todo_clean_architecture/src/shared/infra/exception/http_error.dart';
import 'package:todo_clean_architecture/src/todo/exception/get_todos_exception.dart';

abstract class Request<T> {
  final String api;

  Request({required this.api});

  Future<T> single(String path) async {
    try {
      var response = await http.get(_toURI(path));

      if (response.statusCode <= 204) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(jsonResponse);

        return fromJSON(jsonResponse);
      }

      throw HttpError('Unexpected error');
    } on SocketException {
      throw HttpError('No internet connection');
    } on HttpException {
      throw HttpError('Failed executed this request');
    } on FormatException {
      throw HttpError('Bad response format');
    }
  }

  Future<List<T>> mult(String path) async {
    try {
      var response = await http.get(_toURI(path));

      if (response.statusCode <= 204) {
        var jsonResponse =
            convert.jsonDecode(response.body) as List<Map<String, dynamic>>;
        print(jsonResponse);
        return jsonResponse.map((map) => fromJSON(map)).toList();
      }

      throw GetTodosException(
        message: 'Return a error while request todo $response',
      );
    } on SocketException {
      throw HttpError('No internet connection');
    } on HttpException {
      throw HttpError('Failed executed this request');
    } on FormatException {
      throw HttpError('Bad response format');
    }
  }

  Uri _toURI(String path) {
    return Uri.https('$api$path');
  }

  T fromJSON(Map map);
}
