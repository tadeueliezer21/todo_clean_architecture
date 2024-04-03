import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:logging/logging.dart';
import 'dart:convert';

import 'package:todo_clean_architecture/src/shared/infra/exception/http_error.dart';
import 'package:todo_clean_architecture/src/shared/infra/exception/unknow_error.dart';
import 'package:todo_clean_architecture/src/shared/infra/utils/headers.dart';

abstract class RestTemplate<T> {
  final Client _httpClient;
  final String api;

  final log = Logger('ExampleLogger');

  RestTemplate(this.api, {required Client httpClient})
      : _httpClient = httpClient;

  Future<T> single(String path) async {
    try {
      var response =
          await _httpClient.get(_toURI(path), headers: _defaultHeaders());

      if (response.statusCode <= 204) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        log.info('Single todo executed');
        return fromJSON(jsonResponse);
      }

      throw UnknowError('Returned an unknown error while request a todo');
    } on SocketException {
      throw HttpError('No internet connection');
    } on HttpException {
      throw HttpError('Failed executed this request');
    } on FormatException {
      throw HttpError('Bad response format');
    } catch (err) {
      throw UnknowError(err.toString());
    }
  }

  Future<List<T>> mult(String path) async {
    try {
      var response =
          await _httpClient.get(_toURI(path), headers: _defaultHeaders());

      if (response.statusCode <= 204) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        log.info('Single todo executed');
        return jsonResponse.map((map) => fromJSON(map)).toList();
      }

      throw UnknowError('Returned an unknown error while request a mult todos');
    } on SocketException {
      throw HttpError('No internet connection');
    } on HttpException {
      throw HttpError('Failed executed this request');
    } on FormatException {
      throw HttpError('Bad response format');
    } catch (err) {
      throw UnknowError(err.toString());
    }
  }

  Uri _toURI(String path) {
    return Uri.parse('$api$path');
  }

  Map<String, String> _defaultHeaders() {
    return Headers.builder()
        .addHeaders(
          'Content-Type',
          'application/json',
        )
        .values;
  }

  T fromJSON(Map map);
}
