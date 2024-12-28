import 'package:flutter/material.dart';
import '../models/contextual_card.dart';

class FormattedTextWidget extends StatelessWidget {
  final FormattedText formattedText;

  const FormattedTextWidget({
    Key? key,
    required this.formattedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = [];
    final List<String> textParts = formattedText.text.split('{}');
    int entityIndex = 0;

    for (int i = 0; i < textParts.length; i++) {
      // Add the regular text part
      if (textParts[i].isNotEmpty) {
        textSpans.add(TextSpan(text: textParts[i]));
      }

      // Add the entity if available
      if (entityIndex < formattedText.entities.length) {
        final entity = formattedText.entities[entityIndex];
        textSpans.add(
          TextSpan(
            text: entity.text,
            style: TextStyle(
              color: entity.color != null
                  ? Color(int.parse(entity.color!.substring(1), radix: 16) +
                      0xFF000000)
                  : null,
              fontSize: entity.fontSize?.toDouble(),
              decoration: entity.fontStyle == 'underline'
                  ? TextDecoration.underline
                  : null,
              fontStyle:
                  entity.fontStyle == 'italic' ? FontStyle.italic : FontStyle.normal,
              fontFamily: entity.fontFamily,
            ),
          ),
        );
        entityIndex++;
      }
    }

    return Text.rich(
      TextSpan(children: textSpans),
      textAlign: _getTextAlign(formattedText.align),
    );
  }

  TextAlign _getTextAlign(String? align) {
    switch (align?.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
      default:
        return TextAlign.left;
    }
  }
}