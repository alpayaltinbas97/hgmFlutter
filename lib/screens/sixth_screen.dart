import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harita_dergisi/screens/seventh_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harita_dergisi/sixth___/Management.dart';

/*
bu sayfada dergi yönetim kurulunun bilgileri mevcut.
body kısmı Sixth___/Management.dart içerisinde oluşturulmakta.
Appbar kısmında datatable benzeri bir yapı oluşturulmuştur ve bu sayede düzenli bir şekilde verilerin görüntülenmesi sağlanmıştır.
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
      home: const SixthScreen(),
    );
  }
}

class SixthScreen extends StatelessWidget {
  const SixthScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)  {
      return Scaffold(
      appBar: AppBar(
        title: const Text('Dergi Yönetim Kurulu',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: true,
        // Use TabBar to show the three tabs
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(74.0),
        child: Container(
          color: Colors.grey[350],
          child:Row(
          children:[
            Expanded(
              flex: 4,
              child: Container(
                child: Tab(
                  icon: Icon(FontAwesomeIcons.clipboardCheck, color: Colors.black),
                  text: 'Görevi',
                ),
                ),
              ),
            Expanded(
              flex: 3,
              child: Container(
                child: Tab(
                  icon: Icon(FontAwesomeIcons.personMilitaryPointing, color: Colors.black),
                  text: 'Rütbesi',
                ),
              ),
            ),
            Expanded(
            flex: 4,
            child: Container(
              child: Tab(
                icon: Icon(FontAwesomeIcons.idCard, color: Colors.black),
                text: 'Adı',
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
          ManagementScreen(),
      ),
    );
  }
}