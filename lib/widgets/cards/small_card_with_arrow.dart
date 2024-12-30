import 'package:fam_assignment/services/url_service.dart';
import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';
import '../formatted_text_widget.dart';

class SmallCardWithArrow extends StatelessWidget {
  final ContextualCard card;

  const SmallCardWithArrow({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.9; // 90% of screen width
    final cardHeight = size.height * 0.1; // 10% of screen height
    final iconWidth = size.width * 0.07; // 7% of screen width
    final horizontalPadding = size.width * 0.02; // 2% padding
    final borderRadius = size.width * 0.02; // 2% border radius
    final arrowSize = size.width * 0.05; // 5% of width for arrow

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        // vertical: size.height * 0.01,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          onTap: () => _handleCardTap(context),
          child: Container(
            padding: EdgeInsets.all(horizontalPadding),
            decoration: BoxDecoration(
              color: card.bgColor != null
                  ? Color(int.parse(card.bgColor!.substring(1), radix: 16) +
                      0xFF000000)
                  : Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              children: [
                if (card.icon != null)
                  Image.network(
                    card.icon!.imageUrl!,
                    width: card.icon!.aspectRatio != null
                        ? iconWidth * card.icon!.aspectRatio!
                        : iconWidth,
                    height: iconWidth,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, size: iconWidth);
                    },
                  ),
                SizedBox(width: horizontalPadding),
                Expanded(
                  child: card.formattedTitle != null
                      ? FormattedTextWidget(formattedText: card.formattedTitle!)
                      : Text(
                          card.title ?? '',
                          style: TextStyle(
                            fontSize: size.width * 0.04, // 4% of screen width
                          ),
                        ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: arrowSize,
                ),
              ],
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
