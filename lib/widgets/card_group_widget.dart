import 'package:fam_assignment/models/contextual_card.dart';
import 'package:flutter/material.dart';
import '../models/card_group.dart';
import 'cards/big_display_card.dart';
import 'cards/small_display_card.dart';
import 'cards/image_card.dart';
import 'cards/small_card_with_arrow.dart';
import 'cards/dynamic_width_card.dart';

class CardGroupWidget extends StatelessWidget {
  final CardGroup cardGroup;

  const CardGroupWidget({
    Key? key,
    required this.cardGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardList;

    if (cardGroup.isScrollable && cardGroup.designType != DesignType.HC9) {
      cardList = SizedBox(
        height: cardGroup.height ?? 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cardGroup.cards.length,
          itemBuilder: (context, index) {
            return _buildCard(cardGroup.cards[index]);
          },
        ),
      );
    } else {
      cardList = Wrap(
        spacing: 8,
        runSpacing: 8,
        children: cardGroup.cards.map((card) => _buildCard(card)).toList(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: cardList,
    );
  }

  Widget _buildCard(ContextualCard card) {
    switch (cardGroup.designType) {
      case DesignType.HC1:
        return SmallDisplayCard(card: card,);
      case DesignType.HC3:
        return BigDisplayCard(card: card,);
      case DesignType.HC5:
        return ImageCard(card: card,);
      case DesignType.HC6:
        return SmallCardWithArrow(card: card,);
      case DesignType.HC9:
        return DynamicWidthCard(
          card: card,
          height: cardGroup.height ?? 200,
        );
    }
  }
}
