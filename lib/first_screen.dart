
import 'package:flutter/material.dart';
import 'package:task_1/second_page.dart';

class first_screen extends StatefulWidget {
  const first_screen({super.key});

  @override
  State<first_screen> createState() => _MyAppState();
}

class _MyAppState extends State<first_screen> {
  TextEditingController txt_mail = TextEditingController();
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_num = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? _selectedGender;
  DateTime? _selectedDate;
  int? _age;  
  bool eligible = false;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _calculateAge();
      });
    }
  }

  void _calculateAge() {
    if (_selectedDate != null) {
      DateTime today = DateTime.now();
      int age = today.year - _selectedDate!.year;

      // Adjust for cases where the birth date hasn't occurred yet this year
      if (today.month < _selectedDate!.month ||
          (today.month == _selectedDate!.month &&
              today.day < _selectedDate!.day)) {
        age--;
      }

      setState(() {
        _age = age;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.08; // Horizontal padding (8% of screen width)
    double verticalPadding = screenHeight * 0.1; // Vertical padding (10% of screen height)
    double buttonPadding = screenWidth * 0.07; // Button padding (7% of screen width)
    double textFieldPadding = screenHeight * 0.02; // TextField padding (2% of screen height)
    double fontSize = screenWidth * 0.05; // Font size (5% of screen width)
    
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/all_back.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, top: verticalPadding),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(66, 214, 8, 8),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.01),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name Field
                          _buildTextField(
                            label: 'Name',
                            controller: txt_name,
                            validator: validate_name,
                            keyboardType: TextInputType.name,
                            fontSize: fontSize,
                            
                          ),
                          SizedBox(height: textFieldPadding),

                          // Email Field
                          _buildTextField(
                            
                            label: 'Email',

                            controller: txt_mail,
                            validator: validate_mail,
                            keyboardType: TextInputType.emailAddress,
                            fontSize: fontSize,
                          ),
                          SizedBox(height: textFieldPadding),

                          // Number Field
                          _buildTextField(
                            label: 'Number',
                            controller: txt_num,
                            validator: validate_num,
                            keyboardType: TextInputType.phone,
                            fontSize: fontSize,
                          ),
                          SizedBox(height: textFieldPadding),

                          // Gender Selection
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Gender:',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Radio<String>(
                                value: 'Male',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                              Text('Male'),
                              SizedBox(width: 5),
                              Radio<String>(
                                value: 'Female',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                              Text('Female'),
                            ],
                          ),
                          SizedBox(height: 5),

                          // Gender Feedback Text
                          Text(
                            _selectedGender == null
                                ? 'Please select a gender'
                                : 'Selected Gender: $_selectedGender',
                            style: TextStyle(
                                fontSize: fontSize * 0.7, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 10),

                          // Date Picker Button
                          ElevatedButton(
                            onPressed: _pickDate,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 12),
                            ),
                            child: Text('Select Birth Date'),
                          ),
                          SizedBox(height: 10),

                          // Date & Age Info
                          if (_selectedDate != null)
                            if (_age != null)
                              Text(
                                'Your Age is: $_age years',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                          SizedBox(height: 10),

                          // Submit Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  print(txt_name.text);
                                  if (_formkey.currentState!.validate()) {
                                    if (_age != null &&
                                        _age! >= 18 &&
                                        _age! <= 25) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Second_Screen(
                                            name: txt_name.text,
                                            mail: txt_mail.text,
                                            number: txt_num.text,
                                            gender: _selectedGender.toString(),
                                            age: _age.toString(),
                                            
                                          ),

                                          
                                        ),
                                      );
                                    } else {
                                      print("Age is not within the valid range.");
                                      Text("You are not eligible");
                                    }
                                  } else {
                                    print("Form is not valid.");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 12),
                                ),
                                child: const Text("Submit"),
                              ),

                              // Second button for showing the details in a dialog
                              ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    if (_age != null &&
                                        _age! >= 18 &&
                                        _age! <= 25) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Filled Details'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  Text('Name: ${txt_name.text}'),
                                                  Text('Email: ${txt_mail.text}'),
                                                  Text('Phone Number: ${txt_num.text}'),
                                                  Text('Gender: ${_selectedGender ?? 'Not Selected'}'),
                                                  Text('Age: ${_age.toString()} years'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                },
                                                child: Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      print("Age is not within the valid range.");
                                      Text("You are not eligible");
                                    }
                                  } else {
                                    print("Form is not valid.");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: 12),
                                ),
                                child: const Text("View"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom TextField for Input Fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
    required double fontSize,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize,fontStyle: FontStyle.italic),
        filled: true,
        fillColor: Color.fromRGBO(240, 240, 240, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  String? validate_mail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validate_num(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your number';
    }
    if (value.length < 10) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String? validate_name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name should be at least 2 characters long';
    }
    return null;
  }
}
