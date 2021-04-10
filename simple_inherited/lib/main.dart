import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Widget',
      home: MainClass(
        child: MultiplicationClass(
          child: DisplayMultiplication()),
      )
    );
  }
}

class MainClass extends StatefulWidget {
  final Widget child;

  const MainClass({Key key, @required this.child}) : super(key: key);

  static MainClassState of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<TheInheritedClass>().data;
  }

  @override
  MainClassState createState() => MainClassState();
}

class MainClassState extends State<MainClass> {

    Random random = Random();
    List<Color> colorSets = [Colors.green, Colors.indigo, Colors.red, Colors.purple,Colors.yellow];
    int randomNumber;
    int _randomColorNumber = 0;
    int _finalNumber = 0;
    double textFontSize = 40;
    int get finalValue => _finalNumber; 
    Color get finalColorChoice => colorSets[_randomColorNumber];
    double get finalTextSize => textFontSize;

    void multiplyRandombyTwo(){
      
      setState(() {
         randomNumber  = random.nextInt(200); 
         _randomColorNumber = random.nextInt(4);
         _finalNumber = randomNumber * 2;
          textFontSize += 2;
            });
    }
  @override
  Widget build(BuildContext context) {
    
    return TheInheritedClass(
      child: widget.child, 
      data: this
      );
  }
}

class TheInheritedClass extends InheritedWidget {
  final MainClassState data;

  TheInheritedClass({Key key, @required Widget child, @required this.data}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class MultiplicationClass extends StatelessWidget {
  final Widget child;
  MultiplicationClass({Key key, @required this.child}) : super(key: key);

  void onPressed(BuildContext context) {
      MainClass.of(context).multiplyRandombyTwo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alert),
        onPressed: (){
          onPressed(context);
        },
      ),
    );
  }
}

class DisplayMultiplication extends StatefulWidget {


  @override
  DisplayMultiplicationState createState() => DisplayMultiplicationState();
}

class DisplayMultiplicationState extends State<DisplayMultiplication> {
     int theFinalValue; 
     double theFinalFont;
     Color zFontColor;
     


    @override
      void didChangeDependencies() {
        super.didChangeDependencies();

         theFinalValue = MainClass.of(context).finalValue;
         theFinalFont = MainClass.of(context).finalTextSize;  
         zFontColor = MainClass.of(context).finalColorChoice;
       }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Padding(
             padding: EdgeInsets.symmetric(vertical:15.0),
             child: Text(
               'This is Final:',
               style: TextStyle(
                 color: zFontColor,
                 fontSize: theFinalFont
               ),
             ), 
           ),
           Text(
             '$theFinalValue',
             style: TextStyle(
               fontSize: theFinalFont
             ),
             )
        ],
      ),
    );
  }
}