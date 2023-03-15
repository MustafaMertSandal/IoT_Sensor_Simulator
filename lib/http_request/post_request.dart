import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class PostRequest {
  postTemperatureData(int temp, String tempUrl, int variance) {
    double randomTemp =
        (temp - variance) + variance * 2 * Random().nextDouble();
    randomTemp = double.parse(randomTemp.toStringAsFixed(2));
    return http.post(Uri.parse(tempUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "temperature": randomTemp,
        }));
  }

  postDetectionData(bool detected, String detectionUrl) {
    return http.post(Uri.parse(detectionUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "human detection": detected,
        }));
  }
}
