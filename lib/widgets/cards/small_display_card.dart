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
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.85,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () => _handleCardTap(context),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 80,
              maxHeight: 120,
            ),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: card.bgColor != null
                  ? Color(int.parse(card.bgColor!.substring(1), radix: 16) +
                      0xFF000000)
                  : Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (card.icon != null) ...[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
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
                                padding: const EdgeInsets.only(top: 0),
                                child: FormattedTextWidget(
                                  formattedText: card.formattedDescription!,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
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
      // Handle error, maybe show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link: ${e.toString()}')),
      );
    }
  }
  }
}
