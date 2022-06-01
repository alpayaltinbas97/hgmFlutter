import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Seventh__/Science.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SeventhScreen(),
    );
  }
}

class SeventhScreen extends StatelessWidget {
  const SeventhScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dergi Bilim Kurulu',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: true,
        // Use TabBar to show the three tabs
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(74.0),
          child: Container(
            color: Colors.grey[350],
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(
                  width: 90,
                  child: Container(
                    child: Tab(
                      icon: Icon(FontAwesomeIcons.briefcase, color: Colors.black),
                      text: 'Ünvanı',
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Container(
                    padding: EdgeInsets.only(right: 8),
                    child: Tab(
                      icon: Icon(FontAwesomeIcons.idCard, color: Colors.black),
                      text: 'Adı',
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Tab(
                      icon: Icon(FontAwesomeIcons.institution, color: Colors.black),
                      text: 'Kurumu',
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Container(
                    padding: EdgeInsets.only(right: 6),
                    child: Tab(
                      icon: Icon(FontAwesomeIcons.codeBranch, color: Colors.black),
                      text: 'Branşı',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child:
        ScienceScreen(),
      ),
    );
  }
}