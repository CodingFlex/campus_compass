// import 'package:http/http.dart';
// import 'dart:convert';

// import 'dart:convert';

// class ErrorParser {
//   static String parseClientException(dynamic error) {
//     if (error is ClientException) {
//       final responseData = error.response['data'];
//       if (responseData != null && responseData is Map) {
//         final firstErrorField = responseData.values.firstWhere(
//           (field) => field is Map && field.containsKey('message'),
//           orElse: () => null,
//         );
//         if (firstErrorField != null) {
//           return firstErrorField['message'];
//         }
//       }
//     }
//     return 'An error occurred';
//   }
// }
