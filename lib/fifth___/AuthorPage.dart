import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

final String url = "https://www.harita.gov.tr/api2/get_article_data.php";

List<Photo> parseUser(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((e) => Photo.fromJson(e)).toList();
  return users;
}

Future<List<Photo>> fetchUsers() async{
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return compute(parseUser,response.body);
  } else {
    throw Exception(response.statusCode);
  }
}

class Photo {
  final String value1;
  final String year;
  final String issue;
  final String value2;
  final String name;
  final String id;

  const Photo({
    required this.value1,
    required this.year,
    required this.issue,
    required this.value2,
    required this.name,
    required this.id,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      value1: json['value1'] as String,
      year: json['year'] as String,
      issue: json['issue'] as String,
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

    return MaterialApp(
      home: AuthorPage(),
    );
  }
}

class AuthorPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AuthorPage> {
  List<Photo> _users = <Photo>[];
  List<Photo> _usersDisplay = <Photo>[];
  var _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers().then((value) {
      setState(() {
        _isLoading = false;
        _users.addAll(value);
        _usersDisplay = _users;
        //print(_usersDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
    gestures: [
      GestureType.onTap,
      GestureType.onPanUpdateDownDirection,
    ],
    child: Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0 ? _searchBar() : UserTile(user: this._usersDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _usersDisplay.length + 1,
          ),
        ),
      ),
    ),
  );


  _searchBar()  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 90,
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,bottom:20.0,top:20.0, right:0.0),
            child : TextField(
              smartQuotesType: SmartQuotesType.disabled, controller: _controller,
              keyboardType: TextInputType.visiblePassword,
              autofocus: false,
              onChanged: (searchText) {
                searchText = searchText.toLowerCase();
                setState(() {
                  _usersDisplay = _users.where((u) {
                    var fName = u.value2.toLowerCase();
                    return fName.contains(searchText);
                  }).toList();
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black, width: 0.0),),
                hintText: 'Ara',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: Padding(
              padding: const EdgeInsets.only(left:5.0,bottom:10.0,top:10.0, right:0.0),
              child : ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.grey, // Background Color
                ),
                child: Icon(Icons.search),
              )
          ),
        ),
        SizedBox(
          width: 70,
          child: Padding(
              padding: const EdgeInsets.only(left:5.0,bottom:10.0,top:10.0, right:10.0),
              child : ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _controller.clear();
                  fetchUsers().then((value) {
                    setState(() {
                      _isLoading = false;
                      _users.addAll(value);
                      _usersDisplay = _users;
                      //print(_usersDisplay.length);
                    });
                  });
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.redAccent, // Background Color
                ),
                child: Icon(Icons.clear),
              )
          ),
        ),
      ],
    );
  }
}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
        ),
        Container(
          child: CircularProgressIndicator(color: Colors.redAccent,),
        ),
      ],
    );
  }
}

class UserTile extends StatelessWidget {
  final Photo user;

  UserTile({required this.user});

  String userTitle() {
    String title = "";
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.white,
            onTap: () {
              print(user.name + "-" + user.id + ".pdf");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewerCachedFromUrl(
                    url: 'https://www.harita.gov.tr/uploads/files/articles/'+ user.name + "-" + user.id + ".pdf",
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(top:30,bottom:20),
                      child: Text(user.value1+'\n\n',style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(top:30,bottom:20),
                      child: Text(user.value2,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top:30,bottom:30),
                      child: Text(user.issue,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top:30,bottom:30),
                      child: Text(user.year,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child : Container(
                      margin: EdgeInsets.only(top:30,bottom:30),
                      child : Image.asset(
                        'assets/pdf.png',
                        width: 35,
                        height: 35,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
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
                              final int currentPage = one-1;
                              final int? pageCount = await pdfController.getPageCount();
                              var pageCounter = int.parse(pageCount.toString());
                              if (currentPage >= 0 && currentPage<pageCounter) {
                                pdfController.setPage(currentPage);
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
