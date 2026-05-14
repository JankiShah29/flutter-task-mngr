import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interview_test/models/quote.dart';

class APICallService {
  
  Future<Quote?> getQuote() async {
    http.Response response = await http.get(Uri.parse('http://api.quotable.io/random'));
    if (response.statusCode == 200) {
      Quote quote = Quote.fromJson(jsonDecode(response.body));
      return quote;
    } else {
      return null;
    }
  }

}