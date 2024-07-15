import 'package:http/http.dart' as http;
import 'dart:convert';

class JournalService {
  static const String url = "http://192.168.100.164:3000/";
  static const String resource = 'learnhttp/';

  getUrl() {
    return Uri.parse('$url$resource');
  }

  register(String content) async {
    final url = getUrl();
    final jsonData = jsonEncode({"content": content});
    await http.post(url, body: jsonData);
  }

  get() async {
    http.Response response = await http.get(getUrl());
    print(response.body);
  }
}
