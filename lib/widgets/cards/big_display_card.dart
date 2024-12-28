import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';
import '../../services/storage_service.dart';
import '../formatted_text_widget.dart';
import 'card_actions.dart';

class BigDisplayCard extends StatefulWidget {
  final ContextualCard card;
  final StorageService storageService;
  final VoidCallback onAction;

  const BigDisplayCard({
    super.key,
    required this.card,
    required this.storageService,
    required this.onAction,
  });

  @override
  State<BigDisplayCard> createState() => _BigDisplayCardState();
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
      _isSlided = true;
    });
  }

  void _handleRemindLater() async {
    await widget.storageService.remindLater(widget.card.id);
    widget.onAction();
  }

  void _handleDismiss() async {
    await widget.storageService.dismissCard(widget.card.id);
    widget.onAction();
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
            child: _buildCard(),
          ),
          if (_isSlided)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: CardActions(
                onRemindLater: _handleRemindLater,
                onDismiss: _handleDismiss,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: _buildCardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.card.formattedTitle != null)
              FormattedTextWidget(
                formattedText: widget.card.formattedTitle!,
              ),
            if (widget.card.cta != null)
              ..._buildCTAButtons(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
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
    );
  }

  List<Widget> _buildCTAButtons() {
    return widget.card.cta!.map((cta) => ElevatedButton(
      onPressed: () {
        // Handle CTA action
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: cta.bgColor != null
            ? Color(int.parse(cta.bgColor!.substring(1), radix: 16) + 0xFF000000)
            : null,
        shape: cta.isCircular == true
            ? const CircleBorder()
            : null,
      ),
      child: Text(cta.text),
    )).toList();
  }
}