import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:suitmedia/data/model/user.dart';

class UserService {
  static const String baseUrl = 'https://reqres.in/api';
  static const int usersPerPage = 10;

  final http.Client client;
  final Logger _logger = Logger();

  UserService({http.Client? client}) : client = client ?? http.Client();

  Future<List<User>> getUsers(
      {int page = 1, int perPage = usersPerPage}) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/users?page=$page&per_page=$perPage'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['data'] as List)
            .map<User>((user) => User.fromJson(user))
            .toList();
      } else {
        _logger.e('HTTP error: ${response.statusCode}');
        throw _handleError(response.statusCode);
      }
    } catch (e) {
      _logger.e('Failed to load data: $e');
      throw _handleException(e);
    }
  }

  Exception _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return Exception('Bad request');
      case 401:
        return Exception('Unauthorized');
      case 403:
        return Exception('Forbidden');
      case 404:
        return Exception('Not found');
      default:
        return Exception('HTTP error: $statusCode');
    }
  }

  Exception _handleException(dynamic e) {
    return Exception('Failed to load data: $e');
  }

  void close() {
    client.close();
  }
}
