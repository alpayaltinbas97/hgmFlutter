import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MaterialApp(
    title: 'Makale Yazım Esasları',
    home: EighthScreen(),
  ));
}

/// Represents Homepage for Navigation
class EighthScreen extends StatefulWidget {
  const EighthScreen({Key? key}) : super(key: key);

  @override
  _EighthScreen createState() => _EighthScreen();
}

class _EighthScreen extends State<EighthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makale Yazım Esasları',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
      ),
      body: SfPdfViewer.network(
        'https://www.harita.gov.tr/uploads/files-folder/makale_yazim_esaslari.pdf',
      ),
    );
  }
}