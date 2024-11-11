import 'package:flutter/material.dart';

class Second_Screen extends StatefulWidget {
  const Second_Screen({
    super.key,
    required this.name,
    required this.mail,
    required this.number,
    required this.gender,
    required this.age,
  });

  final String name;
  final String mail;
  final String gender;
  final String number;
  final String age;

  @override
  State<Second_Screen> createState() => _Second_ScreenState();
}

class _Second_ScreenState extends State<Second_Screen> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.08; // 8% of screen width for padding
    double verticalPadding = screenHeight * 0.1; // 10% of screen height for padding
    double fontSize = screenWidth * 0.05; // Font size based on screen width
    double cardHeight = screenHeight * 0.12; // Card height (12% of screen height)

    return Scaffold(
      body: Stack(
        children: [
          
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/all_back.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: screenWidth * 0.89, // Width of the container is 80% of screen width
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                children: [
                  // Name Card
                  Card(
                   
                    child: ListTile(
                      title: Text(
                        widget.name,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  // Email Card
                  Card(
                 
                    child: ListTile(
                      title: Text(
                        widget.mail,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  // Number Card
                  Card(
                   
                    child: ListTile(
                      title: Text(
                        widget.number,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  // Age Card
                  Card(
                 
                    child: ListTile(
                      title: Text(
                        widget.age,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  // Gender Card
                  Card(
                   
                    child: ListTile(
                      title: Text(
                        widget.gender,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
