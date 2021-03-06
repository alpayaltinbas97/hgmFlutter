import 'package:flutter/material.dart';

/*
iletişim bilgileri sayfasında basitçe text ve image bulunmaktadır.
widgetlar isimlendirilerek textler özelleştirilmiştir.
body kısmında listview ile beraber bu widgetlar sıralarına göre görüntülenmektedir.
 */

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const CallPage());
}

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection1 = Container(
      padding: const EdgeInsets.all(5),
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
                  child: const Text(
                    '\n\nİletişim Bilgileri : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    Widget textSection1 = const Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        'Harita Genel Müdürlüğü \n'
            'Harita Dergisi Yönetim Kurulu Başkanlığı',
        style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 14,
        ),
        softWrap: true,
      ),
    );
    Widget textSection2 = const Padding(
      padding: EdgeInsets.all(5),
      child: SelectableText(
        'Tel: +90 (312) 595 21 21 - 21 20 \n'
            'Fax: +90 (312) 320 14 95 \n'
        'haritadergisi@harita.gov.tr \n',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
    Widget textSection3 = const Padding(
      padding: EdgeInsets.all(5),
      child: Text(
            'Harita Satış Bürosu',
        style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 14,
        ),
        softWrap: true,
      ),
    );
    Widget textSection4 = const Padding(
      padding: EdgeInsets.all(5),
      child: SelectableText(
        'Tel: +90 (312) 595 20 72 - 23 28 \n',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
    Widget textSection5 = const Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        'Haritacılık Müzesi',
        style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 14,
        ),
        softWrap: true,
      ),
    );
    Widget textSection6 = const Padding(
      padding: EdgeInsets.all(5),
      child: SelectableText(
            'Tel: +90 (312) 595 23 28\n',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Image.asset(
              'assets/background.png',
              width: 75,
              height: 75,
              fit: BoxFit.scaleDown,
            ),
            titleSection1,
            textSection1,
            textSection2,
            textSection3,
            textSection4,
            textSection5,
            textSection6,
          ],
        ),
      ),
    );
  }
}