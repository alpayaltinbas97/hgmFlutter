import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/*
öncelikle dergi arşivinin verilerini json formatında sunucudan alıyoruz.
ThirdScreen class ı içerisinde bulunan widget PhotosList adında bir class aracılığı ile veri bulduğu takdirde görüntüleme yapmaktadır.
PhotosList class ında ise json olarak aldığımız ve arraylist olarak kullandığımız verileri sayısına göre ekrana görüntülüyoruz.
görüntüleme işlemini card yapısıyla sağlıyoruz, bu card içerisinde text ve image dosyası bulunmakta.
onTap methoduyla da bu itemlara tıklandığı takdirde gerekli pdf e yönlendirmeyi yapıyoruz.
bu pdf yönlendirmesi yine pdfviewer kütüphanesi sayesinde oluyor.
builder: (context) => pdfOpener(a:value[index].name + "-" + value[index].id + ".pdf",) kodunda görüldüğü üzere pdf linkini o item özelinde oluşturuyoruz.
oluşturduğumuz bu pdf linki her item için kendine özel olmuş oluyor, bu sayede hangi item a tıklarsak o itemin üzerinde yazan bilgilere sahip pdf dosyası açılıyor.
 */

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://www.harita.gov.tr/api2/get_archive_data.php'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String value1;
  final String value2;
  final String name;
  final String id;

  const Photo({
    required this.value1,
    required this.value2,
    required this.name,
    required this.id,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      value1: json['value1'] as String,
      value2: json['value2'] as String,
      name: json['name'] as String,
      id: json['id'] as String,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: ThirdScreen(title: appTitle),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Dergi Arşivi',style: TextStyle(fontSize: 18,),),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(value: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.redAccent,),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.value}) : super(key: key);
  final List<Photo> value;


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: value.length,
      itemBuilder: (context, index) {
        return InkWell(
          splashColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pdfOpener(a:value[index].name + "-" + value[index].id + ".pdf",),
              ),
            );
          },
        child : Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.grey[350],
          shadowColor: Colors.black,
          child: Column(
            children: [
              Image.asset(
                'assets/background.png',
                width: 220,
                height: 140,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(value[index].value1+'\n\n',style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  child: Text(value[index].value2,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child : Container(
                  margin: EdgeInsets.only(left:2,top:30,bottom:30),
                  child : Image.asset(
                    'assets/pdf.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
        ),
        );
      },
    );
  }
}


class pdfOpener extends StatefulWidget {
  String a;
  pdfOpener({Key? key,required this.a}) : super(key: key);

  @override
  _PdfOpener createState() => _PdfOpener();
}

class _PdfOpener extends State<pdfOpener> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dergi Arşivi"),
        backgroundColor: Colors.grey,
      ),
      body: SfPdfViewer.network(
        'https://www.harita.gov.tr/uploads/files/mapmagazines/' + widget.a,
      ),
    );
  }
}