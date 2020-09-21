import 'dart:convert';
import 'package:http/http.dart' as http;
import 'RegisterRequestViewModel.dart';
import 'RegisterResponseViewModel.dart';

Future<RegisterResponseViewModel> register(RegisterRequestViewModel register1) async {
  final http.Response response = await http.post(
    'http://37.148.209.148:8080/login/register1',
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: register1.toJson()
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return RegisterResponseViewModel.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}