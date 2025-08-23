import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 80, 45, 5)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  String addans="";
  String subans="";
  String mulans="";
  String divans="";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Mini Calculator"), backgroundColor: const Color.fromARGB(255, 6, 89, 121),),
        body: Column(
          children: [
            Text("Enter 2 Numbers"),
            TextField(controller: num1),
            TextField(controller: num2),
            ElevatedButton(onPressed: () {
              add();
            }, child: Text("+")),
            Text("$addans"),
            ElevatedButton(onPressed: (){
              sub();
            }, child: Text("-")),
            Text("$subans"),
            ElevatedButton(onPressed: (){
              mul();
            }, child: Text("*")),
            Text("$mulans"),
            ElevatedButton(onPressed: (){
              div();
            }, child: Text("/")),
            Text("$divans"),
          ],
        ),
      )
    );
  }

void add(){
  setState(() {
    var a = int.parse(num1.text);
    var b =  int.parse(num2.text);
    var c = a+b;
    addans="$c";
  });
}

void sub(){
  setState(() {
    var a = int.parse(num1.text);
    var b =  int.parse(num2.text);
    var c = a-b;
    subans="$c";
  });
}

void mul(){
  setState(() {
    var a = int.parse(num1.text);
    var b =  int.parse(num2.text);
    var c = a*b;
    mulans="$c";
  });
}

void div(){
  setState(() {
    var a = int.parse(num1.text);
    var b =  int.parse(num2.text);
    if(b!=0){
      setState(() {
        var c = b/a;
        divans="$c";
      });
    }else{
      divans="Division by zero not possible";
    }

  });
}
}