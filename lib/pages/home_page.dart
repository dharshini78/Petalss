 import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui';
import 'package:petalss/pages/community_page.dart';
import 'package:petalss/pages/medicines_page.dart';
import 'package:petalss/pages/groceries_page.dart';
import 'package:petalss/pages/hire_friend_page.dart';
import 'package:petalss/pages/pet_therapy_page.dart';
import 'package:petalss/pages/guard_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _location;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  int _currentFeatureIndex = 0;

  // List of feature items for the slider
  final List<Map<String, String>> _featureItems = [
    {'image': 'assets/images/womendays.png'},
    {'image': 'assets/images/friends2.png'},
    {'image': 'assets/images/dog1.png'},
    {'image': 'assets/images/guard2.png'},
    {'image': 'assets/images/community1.png'},
    {'image': 'assets/images/pharmacy.png'},
    {'image': 'assets/images/grocery1.png'},
  ];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    // Auto-scroll for features
    Future.delayed(Duration(seconds: 1), () {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        if (_currentFeatureIndex < _featureItems.length - 1) {
          _currentFeatureIndex++;
        } else {
          _currentFeatureIndex = 0;
        }
        _pageController.animateToPage(
          _currentFeatureIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _getLocation();
    } else {
      // Handle the case where the user denies permission
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _location = '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      // Handle error
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Community Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Tracker Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Profile Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 246, 246, 246),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // First Row - App Title with location and profile
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '16 Minutes to a Better Day',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          if (_location != null)
                            Text(
                              _location!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                              ),
                            ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.person, color: Color(0xFF9575CD)),
                        onPressed: () {
                          // Handle profile icon press
                        },
                      ),
                    ],
                  ),
                ),

                // Second Row - Hello User
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
                  child: Text(
                    'Hello, Sarah',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),

                // AI Chat TextField
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Talk with Aira how you feel',
                        hintStyle: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        prefixIcon: Icon(
                          Icons.local_florist,
                          color: Color(0xFF9575CD),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF9575CD).withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xFF9575CD),
                            width: 1.5,
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                    ),
                  ),
                ),

                // Features Slideshow
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Let Us Help You Today',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your well-being matters. Find the support you need with our range of personalized services.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                      ),
                      SizedBox(height: 25),

                      // Simple Image Slider
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _featureItems.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentFeatureIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return _buildImageSlide(
                              image: _featureItems[index]['image']!,
                            );
                          },
                        ),
                      ),

                      // Page indicator
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _featureItems.length,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _currentFeatureIndex == index
                                      ? Color(0xFF9575CD)
                                      : Color(0xFF9575CD).withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Explore Petals Section
             Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Explore Petals',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Services designed with you in mind. Find comfort, connection, and convenience in every petal.',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF666666),
        ),
      ),
      SizedBox(height: 15),
      GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.8,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HireFriendPage(),
                ),
              );
            },
            child: _buildGlassmorphicExploreCard(
              image: 'assets/images/friends.png',
              title: 'Hire a friend',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetTherapyPage(),
                ),
              );
            },
            child: _buildGlassmorphicExploreCard(
              image: 'assets/images/ears.png',
              title: 'Pet Therapy',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuardPage()),
              );
            },
            child: _buildGlassmorphicExploreCard(
              image: 'assets/images/guardof.png',
              title: 'Guard',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommunityPage(),
                ),
              );
            },
            child: _buildGlassmorphicExploreCard(
              image: 'assets/images/com.png',
              title: 'Community',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicinesPage(),
                ),
              );
            },
            child: _buildGlassmorphicExploreCard(
              image: 'assets/images/medicine.png',
              title: 'Medicines',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroceriesPage(),
                ),
              );
            },
            child: _buildGlassmorphicExploreCard(
              image: 'assets/images/groceryyy.png',
              title: 'Groceries',
            ),
          ),
        ],
      ),
    ],
  ),
),


                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF9575CD),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }

  Widget _buildImageSlide({required String image}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildGlassmorphicExploreCard({
    required String image,
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.7),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(-3, -3),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(3, 3),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.6),
                  Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Image.asset(image, fit: BoxFit.contain)),
                SizedBox(height: 5),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
