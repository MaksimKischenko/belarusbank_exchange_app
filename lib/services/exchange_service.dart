import 'package:belarus_exchange_app/data/data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://belarusbank.by/api/kursExchange';

class ExchangeService { 

  Future<List<ExchangeInfo>> getExchangeInfo(String? city) async {
    final url = Uri.parse('$_baseUrl?city=$city');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List tabs = json.decode(response.body);
      return tabs.map((json) => ExchangeInfo.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
  
