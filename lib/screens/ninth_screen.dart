import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
second_screen.dart ile ikiz sayfalar.
 */

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
    body:
    PDFViewerCachedFromUrl(
      url: 'https://www.harita.gov.tr/uploads/files-folder/makale_yazim_sablonu.pdf',
    ),
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
        title: const Text('Makale Yazım Şablonu'),
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