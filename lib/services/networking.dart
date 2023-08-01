import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper {
  final String url;
  NetworkHelper({required this.url});

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      return Future.error("something wrong");
    }
  }

  Future<Map<String,dynamic>> getcityData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
       return data[0];
    } else {
      return Future.error("something wrong");
    }
  }
}
