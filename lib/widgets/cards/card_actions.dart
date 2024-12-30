// ignore_for_file: use_super_parameters

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
    final size = MediaQuery.of(context).size;
    
    // Calculate responsive dimensions
    final borderRadius = size.width * 0.034; // ~12px on 354.28px width
    final horizontalPadding = size.width * 0.023; // ~8px on 354.28px width
    final verticalPadding = size.height * 0.021; // ~16px on 748px height
    final buttonSpacing = size.height * 0.032; // ~24px on 748px height

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
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
            icon: Icons.notifications_outlined,
            label: 'remind later',
            onTap: onRemindLater,
            color: Colors.amber,
          ),
          SizedBox(height: buttonSpacing),
          _buildActionButton(
            context: context,
            icon: Icons.close_rounded,
            label: 'dismiss now',
            onTap: onDismiss,
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
    
    // Calculate responsive dimensions
    final buttonBorderRadius = size.width * 0.034; // ~12px on 354.28px width
    final buttonPadding = size.width * 0.023; // ~8px on 354.28px width
    final iconSize = size.width * 0.079; // ~28px on 354.28px width
    final textSpacing = size.height * 0.005; // ~4px on 748px height
    final fontSize = size.width * 0.034; // ~12px on 354.28px width

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
          padding: EdgeInsets.all(buttonPadding),
          child: IconButton(
            icon: Icon(
              icon, 
              color: color,
              size: iconSize,
            ),
            onPressed: onTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: iconSize * 1.5,
              minHeight: iconSize * 1.5,
            ),
          ),
        ),
        SizedBox(height: textSpacing),
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}