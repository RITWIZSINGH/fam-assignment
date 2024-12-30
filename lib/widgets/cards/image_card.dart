import 'package:fam_assignment/services/url_service.dart';
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

    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.9; // 90% of screen width
    final borderRadius = size.width * 0.02; // 2% border radius
    final horizontalPadding = size.width * 0.045; // 2% padding

    return Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding * 0.2,
        // vertical: size.height * 0.01,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          onTap: () => _handleCardTap(context),
          child: AspectRatio(
            aspectRatio: card.bgImage!.aspectRatio ?? 16 / 9,
            child: Image.network(
              card.bgImage!.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.error_outline,
                    size: size.width * 0.1, // 10% of screen width
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context) async {
    if (card.url != null) {
      try {
        await UrlService.openUrl(card.url);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the link: ${e.toString()}')),
        );
      }
    }
  }
}
