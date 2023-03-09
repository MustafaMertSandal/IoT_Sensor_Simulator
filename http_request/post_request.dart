import 'dart:convert';

import 'package:http/http.dart' as http;

class PostRequest {
  postData(double temp, bool detected, String url) {
    return http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "temperature": temp,
          "human detection": detected,
        }));
  }
}
