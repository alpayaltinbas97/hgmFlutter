import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/*
Json verileri ile aldýðýmýz bilgileri görselleþtiriyoruz.
bu bilgileri ise sixth_screen.dart içerisinde kullanýyoruz.
 */

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://www.harita.gov.tr/api2/get_management_data.php'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String gorev;
  final String rutbe;
  final String ad;

  const Photo({
    required this.gorev,
    required this.rutbe,
    required this.ad,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      gorev: json['gorev'] as String,
      rutbe: json['rutbe'] as String,
      ad: json['ad'] as String,
    );
  }
}

class ManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
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
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500, crossAxisSpacing: 1, mainAxisExtent: 100,
      ),
      itemCount: value.length,
      itemBuilder: (context, index) {
        return InkWell(
          splashColor: Colors.white,
          child : Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[350],
            shadowColor: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(value[index].gorev,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(value[index].rutbe,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(value[index].ad,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
                      textAlign: TextAlign.center,
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