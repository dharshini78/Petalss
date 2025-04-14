import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'pages/enter_otp_page.dart'; // Import the EnterOtpPage
import 'package:petalss/pages/enter_otp_page.dart'; // Import the EnterOtpPage
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF9575CD),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: OnboardingScreen(),
      routes: {
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background design
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFFFF0F7)],
                ),
              ),
            ),
          ),

          // Decorative elements
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF9575CD).withOpacity(0.1),
              ),
            ),
          ),

          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF9575CD).withOpacity(0.1),
              ),
            ),
          ),

          // Main content
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              buildFeaturePage(
                image: 'assets/images/undraw_buddies_udt4.png',
                title: 'Connect with Real People',
                description: 'Our platform ensures you talk to verified individuals who share your interests and passions, creating meaningful connections that last.',
              ),
              buildFeaturePage(
                image: 'assets/images/undraw_friends_xscy.png',
                title: 'Join Our Community',
                description: 'Be part of an inclusive, supportive environment where you can share experiences, learn from others, and grow together.',
                buttonText: 'Get Started',
                onButtonPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),

          // Page indicators
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),

          // Skip button
          Positioned(
            top: 60,
            right: 20,
            child: _currentPage == 0
              ? TextButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xFF9575CD),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget buildFeaturePage({
    required String image,
    required String title,
    required String description,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 350,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          if (buttonText != null)
            ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9575CD),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
                shadowColor: Color(0xFF9575CD).withOpacity(0.5),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 2; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 28.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF9575CD) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: isActive
          ? [BoxShadow(
              color: Color(0xFF9575CD).withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 1),
            )]
          : null,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  CountryCode _countryCode = CountryCode.fromDialCode('+91');

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

                  // Login image
                  Center(
                    child: Image.asset(
                      'assets/images/undraw_phone-call_ov3z.png',
                      height: 280,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 40),

                  // Login heading
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Login subheading with description
                  Text(
                    'Sign in with your phone number',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Country code and phone input
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFFE0E0E0), width: 1.5),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        // Country code picker
                        CountryCodePicker(
                          onChanged: (CountryCode code) {
                            setState(() {
                              _countryCode = code;
                            });
                          },
                          initialSelection: 'IN',
                          favorite: ['+91', '+1'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          padding: EdgeInsets.zero,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF333333),
                          ),
                        ),

                        // Divider
                        Container(
                          height: 30,
                          width: 1,
                          color: Color(0xFFE0E0E0),
                        ),

                        // Phone number input
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                color: Color(0xFFAAAAAA),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            ),
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 50),

                  // Get OTP button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle OTP button press
                        if (_phoneController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EnterOtpPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a valid phone number'),
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
                        'Get OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Terms and privacy text
                  Center(
                    child: Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF999999),
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
