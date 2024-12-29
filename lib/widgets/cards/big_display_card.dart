// big_display_card.dart
import 'package:flutter/material.dart';
import '../../models/contextual_card.dart';
import '../../services/storage_service.dart';

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

class _BigDisplayCardState extends State<BigDisplayCard>
    with SingleTickerProviderStateMixin {
  bool _isSlided = false;
  double _dragOffset = 0.0;
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 100.0, // Changed to negative for left slide
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation.addListener(() {
      setState(() {
        _dragOffset = _slideAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _handleLongPress() {
    setState(() {
      _isSlided = true;
      _dragOffset = 100.0; // Changed to negative for left slide
      _slideController.forward();
    });
  }

  void _handleTap() {
    if (_isSlided) {
      setState(() {
        _isSlided = false;
        _dragOffset = 0.0;
      });
      _slideController.reverse();
    }
  }

  void _handleRemindLater() async {
    await widget.storageService.remindLater(widget.card.id);
    widget.onAction();
  }

  void _handleDismiss() async {
    await widget.storageService.dismissCard(widget.card.id);
    widget.onAction();
  }

  void _handleCtaAction() {
    if (widget.card.url != null) {
      print('Navigate to: ${widget.card.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _handleLongPress,
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Stack(
          children: [
            if (_isSlided)
              Positioned(
                left: 10, // Changed from right to left
                top: 0,
                bottom: 0,
                child: _buildActions(),
              ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(_dragOffset, 0.0, 0.0),
              child: _buildCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    final formattedTitle = widget.card.formattedTitle;
    final entities = formattedTitle?.entities ?? [];

    return AspectRatio(
      aspectRatio: widget.card.bgImage?.aspectRatio ?? 1.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: widget.card.bgImage?.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(widget.card.bgImage!.imageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
          color: const Color(0xFF5C6BC0),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (entities.isNotEmpty) ...[
                    Text(
                      entities[0].text,
                      style: TextStyle(
                        fontSize: entities[0].fontSize?.toDouble() ?? 30,
                        color: _parseColor(entities[0].color),
                        fontWeight: FontWeight.bold,
                        fontFamily: entities[0].fontFamily,
                      ),
                    ),
                    if (entities.length > 1)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          entities[1].text,
                          style: TextStyle(
                            fontSize: entities[1].fontSize?.toDouble() ?? 16,
                            color: _parseColor(entities[1].color),
                            fontFamily: entities[1].fontFamily,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
              if (widget.card.cta?.isNotEmpty ?? false)
                ElevatedButton(
                  onPressed: _handleCtaAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _parseColor(widget.card.cta![0].bgColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(100, 40),
                  ),
                  child: Text(
                    widget.card.cta![0].text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            icon: Icons.notifications,
            label: 'remind later',
            onTap: _handleRemindLater,
            color: Colors.amber,
          ),
          const SizedBox(height: 24),
          _buildActionButton(
            icon: Icons.close,
            label: 'dismiss now',
            onTap: _handleDismiss,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(icon, color: color, size: 28),
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _parseColor(String? colorString) {
    if (colorString == null) return Colors.white;
    if (colorString.startsWith('#')) {
      return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
    }
    return Colors.white;
  }
}
