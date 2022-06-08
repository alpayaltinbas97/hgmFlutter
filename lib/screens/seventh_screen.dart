import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harita_dergisi/seventh___/Science.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
sixth_screen.dart ile aynı mantık.
Seventh__/Science.dart içerisinden gelen bilgiler ile çalışmaktadır.
 */

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
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Tab(
                      icon: Icon(FontAwesomeIcons.briefcase, color: Colors.black),
                      text: 'Ünvanı',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(left: 2),
                    child: Tab(
                      icon: Icon(FontAwesomeIcons.idCard, color: Colors.black),
                      text: 'Adı',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(right: 2),
                    child: Tab(
                      icon: Icon(FontAwesomeIcons.institution, color: Colors.black),
                      text: 'Kurumu',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
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