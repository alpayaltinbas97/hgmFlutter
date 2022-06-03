import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://www.harita.gov.tr/api2/get_science_data.php'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String unvan;
  final String ad;
  final String kurum;
  final String bransi;

  const Photo({
    required this.unvan,
    required this.ad,
    required this.kurum,
    required this.bransi,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      unvan: json['unvan'] as String,
      ad: json['ad'] as String,
      kurum: json['kurum'] as String,
      bransi: json['bransi'] as String,
    );
  }
}

class ScienceScreen extends StatelessWidget {
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
            color: Colors.grey[350],
            shadowColor: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(value[index].unvan,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(value[index].ad,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(value[index].kurum,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(value[index].bransi,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
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