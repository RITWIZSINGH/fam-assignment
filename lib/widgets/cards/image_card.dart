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
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        child: AspectRatio(
          aspectRatio: card.bgImage!.aspectRatio ?? 16 / 9,
          child: Image.network(
            card.bgImage!.imageUrl!,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error_outline));
            },
          ),
        ),
      ),
    );
  }
}
