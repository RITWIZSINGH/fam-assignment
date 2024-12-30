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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => _handleCardTap(context),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: card.bgColor != null
                  ? Color(int.parse(card.bgColor!.substring(1), radix: 16) +
                      0xFF000000)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              if (card.icon != null)
                Image.network(
                  card.icon!.imageUrl!,
                  width: card.icon!.aspectRatio != null
                      ? 24 * card.icon!.aspectRatio!
                      : 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              const SizedBox(width: 8),
              Expanded(
                child: card.formattedTitle != null
                    ? FormattedTextWidget(formattedText: card.formattedTitle!)
                    : Text(card.title ?? ''),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
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
