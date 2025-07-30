import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<T?> getData<T>(
      {required url,
      required T Function(Map<String, dynamic>) fromjson}) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final mapData = jsonDecode(response.body);
      print("Your Api Data : $mapData");
      return fromjson(mapData);
    }
    return null;
  }
}
