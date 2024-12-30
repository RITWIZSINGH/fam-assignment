import 'package:fam_assignment/services/url_service.dart';
import 'package:fam_assignment/widgets/formatted_text_widget.dart';
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
      end: 100.0,
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
      _dragOffset = 100.0;
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

  void _handleCtaAction() async {
    if (widget.card.url != null) {
      try {
        await UrlService.openUrl(widget.card.url);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the link: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final margin = size.width * 0.025; // ~16px

    return GestureDetector(
      onLongPress: _handleLongPress,
      onTap: _handleTap,
      child: Container(
        margin: EdgeInsets.all(margin),
        child: Stack(
          children: [
            if (_isSlided)
              Positioned(
                left: size.width * 0.017, // ~6px
                top: 0,
                bottom: 0,
                child: _buildActions(context),
              ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(_dragOffset, 0.0, 0.0),
              child: _buildCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final borderRadius = size.width * 0.034; // ~12px
    final horizontalPadding = size.width * 0.05; // ~24px
    final topPadding = size.height * 0.148; // ~120px
    final bottomPadding = size.width * 0.068; // ~24px
    final titleSpacing = size.height * 0.01; // ~8px
    final buttonSpacing = size.height * 0.011; // ~9px

    return AspectRatio(
      aspectRatio: widget.card.bgImage?.aspectRatio ?? 1.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: widget.card.bgImage?.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(widget.card.bgImage!.imageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
          color: const Color(0xFF5C6BC0),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, topPadding, horizontalPadding, topPadding * 0.1
              // bottomPadding,
              ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((widget.card.formattedTitle?.entities.length ?? 0) >
                            1)
                          Padding(
                            padding: EdgeInsets.only(top: titleSpacing),
                            child: widget.card.formattedTitle != null
                                ? FormattedTextWidget(
                                    formattedText: widget.card.formattedTitle!)
                                : Text(
                                    widget.card.title ?? '',
                                    style: TextStyle(
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.card.cta?.isNotEmpty ?? false) ...[
                    SizedBox(height: buttonSpacing),
                    _buildCtaButton(context),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCtaButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonHeight = size.height * 0.062; // ~50px
    final buttonWidth = size.width * 0.339; // ~120px
    final buttonRadius = size.width * 0.023; // ~8px

    return ElevatedButton(
      onPressed: _handleCtaAction,
      style: ElevatedButton.styleFrom(
        backgroundColor: _parseColor(widget.card.cta![0].bgColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        minimumSize: Size(buttonWidth, buttonHeight),
      ),
      child: Text(
        widget.card.cta![0].text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size.width * 0.04,
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final borderRadius = size.width * 0.034; // ~12px
    final horizontalPadding = size.width * 0.023; // ~8px
    final verticalPadding = size.height * 0.02; // ~16px
    final actionSpacing = size.height * 0.03; // ~24px

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: size.width * 0.003, // ~1px
            blurRadius: size.width * 0.014, // ~5px
            offset: Offset(0, size.width * 0.006), // ~2px
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            context: context,
            icon: Icons.notifications,
            label: 'remind later',
            onTap: _handleRemindLater,
            color: Colors.amber,
          ),
          SizedBox(height: actionSpacing),
          _buildActionButton(
            context: context,
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
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    final size = MediaQuery.of(context).size;
    final borderRadius = size.width * 0.034; // ~12px
    final padding = size.width * 0.023; // ~8px
    final iconSize = size.width * 0.079; // ~28px
    final labelSpacing = size.height * 0.005; // ~4px

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.all(padding),
          child: IconButton(
            icon: Icon(icon, color: color, size: iconSize),
            onPressed: onTap,
          ),
        ),
        SizedBox(height: labelSpacing),
        Text(
          label,
          style: TextStyle(
            fontSize: size.width * 0.034, // ~12px
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
