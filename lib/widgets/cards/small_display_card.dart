import 'package:fam_assignment/services/url_service.dart';
import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';
import '../formatted_text_widget.dart';

class SmallDisplayCard extends StatelessWidget {
  final ContextualCard card;

  const SmallDisplayCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.9; // 90% of screen width
    final cardHeight = size.height * 0.5; // 10% of screen height
    final iconSize = size.width * 0.12; // 7% of screen width for icon
    final horizontalPadding = size.width * 0.01; // 2% padding
    final borderRadius = size.width * 0.02; // 2% border radius

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (card.icon != null) ...[
                  SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: Image.network(
                        card.icon!.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: horizontalPadding * 4),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (card.formattedTitle != null)
                        Flexible(
                          flex: 2,
                          child: FormattedTextWidget(
                            formattedText: card.formattedTitle!,
                          ),
                        ),
                      if (card.formattedDescription != null)
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: FormattedTextWidget(
                              formattedText: card.formattedDescription!,
                            ),
                          ),
                        ),
                    ],
                  ),
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
