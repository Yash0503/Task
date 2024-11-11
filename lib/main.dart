import 'package:flutter/material.dart';
import 'package:task_1/first_screen.dart';
import 'package:task_1/second_page.dart';
import 'package:task_1/third_screen.dart'; // For date formatting

void main() {
     WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/First_back.jpg'),
                fit: BoxFit.cover),
          ),
        ),
       Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => first_screen()));
                  },
                  child: Text("Task 1")),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CurrencyConverterScreen()));
                  },
                  child: Text("Task 2")),
         ],),
       )
      ],
    ));
  }
}
