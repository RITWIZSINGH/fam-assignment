import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';
import '../formatted_text_widget.dart';

class BigDisplayCard extends StatefulWidget {
  final ContextualCard card;

  const BigDisplayCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  _BigDisplayCardState createState() => _BigDisplayCardState();
}

class _BigDisplayCardState extends State<BigDisplayCard> {
  bool _isSlided = false;

  void _onLongPressStart(LongPressStartDetails details) {
    setState(() {
      _isSlided = true;
    });
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    setState(() {
      _isSlided = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: _onLongPressStart,
      onLongPressEnd: _onLongPressEnd,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.translationValues(
              _isSlided ? 100.0 : 0.0,
              0.0,
              0.0,
            ),
            child: Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.card.bgColor != null
                      ? Color(int.parse(widget.card.bgColor!.substring(1), radix: 16) + 0xFF000000)
                      : null,
                  gradient: widget.card.bgGradient != null
                      ? LinearGradient(
                          colors: widget.card.bgGradient!.colors
                              .map((c) => Color(int.parse(c.substring(1), radix: 16) + 0xFF000000))
                              .toList(),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          transform: GradientRotation(
                              widget.card.bgGradient!.angle * (3.14159 / 180)),
                        )
                      : null,
                  image: widget.card.bgImage?.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(widget.card.bgImage!.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.card.formattedTitle != null)
                      FormattedTextWidget(
                        formattedText: widget.card.formattedTitle!,
                      ),
                    if (widget.card.cta != null && widget.card.cta!.isNotEmpty)
                      ...widget.card.cta!.map((cta) => ElevatedButton(
                            onPressed: () {
                              // Handle CTA action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cta.bgColor != null
                                  ? Color(int.parse(cta.bgColor!.substring(1),
                                          radix: 16) +
                                      0xFF000000)
                                  : null,
                              shape: cta.isCircular == true
                                  ? const CircleBorder()
                                  : null,
                            ),
                            child: Text(cta.text),
                          )),
                  ],
                ),
              ),
            ),
          ),
          if (_isSlided)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      // Handle remind later
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Handle dismiss now
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}