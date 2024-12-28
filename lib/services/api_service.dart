import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env.dart';
import '../models/card_group.dart';

class ApiService {
  static const String _baseUrl = Env.apiUrl;

  Future<List<CardGroup>> fetchContextualCards() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?slugs=famx-paypage'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<CardGroup> cardGroups = [];
        
        for (var item in jsonData) {
          if (item['hc_groups'] != null) {
            for (var group in item['hc_groups']) {
              cardGroups.add(CardGroup.fromJson(group));
            }
          }
        }
        
        return cardGroups;
      } else {
        throw Exception('Failed to load contextual cards');
      }
    } catch (e) {
      throw Exception('Error fetching contextual cards: $e');
    }
  }
}