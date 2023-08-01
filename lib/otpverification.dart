// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class OTPScreen extends StatefulWidget {
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   String _generatedOTP = '';

  
  // Future<void> _verifyOTP() async {
  //   final int? userId = int.tryParse(_userIdController.text);
  //   final String otp = _otpController.text;
  //   if (userId != null && userId > 0 && otp.isNotEmpty) {
  //     try {
  //       final response = await http.post(
  //         Uri.parse('http://YOUR_SERVER_IP:5000/verify-otp'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode({'userId': userId, 'otp': otp}),
  //       );
  //       if (response.statusCode == 200) {
  //         setState(() {
  //           _otpVerified = true;
  //         });
  //       } else {
  //         // Handle OTP verification failure
  //         print('OTP verification failed: ${response.body}');
  //       }
  //     } catch (e) {
  //       // Handle network or other errors
  //       print('Error verifying OTP: $e');
  //     }
  //   } else {
  //     // Show an error message for invalid user ID or empty OTP
  //   }
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Screen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
          
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _generateOTP,
//               child: Text('Generate OTP'),
//             ),
//             SizedBox(height: 16),
//             _generatedOTP.isNotEmpty
//                 ? Column(
//                     children: [
//                       TextField(
//                         controller: _otpController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Enter OTP',
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: _verifyOTP,
//                         child: Text('Verify OTP'),
//                       ),
//                       SizedBox(height: 16),
//                       _otpVerified
//                           ? Text(
//                               'OTP Verified!',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             )
//                           : Container(),
//                     ],
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }

