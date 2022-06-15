import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

/*
third_screen.dart içerisinde yazdıklarımın aynısı bu class için de geçerli.
orada uyguladıklarımızın aynısını burada da uyguluyoruz.
ikiz classlar da denebilir.
 */

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://www.harita.gov.tr/api2/get_special_data.php'));

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
      home: FourthScreen(title: appTitle),
    );
  }
}

class FourthScreen extends StatelessWidget {
  const FourthScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Özel Sayılar',style: TextStyle(fontSize: 18,),),
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
      padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                builder: (context) => PDFViewerCachedFromUrl(
              url:'https://www.harita.gov.tr/uploads/files/mapmagazinespecialissues/' + value[index].name + "-" + value[index].id + ".pdf",
            ),
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
                  width: 280,
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

class PDFViewerCachedFromUrl extends StatelessWidget {
  PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makaleler'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                      child: Text(snapshot.data!),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        autoSpacing: true,
        pageFling: true,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('% $progress',style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 30))),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: const Text('Sayfa'),
                  backgroundColor: Colors.redAccent,
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true), // passing true
                              child: Icon(FontAwesomeIcons.angleRight),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.redAccent, // Background Color
                              ),
                            ),
                          ],
                          title: Text('Sayfa Numarası Giriniz'),
                          content: TextField(
                            controller: myController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              hintText: '...',
                              suffixIcon: IconButton(
                                onPressed:
                                myController.clear,
                                icon: Icon(Icons.clear),
                                color: Colors.redAccent,
                                splashColor: Colors.redAccent,
                              ),
                            ),
                            onChanged: (value) async{
                              final PDFViewController pdfController = snapshot.data!;
                              var one = int.parse(myController.text);
                              final int currentPage = one;
                              final int? pageCount = await pdfController.getPageCount();
                              var pageCounter = int.parse(pageCount.toString());
                              if (currentPage >= 0 && currentPage<pageCounter) {
                                pdfController.setPage(currentPage-1);
                              }
                              else {
                                await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.redAccent,
                                  content: Text("Lütfen Geçerli Bir Değer Giriniz"),
                                ));
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}