import 'package:flutter/material.dart';

import 'screens/eighth_screen.dart';
import 'screens/fifth_screen.dart';
import 'screens/first_screen.dart';
import 'screens/fourth_screen.dart';
import 'screens/ninth_screen.dart';
import 'screens/second_screen.dart';
import 'screens/seventh_screen.dart';
import 'screens/sixth_screen.dart';
import 'screens/third_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ListView Navigation I',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        itemExtent: 100,
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/yayinilkeleri.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Yayın İlkeleri'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirstScreen(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/sonsayi.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Son Sayı'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/dergiarsivi.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Dergi Arşivi'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdScreen(title: 'Dergi Arşivi'),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/ozelsayilar.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Özel Sayılar'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FourthScreen(title: 'Özel Sayılar'),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/makalesorgulama.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Makale Sorgulama'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FifthScreen(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/dergiyonetimkurulu.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Dergi Yönetim Kurulu'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SixthScreen(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/dergibilimkurulu.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Dergi Bilim Kurulu'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeventhScreen(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/makaleyazimesaslari.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Makale Yazım Esasları'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EighthScreen(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left:20.0,bottom:20.0,top:20.0, right:20.0),
            leading: Image.asset(
              'assets/makaleyazimsablonu.png',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
            title: Text('Makale Yazım Şablonu'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NinthScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}