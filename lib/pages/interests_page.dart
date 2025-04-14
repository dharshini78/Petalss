import 'package:flutter/material.dart';
import 'name_page.dart'; // Import the NamePage

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  final List<String> _interests = [
    'Music',
    'Sports',
    'Travel',
    'Food',
    'Technology',
    'Art',
    'Fitness',
    'Reading',
  ];
  final Set<String> _selectedInterests = {};

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
                // Interests image
                Center(
                  child: Image.asset(
                    'assets/images/undraw_online-posts_avfn.png',
                    height: 280,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 40),
                // Interests heading
                Text(
                  'Select Your Interests',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 15),
                // Interests subheading with description
                Text(
                  'Select up to 4 interests that you are passionate about. This will help us personalize your experience.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
                SizedBox(height: 40),
                // Interests tags
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: _interests.map((interest) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedInterests.contains(interest)) {
                            _selectedInterests.remove(interest);
                          } else if (_selectedInterests.length < 4) {
                            _selectedInterests.add(interest);
                          }
                        });
                      },
                      child: Chip(
                        label: Text(
                          interest,
                          style: TextStyle(
                            color: _selectedInterests.contains(interest)
                                ? Colors.white
                                : Color(0xFF333333),
                          ),
                        ),
                        backgroundColor: _selectedInterests.contains(interest)
                            ? Color(0xFF9575CD)
                            : Colors.white,
                        side: BorderSide(
                          color: Color(0xFF333333),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 50),
                // Next button
                Center(
                  child: ElevatedButton(
                    onPressed: _selectedInterests.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NamePage()),
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
                      'Next',
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
