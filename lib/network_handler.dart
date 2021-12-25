import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  String baseurl = dotenv.env['baseurl'] ?? "";

  Future<http.Response> get(String url) async {
    url = formater(url);
    var response = await http.get(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
    );
    return response;
  }

  Future<http.Response> getWithAuth(String url, String token) async {
    url = formater(url);

    var response = await http.get(
      Uri.parse(url),
      headers: {"Content-type": "application/json", "authorization": token},
    );
    return response;
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json"}, body: json.encode(body));
    // int code = response.statusCode;
    // if (response.statusCode == 200 || response.statusCode == 201) {
    // int code = response.statusCode;
    return response;
    // print(response)
  }

  Future<http.Response> postAuth(
      String url, Map<String, String> body, String token) async {
    url = formater(url);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json", "authorization": token},
        body: json.encode(body));
    // int code = response.statusCode;
    // if (response.statusCode == 200 || response.statusCode == 201) {
    // int code = response.statusCode;
    return response;
    // print(response)
  }

  Future<http.Response> postAuth1(
      String url, Map<dynamic, dynamic> body, String token) async {
    url = formater(url);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json", "authorization": token},
        body: json.encode(body));
    // int code = response.statusCode;
    // if (response.statusCode == 200 || response.statusCode == 201) {
    // int code = response.statusCode;
    return response;
    // print(response)
  }

  Future<http.Response> postAuthWithoutBody(String url, String token) async {
    url = formater(url);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json", "authorization": token});

    // int code = response.statusCode;
    // if (response.statusCode == 200 || response.statusCode == 201) {
    // int code = response.statusCode;
    return response;
    // print(response)
  }

  String formater(String url) {
    return baseurl + url;
  }
}
