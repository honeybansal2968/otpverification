import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:otpverification/servicescreen.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController _userIdController = TextEditingController();
  String _generatedOTP = '';
  bool _otpVerified = false;
  Future<void> _generateOTP() async {
    final int? userId = int.tryParse(_userIdController.text);

    if (userId != null && userId > 0) {
      try {
        final response = await http.post(
          Uri.parse('https://otpverification-3i4b.onrender.com/api/generate-otp'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'userId': userId}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final otp = data['otp'];

          setState(() {
            _generatedOTP = otp;
            _otpVerified = false;
          });
        } else {
          // Handle API error
          print('Error generating OTP: ${response.body}');
        }
      } catch (e) {
        // Handle network or other errors
        print('Error generating OTP: $e');
      }
    } else {
      // Show an error message for invalid user ID
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Screen'),
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
            _userIdController.text.isEmpty ? Container() :_generatedOTP.isEmpty? ElevatedButton(
              onPressed: _generateOTP,
              child: Text('Generate OTP'),
            ):Container(),
            SizedBox(height: 16),
            _generatedOTP.isNotEmpty
                ? Column(
                  children: [
                    Text(
                        'Generated OTP: $_generatedOTP',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ServiceProviderScreen()));
                      }, child:Text("Go to verification page"))
                  ],
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
