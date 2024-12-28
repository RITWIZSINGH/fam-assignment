import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';

class ImageCard extends StatelessWidget {
  final ContextualCard card;

  const ImageCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (card.bgImage?.imageUrl == null) return const SizedBox.shrink();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _handleCardTap(context),
        child: AspectRatio(
          aspectRatio: card.bgImage!.aspectRatio ?? 16 / 9,
          child: Image.network(
            card.bgImage!.imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error_outline));
            },
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