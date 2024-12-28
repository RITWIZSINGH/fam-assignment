import 'package:flutter/material.dart';
import 'contextual_card.dart';

enum DesignType {
  HC1,  // SMALL_DISPLAY_CARD
  HC3,  // BIG_DISPLAY_CARD
  HC5,  // IMAGE_CARD
  HC6,  // SMALL_CARD_WITH_ARROW
  HC9,  // DYNAMIC_WIDTH_CARD
}

class CardGroup {
  final int id;
  final String name;
  final DesignType designType;
  final int cardType;
  final List<ContextualCard> cards;
  final bool isScrollable;
  final double? height;
  final bool isFullWidth;
  final String? slug;
  final int level;

  CardGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cardType,
    required this.cards,
    required this.isScrollable,
    this.height,
    required this.isFullWidth,
    this.slug,
    required this.level,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      designType: _parseDesignType(json['design_type']),
      cardType: json['card_type'] ?? 1,
      cards: (json['cards'] as List?)
          ?.map((e) => ContextualCard.fromJson(e))
          .toList() ?? [],
      isScrollable: json['is_scrollable'] ?? false,
      height: json['height']?.toDouble(),
      isFullWidth: json['is_full_width'] ?? false,
      slug: json['slug'],
      level: json['level'] ?? 0,
    );
  }

  static DesignType _parseDesignType(String? type) {
    switch (type) {
      case 'HC1':
        return DesignType.HC1;
      case 'HC3':
        return DesignType.HC3;
      case 'HC5':
        return DesignType.HC5;
      case 'HC6':
        return DesignType.HC6;
      case 'HC9':
        return DesignType.HC9;
      default:
        throw Exception('Unknown design type: $type');
    }
  }
}