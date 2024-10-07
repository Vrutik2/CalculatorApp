import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculatorView(),
    );
  }
}

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String expression = ''; // Store the input expression
  String result = ''; // Store the calculation result

  // Function to update the expression when a button is pressed
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Reset expression and result
        expression = '';
        result = '';
      } else if (buttonText == "=") {
        // Evaluate the expression and handle edge cases
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();

          if (expression.contains("/0")) {
            result = "Error: Divide by 0"; // Handle division by zero
          } else {
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          }
        } catch (e) {
          result = 'Error'; // Handle any other calculation errors
        }
      } else {
        expression += buttonText;
      }
    });
  }

  Widget calcButton(String buttonText, Color buttonColor) {
    return ElevatedButton(
      onPressed: () => buttonPressed(buttonText),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: buttonColor,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
            fontSize: 24, color: Colors.black), // Contrast for readability
      ),
    );
  }
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.orange, // AppBar background color
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              expression,
              style: const TextStyle(fontSize: 32, color: Colors.white), // White for visibility
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(fontSize: 48, color: Colors.white), // White for visibility
            ),
          ),
          const Divider(color: Colors.white), // White divider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcButton("7", Colors.white),
              calcButton("8", Colors.white),
              calcButton("9", Colors.white),
              calcButton("/", Colors.orange), // Operators differentiated by color
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcButton("4", Colors.white),
              calcButton("5", Colors.white),
              calcButton("6", Colors.white),
              calcButton("*", Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcButton("1", Colors.white),
              calcButton("2", Colors.white),
              calcButton("3", Colors.white),
              calcButton("-", Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              calcButton("0", Colors.white),
              calcButton("C", Colors.orange), // Clear button with red accent
              calcButton("=", Colors.orange), // Equals button with green color
              calcButton("+", Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}


