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
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      // Set a fixed width or use screen width
      width: screenWidth * 0.85, // 90% of screen width
      child: Card(
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () => _handleCardTap(context),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 80, // Minimum height for the card
              maxHeight: 120, // Maximum height for the card
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: card.bgColor != null
                    ? Color(int.parse(card.bgColor!.substring(1), radix: 16) +
                        0xFF000000)
                    : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: IntrinsicHeight(
              // This helps with content alignment
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (card.icon != null) ...[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          card.icon!.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (card.formattedTitle != null)
                          FormattedTextWidget(
                            formattedText: card.formattedTitle!,
                          ),
                        if (card.formattedDescription != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: FormattedTextWidget(
                              formattedText: card.formattedDescription!,
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
      ),
    );
  }

  void _handleCardTap(BuildContext context) async {
    if (card.url != null) {
    try {
      await UrlService.openUrl(card.url);
    } catch (e) {
      // Handle error, maybe show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link: ${e.toString()}')),
      );
    }
  }
  }}