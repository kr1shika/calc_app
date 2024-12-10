import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  final _historyController = TextEditingController(); 

  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  String input = "";
  String history = ""; 
  double? firstOperand;
  double? secondOperand;
  String? operation;

// logic for calculation and saving history
void _onButtonPressed(String symbol) {
  setState(() {
    if (symbol == "C") {
      input = "";
      history = "";
      firstOperand = null;
      secondOperand = null;
      operation = null;
    } else if (symbol == "<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (symbol == "=") {
      if (firstOperand != null && operation != null && input.isNotEmpty) {
        secondOperand = double.tryParse(input);
        if (secondOperand != null) {
          switch (operation) {
            case "+":
              input = (firstOperand! + secondOperand!).toString();
              break;
            case "-":
              input = (firstOperand! - secondOperand!).toString();
              break;
            case "*":
              input = (firstOperand! * secondOperand!).toString();
              break;
            case "/":
              input = secondOperand != 0
                  ? (firstOperand! / secondOperand!).toString()
                  : "Error";
              break;
            case "%":
              input = (firstOperand! % secondOperand!).toString();
              break;
            default:
              break;
          }
          history = "$firstOperand $operation $secondOperand ="; 
        }
        firstOperand = null;
        operation = null;
      }
    } else if (["+", "-", "*", "/", "%"].contains(symbol)) {
      if (input.isNotEmpty) {
        firstOperand = double.tryParse(input);
        operation = symbol;
        history = "$input $symbol"; 
        input = "";
      }
    } else {
      input += symbol;
    }

    _textController.text = input;
    _historyController.text = history;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 232, 224),
      appBar: AppBar( backgroundColor:const Color.fromARGB(255, 232, 232, 224),
        title: const Text('Krishika Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              // Display for current input
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true,
              ),
              const SizedBox(height: 8),
              // Display for operation history
              Container( 
                  height: 12
                  , 
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _historyController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      
                    ),
                    style: const TextStyle(
                      fontSize: 16,               
                      fontWeight: FontWeight.w600, 
                      color: Color.fromARGB(255, 61, 57, 57),          
                    ),
                    readOnly: true,
                  ),
                ),

              const SizedBox(height: 10),
              // Buttons for calculator
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 113, 97, 130),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(0),
                        // ),
                      ),
                      onPressed: () => _onButtonPressed(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
