import 'package:flutter/material.dart';

class HireFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hire a Friend'),
      ),
      body: Center(
        child: Text(
          'Hire a Friend',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
