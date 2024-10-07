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
}
