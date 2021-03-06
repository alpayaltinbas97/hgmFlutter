import 'package:flutter/material.dart';

/*
konum kısmında kurumun lokasyonunu gösteren bir image dosyası ve text bulunmaktadır.
body kısmında image ve text bulunduran widget sırayla çağrılmış ve görüntüleme oluşturulmuştur.
 */

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MapPage());
}

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SelectableText(
                    'Harita Genel Müdürlüğü',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SelectableText(
                  'Tıp Fakültesi Caddesi 06590 Cebeci/ANKARA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );

/*
görüntüleme yapan kısım.
 */
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Image.asset(
              'assets/map.jpg',
              width: 600,
              height: 500,
              fit: BoxFit.fitHeight,
            ),
            titleSection,
          ],
        ),
      ),
    );
  }

}