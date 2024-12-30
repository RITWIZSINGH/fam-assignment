// import 'package:fam_assignment/services/url_service.dart';
// import 'package:flutter/material.dart';
// import '../../models/contextual_card.dart';
// import '../formatted_text_widget.dart';

// class CardContent extends StatelessWidget {
//   final ContextualCard card;

//   const CardContent({
//     Key? key,
//     required this.card,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     // Calculate responsive dimensions
//     final iconHeight = size.height * 0.077;
//     final iconWidth = size.width * 0.135;
//     final largePadding = size.height * 0.021;
//     final smallPadding = size.height * 0.011;
//     final fontSize = size.width * 0.039;
//     final buttonHeight = size.height * 0.053;
//     final buttonWidth = size.width * 0.282;
//     final borderRadius = size.width * 0.023;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (card.icon?.imageUrl != null)
//           Image.network(
//             card.icon!.imageUrl!,
//             height: iconHeight,
//             width: iconWidth,
//             errorBuilder: (context, error, stackTrace) {
//               return SizedBox(
//                 height: iconHeight,
//                 width: iconWidth,
//                 child: Icon(
//                   Icons.error_outline,
//                   size: iconHeight * 0.7,
//                   color: Colors.grey,
//                 ),
//               );
//             },
//           ),
//         SizedBox(height: largePadding),
//         if (card.formattedTitle != null)
//           FormattedTextWidget(
//             formattedText: card.formattedTitle!,
//           ),
//         SizedBox(height: smallPadding),
//         if (card.description != null)
//           FormattedTextWidget(formattedText: card.formattedDescription!),
//         SizedBox(height: largePadding),
//         if (card.cta != null)
//           ..._buildCTAButtons(
//             context: context,
//             buttonHeight: buttonHeight,
//             buttonWidth: buttonWidth,
//             borderRadius: borderRadius,
//             fontSize: fontSize,
//           ),
//       ],
//     );
//   }

//   List<Widget> _buildCTAButtons({
//     required BuildContext context,
//     required double buttonHeight,
//     required double buttonWidth,
//     required double borderRadius,
//     required double fontSize,
//   }) {
//     return card.cta!.map((cta) {
//       final buttonColor = cta.bgColor != null
//           ? Color(int.parse(cta.bgColor!.substring(1), radix: 16) + 0xFF000000)
//           : Colors.black;

//       return Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.011),
//         child: ElevatedButton(
//           onPressed: () => _handleCTAAction(context, cta),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: buttonColor,
//             minimumSize: Size(buttonWidth, buttonHeight),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(borderRadius),
//             ),
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.028,
//               vertical: MediaQuery.of(context).size.height * 0.013,
//             ),
//           ),
//           child: Text(
//             cta.text,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: fontSize,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   void _handleCTAAction(BuildContext context, dynamic cta) {
//     // Handle CTA action
//     if (cta.url != null) {
//       try {
//         UrlService.openUrl(cta.url);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Could not open the link: ${e.toString()}')),
//         );
//       }
//     }
//   }
// }
