import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';

class DynamicWidthCard extends StatelessWidget {
  final ContextualCard card;
  final double height;

  const DynamicWidthCard({
    Key? key,
    required this.card,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (card.bgImage?.imageUrl == null || card.bgImage?.aspectRatio == null) {
      return const SizedBox.shrink();
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _handleCardTap(context),
        child: Container(
          height: height,
          width: height * card.bgImage!.aspectRatio!,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(card.bgImage!.imageUrl!),
              fit: BoxFit.cover,
            ),
            gradient: card.bgGradient != null
                ? LinearGradient(
                    colors: card.bgGradient!.colors
                        .map((c) => Color(
                            int.parse(c.substring(1), radix: 16) + 0xFF000000))
                        .toList(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(
                        card.bgGradient!.angle * (3.14159 / 180)),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context) {
    if (card.url != null) {
      // Handle URL launch
    }
  }
}