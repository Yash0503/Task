import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Load history when the app starts
  }

  // Load history from SharedPreferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyData = prefs.getStringList('history') ?? [];
    setState(() {
      _history = historyData; // Update the state to reflect loaded history
    });
  }

  // Save history to SharedPreferences
  Future<void> _saveHistory(String input, String output) async {
    final prefs = await SharedPreferences.getInstance();
    final historyEntry = "Input: $input → Output: $output";
    _history.add(historyEntry); // Add new entry to the history list
    await prefs.setStringList('history', _history); // Save updated history to SharedPreferences
  }

  // Convert number to Indian currency words
  void _convertCurrency() {
    double? number = double.tryParse(_controller.text);
    if (number != null) {
      String result = convertNumberToWords(number);
      setState(() {
        _result = result;
      });
      _saveHistory(_controller.text, result); // Save input and output to history
    } else {
      setState(() {
        _result = "Invalid input";
      });
    }
  }

  // Convert number to words in the Indian currency format
  String convertNumberToWords(double amount) {
    int rupees = amount.floor();
    int paise = ((amount - rupees) * 1000).round();

    if (paise == 1000) {
      rupees += 1;
      paise = 0;
    }

    String rupeesInWords = _convertToWords(rupees);
    String paiseInWords = paise > 0 ? _convertToWords(paise) : "";

    if (paiseInWords.isNotEmpty) {
      return "$rupeesInWords Rupees and $paiseInWords Paise";
    } else {
      return "$rupeesInWords Rupees";
    }
  }

  String _convertToWords(int number) {
    if (number == 0) return "zero";

    final List<String> units = [
      "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"
    ];
    final List<String> teens = [
      "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen",
      "Sixteen", "Seventeen", "Eighteen", "Nineteen"
    ];
    final List<String> tens = [
      "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
    ];
    final List<String> thousands = ["", "Thousand", "Lakh", "Crore"];

    String numberToWords(int num) {
      if (num < 10) return units[num];
      if (num < 20) return teens[num - 10];
      if (num < 100) {
        return tens[num ~/ 10] + (num % 10 != 0 ? " " + units[num % 10] : "");
      }
      if (num < 1000) {
        return units[num ~/ 100] + " Hundred" + (num % 100 != 0 ? " and " + numberToWords(num % 100) : "");
      }
      return "";
    }

    int place = 0;
    String words = "";
    while (number > 0) {
      if (number % 1000 != 0) {
        words = numberToWords(number % 1000) + " " + thousands[place] + " " + words;
      }
      number = number ~/ 1000;
      place++;
    }

    return words.trim();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the layout responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust font size based on screen width
    double fontSize = screenWidth < 600 ? 16.0 : 18.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Number to Indian Currency Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // 5% padding for horizontal margins
          vertical: screenHeight * 0.02, // 2% padding for vertical margins
        ),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter amount in numbers',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Convert to Words', style: TextStyle(fontSize: fontSize)),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              _result,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),
            Divider(),
            Text(
              'Conversion History',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _history.isEmpty
                  ? Center(child: Text('No conversion history available.'))
                  : ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Padding inside the tile
                          tileColor: Colors.grey[100], // Background color of the tile
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Rounded corners
                            side: const BorderSide(color: Colors.blueAccent, width: 1), // Border around the tile
                          ),
                          title: Text(
                            _history[index],
                            style: TextStyle(
                              fontSize: fontSize, // Responsive text size
                              fontWeight: FontWeight.w500, // Text weight
                              color: Colors.black, // Text color
                            ),
                          ),
                          subtitle: Text(
                            'Converted on: ${DateTime.now().toLocal()}',
                            style: TextStyle(fontSize: fontSize - 4.0, color: Colors.grey),
                          ),
                          trailing: Icon(
                            Icons.history,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {
                            print('Tapped on history: ${_history[index]}');
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
