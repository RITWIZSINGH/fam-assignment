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
    return Card(
      child: InkWell(
        onTap: () => _handleCardTap(context),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: card.bgColor != null
                ? Color(int.parse(card.bgColor!.substring(1), radix: 16) + 0xFF000000)
                : Colors.white,
          ),
          child: Row(
            children: [
              if (card.icon != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    card.icon!.imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (card.formattedTitle != null)
                      FormattedTextWidget(formattedText: card.formattedTitle!),
                    if (card.formattedDescription != null)
                      FormattedTextWidget(formattedText: card.formattedDescription!),
                  ],
                ),
              ),
            ],
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