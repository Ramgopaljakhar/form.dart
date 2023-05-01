import 'package:flutter/material.dart';
import 'package:flutterdemo/second.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title:'Navigation Basics',

    home:const FirstScreen(),
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
  ));
}
class FirstScreen extends StatefulWidget {

  const FirstScreen({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.orange,
        title: const Text('First Screen'),
     ),
        body:Center(
          child:ElevatedButton(
              child:const Text('Next Screen'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const SecondScreen()
              ));
            },
          ),
        ),
    ),// appBar
    );
  }
}


