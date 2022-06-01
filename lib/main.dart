import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'CallPage.dart';
import 'HomePage.dart';
import 'MapPage.dart';
import 'package:device_preview/device_preview.dart';

/* main üç bölümden oluşuyor, iletişim, anasayfa ve konum.
bottom navigation bar içerisindeki 3 button arasından seçtiğimiz button bir index değerine sahip,
index değeri neyse o class görüntüleniyor.
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );

  }
  const MyApp({Key? key}) : super(key: key);
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    CallPage(),
    HomePage(),
    MapPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harita Dergisi',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'İletişim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Konum',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
