import 'package:fam_assignment/services/url_service.dart';
import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';

class DynamicWidthCard extends StatelessWidget {
  final ContextualCard card;
  final double height;

  const DynamicWidthCard({
    Key? key,
    required this.card,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (card.bgImage?.imageUrl == null || card.bgImage?.aspectRatio == null) {
      return const SizedBox.shrink();
    }

    final size = MediaQuery.of(context).size;
    final borderRadius = size.width * 0.02; // 2% border radius
    final horizontalMargin = size.width * 0.045; // 2% margin
    final calculatedHeight =
        size.height * (height / 748); // Proportional to screen height
    final calculatedWidth = calculatedHeight * card.bgImage!.aspectRatio!;

    return Container(
      margin: EdgeInsets.only(
        left: horizontalMargin * 0.25,
      ),
      height: calculatedHeight,
      width: calculatedWidth,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(card.bgImage!.imageUrl!),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Handle image error
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to load image')),
                    );
                  });
                },
              ),
              gradient: _buildGradient(card),
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient? _buildGradient(ContextualCard card) {
    if (card.bgGradient == null) return null;

    return LinearGradient(
      colors: card.bgGradient!.colors
          .map((c) => Color(int.parse(c.substring(1), radix: 16) + 0xFF000000))
          .toList(),
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(card.bgGradient!.angle * (3.14159 / 180)),
    );
  }
}
