import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dob_page.dart'; // Import the DobPage

class EnterOtpPage extends StatefulWidget {
  @override
  _EnterOtpPageState createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFFFF0F7)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Color(0xFF333333)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(height: 20),
                  // OTP image
                  Center(
                    child: Image.asset(
                      'assets/images/undraw_in-real-life_8znn.png',
                      height: 280,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 40),
                  // OTP heading
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 15),
                  // OTP subheading with description
                  Text(
                    'Enter the OTP sent to your phone number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(height: 40),
                  // OTP input field
                  PinCodeTextField(
                    controller: _otpController,
                    length: 6,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: Color(0xFF9575CD),
                      inactiveColor: Color(0xFFE0E0E0),
                      selectedColor: Color(0xFF9575CD),
                    ),
                    onChanged: (value) {},
                    appContext: context,
                  ),
                  SizedBox(height: 50),
                  // Verify OTP button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Verify OTP button press
                        if (_otpController.text.length == 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('OTP Verified Successfully'),
                              backgroundColor: Color(0xFF4CAF50),
                            ),
                          );
                          // Navigate to the DobPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DobPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a valid OTP'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9575CD),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                        shadowColor: Color(0xFF9575CD).withOpacity(0.5),
                      ),
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Resend OTP text
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Handle Resend OTP button press
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('OTP Resent Successfully'),
                            backgroundColor: Color(0xFF4CAF50),
                          ),
                        );
                      },
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9575CD),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
