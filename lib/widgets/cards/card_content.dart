import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';
import '../formatted_text_widget.dart';

class CardContent extends StatelessWidget {
  final ContextualCard card;

  const CardContent({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (card.icon?.imageUrl != null)
          Image.network(
            card.icon!.imageUrl!,
            height: 58,
            width: 48,
          ),
        const SizedBox(height: 16),
        if (card.formattedTitle != null)
          FormattedTextWidget(
            formattedText: card.formattedTitle!,
          ),
        const SizedBox(height: 8),
        if (card.description != null)
          Text(
            card.description!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        const SizedBox(height: 16),
        if (card.cta != null) ..._buildCTAButtons(),
      ],
    );
  }

  List<Widget> _buildCTAButtons() {
    return card.cta!
        .map((cta) => ElevatedButton(
              onPressed: () {
                // Handle CTA action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cta.bgColor != null
                    ? Color(int.parse(cta.bgColor!.substring(1), radix: 16) +
                        0xFF000000)
                    : Colors.black,
                minimumSize: const Size(100, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                cta.text,
                style: const TextStyle(color: Colors.white),
              ),
            ))
        .toList();
  }
}
