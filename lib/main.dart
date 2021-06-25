import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';

  var answer = '';

  final List<String> buttons = ['C', 'del', '%', '/',
  '7', '8', '9', 'x',
  '4', '5', '6', '-',
  '1', '2', '3', '+',
  'expand', '0', '.', '='];

  final List<String> allButtons = ['2nd', 'deg', 'sin', 'cos', 'tan',
  'pow', 'lg', 'ln', '(', ')',
  'sqrt', 'C', 'del', '%', '/',
  'X!', '7', '8', '9', 'x',
  '1/x', '4', '5', '6', '-',
  'pi', '1', '2', '3', '+',
  'expand', 'e', '0', '.', '='];

  bool power = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator App",
        style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(
                          fontSize: 18, color: Colors.black
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
          Divider(
            height: 1,
            color: Colors.blueGrey.shade400,
          ),
          Expanded(
            flex: 2,
            child: Container(

              child: GridView.builder(
                itemCount: Constants.isAllButtons ? allButtons.length : buttons.length ,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Constants.isAllButtons ? 5 : 4),

                itemBuilder: (BuildContext context, int index){
                  if((Constants.isAllButtons && index == 30) ||(!Constants.isAllButtons && index == 16)){
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          Constants.isAllButtons = (Constants.isAllButtons == false);
                        });
                      },
                      buttonText: Constants.isAllButtons ? allButtons[index] : buttons[index],
                      textColor: Colors.blue,
                    );
                  }
                  else if(Constants.isAllButtons && (index == 0 || index == 1 || index == 2 || index == 3 || index == 4 || index == 6 || index == 7 || index == 10 || index == 15 || index == 20 || index == 25 || index == 31) ){
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          if(index == 2){
                            userInput += 'sin';
                            calculateSin();
                          }
                          else if(index == 3){
                            userInput += 'cos';
                            calculateCos();
                          }
                          else if(index == 4){
                            userInput += 'tan';
                            calculateTan();
                          }
                          else if(index == 6){
                            userInput += 'log';
                            calculateLg();
                          }
                          else if(index == 7){
                            userInput += 'ln';
                            calculateLn();
                          }
                          else if(index == 10){
                            userInput += 'sqrt';
                            calculateSqrt();
                          }
                          else if(index == 15){
                            calculateFact();
                          }
                          else if(index == 20){
                            userInput += '^(-1)';
                            calculateInv();
                          }
                          else if(index == 25){
                            if(userInput == ''){
                              userInput = '3.14';
                            }
                            else{
                              userInput += '*';
                              userInput += '3.14';
                            }
                          }
                          else if(index == 31){
                            if(userInput == ''){
                              userInput = '2.718';
                            }
                            else{
                              userInput += '*';
                              userInput += '2.718';
                            }
                          }
                        });
                      },
                      buttonText: allButtons[index],
                      textColor: Colors.blue,
                    );
                  }
                  else if(Constants.isAllButtons && index == 5 ){
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userInput += '^';
                          power = true;
                        });
                      },
                      buttonText: allButtons[index],
                      textColor: Colors.blue,
                    );
                  }
                  if((Constants.isAllButtons && index == 11) || (!Constants.isAllButtons && index ==  0)){
                    return MyButton(
                      //color: Colors.blue,
                        textColor: Colors.blue,
                        buttonText: Constants.isAllButtons ? allButtons[index] : buttons[index],
                        buttonTapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        }
                    );
                  }
                  else if((Constants.isAllButtons && index == 12) || (!Constants.isAllButtons && index == 1)){
                    return  MyButton(
                      buttonTapped: () {
                        setState(() {
                          userInput = userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: Constants.isAllButtons ? allButtons[index] : buttons[index],
                      //color: Colors.blue,
                      textColor: Colors.blue,

                    );
                  }
                  else if ((Constants.isAllButtons && index == 34) || (!Constants.isAllButtons && index == 19)) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: Constants.isAllButtons ? allButtons[index] : buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.blue,
                    );
                  }
                  //  other buttons
                  else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userInput += Constants.isAllButtons ? allButtons[index] : buttons[index];
                          print(userInput);
                        });
                      },
                      buttonText: Constants.isAllButtons ? allButtons[index] : buttons[index],
                      textColor: isOperator(Constants.isAllButtons ? allButtons[index] : buttons[index])
                          ? Colors.blue
                          : Colors.black,
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '%' ) {
      return true;
    }
    return false;
  }


// function to calculate the input operation
  void parseUserInput(){

  }

  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    print(exp.toString());
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    setState(() {});
  }

  void calculateSin(){

  }

  void calculateCos(){

  }

  void calculateTan(){

  }

  void calculatePower(){

  }

  void calculateLg(){

  }

  void calculateLn(){

  }

  void calculateSqrt(){

  }

  void calculateFact(){
    int num = int.parse(userInput);
    var factorial = 1;

    for( var i = num ; i >= 1; i-- ) {
      factorial *= i ;
    }
    print(factorial);
    answer = factorial.toString();
    setState(() {});
  }

  void calculateInv(){

  }
}

class Constants {
  static bool isAllButtons = false;
}
