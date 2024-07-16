import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:useapi/models/journal.dart';

class JournalService {
  static const String url = "http://192.168.63.110:3000/";
  // static const String resource = 'journals/';
  static const String resource = 'learnhttp/';

  getUrl() {
    return Uri.parse('$url$resource');
  }

  Future<bool> register(Journal journal) async {
    final url = getUrl();
    String jsonJournal = jsonEncode(journal.toMap());
    http.Response response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonJournal,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  get() async {
    http.Response response = await http.get(getUrl());
    print(response.body);
  }
}
