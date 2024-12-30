import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class StorageService {
  static const String _dismissedCardsKey = 'dismissed_cards';
  static const String _remindLaterCardsKey = 'remind_later_cards';
  
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> create() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (kDebugMode) {
        print('SharedPreferences initialized successfully');
      }
      return StorageService(prefs);
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing SharedPreferences: $e');
      }
      rethrow;
    }
  }

  Future<void> dismissCard(int cardId) async {
    try {
      final dismissedCards = _getDismissedCards();
      dismissedCards.add(cardId);
      await _prefs.setString(_dismissedCardsKey, json.encode(dismissedCards));
      if (kDebugMode) {
        print('Card $cardId dismissed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error dismissing card: $e');
      }
      rethrow;
    }
  }

  Future<void> remindLater(int cardId) async {
    try {
      final remindLaterCards = _getRemindLaterCards();
      remindLaterCards.add(cardId);
      await _prefs.setString(_remindLaterCardsKey, json.encode(remindLaterCards));
      if (kDebugMode) {
        print('Card $cardId set for remind later');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error setting remind later: $e');
      }
      rethrow;
    }
  }

  List<int> _getDismissedCards() {
    try {
      final String? data = _prefs.getString(_dismissedCardsKey);
      if (data == null) return [];
      return List<int>.from(json.decode(data));
    } catch (e) {
      if (kDebugMode) {
        print('Error getting dismissed cards: $e');
      }
      return [];
    }
  }

  List<int> _getRemindLaterCards() {
    try {
      final String? data = _prefs.getString(_remindLaterCardsKey);
      if (data == null) return [];
      return List<int>.from(json.decode(data));
    } catch (e) {
      if (kDebugMode) {
        print('Error getting remind later cards: $e');
      }
      return [];
    }
  }

  bool isCardDismissed(int cardId) {
    try {
      return _getDismissedCards().contains(cardId);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if card is dismissed: $e');
      }
      return false;
    }
  }

  bool isCardRemindLater(int cardId) {
    try {
      return _getRemindLaterCards().contains(cardId);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if card is remind later: $e');
      }
      return false;
    }
  }

  Future<void> clearRemindLater() async {
    try {
      await _prefs.remove(_remindLaterCardsKey);
      if (kDebugMode) {
        print('Remind later cards cleared successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing remind later cards: $e');
      }
      rethrow;
    }
  }

  Future<void> clearDismissedCards() async {
    try {
      await _prefs.remove(_dismissedCardsKey);
      if (kDebugMode) {
        print('Dismissed cards cleared successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing dismissed cards: $e');
      }
      rethrow;
    }
  }

  
}