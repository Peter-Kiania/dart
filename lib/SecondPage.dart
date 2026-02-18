import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget{
  @override
  State<SecondPage> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(title: Text('Profile Page'),)  ,body: Center() );
  }
}
