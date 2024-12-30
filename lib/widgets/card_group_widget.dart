import 'package:fam_assignment/models/contextual_card.dart';
import 'package:flutter/material.dart';
import '../models/card_group.dart';
import '../services/storage_service.dart';
import 'cards/big_display_card.dart';
import 'cards/small_display_card.dart';
import 'cards/image_card.dart';
import 'cards/small_card_with_arrow.dart';
import 'cards/dynamic_width_card.dart';

class CardGroupWidget extends StatelessWidget {
  final CardGroup cardGroup;
  final StorageService storageService;
  final VoidCallback onCardAction;

  const CardGroupWidget({
    super.key,
    required this.cardGroup,
    required this.storageService,
    required this.onCardAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: _buildCardList(),
    );
  }

  Widget _buildCardList() {
    // Make all card groups with multiple cards scrollable horizontally
    if (cardGroup.cards.length > 1) {
      return SizedBox(
        height: cardGroup.height ?? 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cardGroup.cards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 8 : 8,
                right: index == cardGroup.cards.length - 1 ? 16 : 0,
              ),
              child: _buildCard(cardGroup.cards[index]),
            );
          },
        ),
      );
    } else {
      // Single card takes full width
      return _buildCard(cardGroup.cards.first);
    }
  }

  Widget _buildCard(ContextualCard card) {
    switch (cardGroup.designType) {
      case DesignType.HC1:
        return SmallDisplayCard(card: card);
      case DesignType.HC3:
        return BigDisplayCard(
          card: card,
          storageService: storageService,
          onAction: onCardAction,
        );
      case DesignType.HC5:
        return ImageCard(card: card);
      case DesignType.HC6:
        return SmallCardWithArrow(card: card);
      case DesignType.HC9:
        return DynamicWidthCard(
          card: card,
          height: cardGroup.height ?? 200,
        );
    }
  }
}
