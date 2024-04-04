import 'dart:io';

import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:todo_clean_architecture/src/shared/infra/exception/http_error.dart';
import 'package:todo_clean_architecture/src/shared/infra/exception/unknow_error.dart';
import 'package:todo_clean_architecture/src/shared/infra/headers.dart';

abstract class RestTemplate<T> {
  final Client _httpClient;
  final String api;

  RestTemplate(this.api, {required Client httpClient})
      : _httpClient = httpClient;

  Future<T> findById(String path) async {
    try {
      var response =
          await _httpClient.get(_toURI(path), headers: _defaultHeaders());

      if (response.statusCode > 204) {
        throw HttpException(response.reasonPhrase ?? 'Unexpected error');
      }

      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return fromJSON(jsonResponse);
    } on SocketException catch (err) {
      throw HttpError(err.message);
    } on FormatException catch (err) {
      throw HttpError(err.message);
    } catch (err) {
      throw UnknowError(err.toString());
    }
  }

  Future<List<T>> findAll(String path) async {
    try {
      var response =
          await _httpClient.get(_toURI(path), headers: _defaultHeaders());

      if (response.statusCode > 204) {
        throw HttpException(response.reasonPhrase ?? 'Unexpected error');
      }

      var jsonResponse = jsonDecode(response.body) as List<dynamic>;

      return jsonResponse.map((map) => fromJSON(map)).toList();
    } on SocketException catch (err) {
      throw HttpError(err.message);
    } on FormatException catch (err) {
      throw HttpError(err.message);
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
