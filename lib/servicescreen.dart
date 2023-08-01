import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceProviderScreen extends StatefulWidget {
  @override
  _ServiceProviderScreenState createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  bool _otpVerified = false;
  String response_statement = "";

  Future<void> _verifyOTP() async {
    final int? userId = int.tryParse(_userIdController.text);
    final String otp = _otpController.text;
    if (userId != null && userId > 0 && otp.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('https://otpverification-3i4b.onrender.com/verify-otp'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'userId': userId, 'otp': otp}),
        );
        if (response.statusCode == 200) {
          setState(() {
            _otpVerified = true;
          });
        } else {
          // Handle OTP verification failure
          if (response.statusCode == 401) {
            setState(() {
              response_statement = "Invalid OTP";
            });
            print('Invalid OTP: ${response.body}');
          } else {
            setState(() {
              response_statement = "OTP verification failed";
            });
            print('OTP verification failed: ${response.body}');
          }
        }
      } catch (e) {
        // Handle network or other errors
        print('Error verifying OTP: $e');
      }
    } else {
      // Show an error message for invalid user ID or empty OTP
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Provider Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  
                });
              },
              decoration: InputDecoration(
                labelText: 'User ID',
              ),
            ),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: Text('Verify OTP'),
            ),
            SizedBox(height: 16),
            _otpVerified
                ? Text(
                    'OTP Verified!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    response_statement,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }
}
