// import 'package:app_developments/core/extension/context_extension.dart';
// import 'package:flutter/material.dart';

// class CustomContinueButton extends StatelessWidget {
//   // used required because most of the button have different texts and different onPressed functions (probably)
//   // and the bgColor required too because of the changing the color when the button disabled or not
//   final String buttonText;
//   final VoidCallback onPressed;
//   final Color bgColor;
//   const CustomContinueButton(
//       {super.key,
//       required this.buttonText,
//       required this.onPressed,
//       required this.bgColor});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: context.width * 0.035, vertical: context.width * 0.06),
//       child: SizedBox(
//         width: double.infinity,
//         height: 50,
//         child: ElevatedButton(
//             onPressed: onPressed,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: bgColor,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24)),
//             ),
//             child: Text(buttonText)),
//       ),
//     );
//   }
// }
