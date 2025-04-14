import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController _nameController = TextEditingController();

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
                // Name image
                Center(
                  child: Image.asset(
                    'assets/images/undraw_friends_xscy.png',
                    height: 280,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 40),
                // Name heading
                Text(
                  'Enter Your Name',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 15),
                // Name subheading with description
                Text(
                  'Enter your name to personalize your experience and connect with others.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
                SizedBox(height: 40),
                // Name input field
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    hintStyle: TextStyle(
                      color: Color(0xFFAAAAAA),
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                  onChanged: (text) {
                    setState(() {}); // Update the state to enable/disable the button
                  },
                ),
                SizedBox(height: 50),
                // Begin button
                Center(
                  child: ElevatedButton(
                    onPressed: _nameController.text.isEmpty
                        ? null
                        : () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
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
                      'Begin',
                      style: TextStyle(
                        fontSize: 18,
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
    );
  }
}
