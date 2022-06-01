import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MaterialApp(
    title: 'Makale Yazım Şablonu',
    home: NinthScreen(),
  ));
}

/// Represents Homepage for Navigation
class NinthScreen extends StatefulWidget {
  const NinthScreen({Key? key}) : super(key: key);

  @override
  _NinthScreen createState() => _NinthScreen();
}

class _NinthScreen extends State<NinthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makale Yazım Şablonu',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
      ),
      body: SfPdfViewer.network(
        'https://www.harita.gov.tr/uploads/files-folder/makale_yazim_sablonu.pdf',
      ),
    );
  }
}