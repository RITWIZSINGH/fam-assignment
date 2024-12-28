import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static const String _dismissedCardsKey = 'dismissed_cards';
  static const String _remindLaterCardsKey = 'remind_later_cards';
  
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  Future<void> dismissCard(int cardId) async {
    final dismissedCards = _getDismissedCards();
    dismissedCards.add(cardId);
    await _prefs.setString(_dismissedCardsKey, json.encode(dismissedCards));
  }

  Future<void> remindLater(int cardId) async {
    final remindLaterCards = _getRemindLaterCards();
    remindLaterCards.add(cardId);
    await _prefs.setString(_remindLaterCardsKey, json.encode(remindLaterCards));
  }

  List<int> _getDismissedCards() {
    final String? data = _prefs.getString(_dismissedCardsKey);
    if (data == null) return [];
    return List<int>.from(json.decode(data));
  }

  List<int> _getRemindLaterCards() {
    final String? data = _prefs.getString(_remindLaterCardsKey);
    if (data == null) return [];
    return List<int>.from(json.decode(data));
  }

  bool isCardDismissed(int cardId) {
    return _getDismissedCards().contains(cardId);
  }

  bool isCardRemindLater(int cardId) {
    return _getRemindLaterCards().contains(cardId);
  }

  Future<void> clearRemindLater() async {
    await _prefs.remove(_remindLaterCardsKey);
  }
}