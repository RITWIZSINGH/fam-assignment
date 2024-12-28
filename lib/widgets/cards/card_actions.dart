import 'package:flutter/material.dart';

class CardActions extends StatelessWidget {
  final VoidCallback onRemindLater;
  final VoidCallback onDismiss;

  const CardActions({
    Key? key,
    required this.onRemindLater,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: onRemindLater,
          tooltip: 'Remind Later',
        ),
        const SizedBox(height: 8),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onDismiss,
          tooltip: 'Dismiss Now',
        ),
      ],
    );
  }
}