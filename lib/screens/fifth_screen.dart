import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harita_dergisi/fifth___/ArticlePage.dart';
import 'package:harita_dergisi/fifth___/AuthorPage.dart';
import 'package:harita_dergisi/fifth___/IssuePage.dart';
import 'package:harita_dergisi/fifth___/YearPage.dart';

/*
makale sorgulama çerçevesini oluşturduğumuz sayfa.
main.dart içerisindeki yapıya benzer bir yapı var ancak bu sefer navigation bar yerine tabbar mevcut.
tabbar ile üst kısımdan ihtiyacımız olan arama yöntemini seçiyoruz ve arama yöntemine göre hizmet eden sayfa ekranın orta kısmında görüntüleniyor.
bu sayfada kullanılan alt sayfalar fifth___ alt klasörü içerisindeler.
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
      home: const FifthScreen(),
    );
  }
}

class FifthScreen extends StatefulWidget {
  const FifthScreen({Key? key}) : super(key: key);

  @override
  _JobApplicationFlowState createState() => _JobApplicationFlowState();
}

class _JobApplicationFlowState extends State<FifthScreen>
    with SingleTickerProviderStateMixin {
  // We need a TabController to control the selected tab programmatically
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() {
        FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makale Sorgulama',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
        // Use TabBar to show the three tabs
        bottom: TabBar(
          indicatorColor: Colors.black12,
          indicator: BoxDecoration(color: Colors.black26),
          labelStyle: TextStyle(fontSize: 11.5),
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.style, color: Colors.white),
                text: 'Makale Adına \n \t  Göre Ara',
              ),
              Tab(
                icon: Icon(Icons.create_outlined, color: Colors.white,),
                text: 'Yazara Göre \n \t \t \t Ara',
              ),
              Tab(
                icon: Icon(Icons.format_list_numbered, color: Colors.white),
                text: 'Sayıya Göre \n \t \t \t Ara',
              ),
              Tab(
                icon: Icon(Icons.date_range, color: Colors.white),
                text: 'Yıla Göre \n \t \t  Ara',
              ),
            ],
          ),
        ),
      body: TabBarView(
        // make sure we can't switch tabs with interactive drag gestures
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          ArticlePage(),
          AuthorPage(),
          IssuePage(),
          YearPage(),
                  ],
                ),
            );
  }
  }