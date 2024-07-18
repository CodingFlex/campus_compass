// import 'package:biolog_mobile_app/constant/colors.dart';
// import 'package:flutter/material.dart';

// Widget customButton({
//   required String text,
//   required VoidCallback onPressed,
//   required double width,
//   required double? height,
//   bool isLoading = false, // Add a new parameter for loading state
// }) {
//   return GestureDetector(
//     onTap: isLoading ? null : onPressed,
//     child: SizedBox(
//       height: height,
//       width: width,
//       child: Material(
//         borderRadius: BorderRadius.circular(10.0),
//         color: isLoading ? Colors.grey : AppColors.baseColor,
//         elevation: 1.0,
//         child: Center(
//           child: isLoading
//               ? const CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 )
//               : Text(
//                   text,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//         ),
//       ),
//     ),
//   );
// }

// Widget customWhiteButton({
//   required String text,
//   required VoidCallback onPressed,
//   required double width,
//   required double? height,
// }) {
//   return GestureDetector(
//     onTap: onPressed,
//     child: SizedBox(
//       height: height,
//       width: width,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white, // Fill the GestureDetector with white color
//           borderRadius: BorderRadius.circular(15.0),
//           border: Border.all(
//               color: AppColors.baseColor,
//               width: 2.0), // Set border color and width
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.blue, // Adjust the text color as needed
//               fontWeight: FontWeight.bold,

//               fontSize: 20,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget customBiometricsButton({
//   required String text,
//   required VoidCallback onPressed,
//   required double width,
//   required double? height,
// }) {
//   return GestureDetector(
//     onTap: onPressed,
//     child: SizedBox(
//       height: height,
//       width: width,
//       child: Material(
//         borderRadius: BorderRadius.circular(2.0),
//         color: AppColors.baseColor,
//         elevation: 1.0,
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget customBar({
//   required Color color,
// }) {
//   return Container(
//     margin: const EdgeInsets.all(4),
//     width: 35,
//     height: 6,
//     decoration: BoxDecoration(
//       color: color,
//       shape: BoxShape.rectangle,
//       borderRadius: BorderRadius.circular(5),
//     ),
//   );
// }
