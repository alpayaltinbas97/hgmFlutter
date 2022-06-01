import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/*
import kısmında görebileceğimiz pdfviewer kütüphanesi ile bir widget oluşturarak,
dergi son sayısını pdf linki ile pdf görüntülüyoruz.
 */

void main() {
  runApp(MaterialApp(
    title: 'Son Sayı',
    home: SecondScreen(),
  ));
}
final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

/// Represents Homepage for Navigation
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Son Sayı',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
      ),
      body: SfPdfViewer.network(
        'https://www.harita.gov.tr/uploads/files/mapmagazines/sonsayi.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}