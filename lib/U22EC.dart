import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Content extends StatelessWidget {
  var content;

  Content(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content['itemName']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                content['mediumImageUrls'][0]['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            Text(
              content['itemName'],
              style:
                  const TextStyle(fontSize: 32, height: 1.5, letterSpacing: 1),
            ),
            ElevatedButton(
              onPressed: () async {
                await launchUrl(Uri.parse(content['itemUrl']),
                    mode: LaunchMode.externalApplication);
              },
              child: const Text('今すぐ購入'),
            ),
            const Divider(),
            Text(
              content['itemCaption'],
              style:
                  const TextStyle(fontSize: 14, height: 1.5, letterSpacing: 1),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('戻る'),
            ),
          ],
        ),
      ),
    );
  }
}

class U22EC extends StatefulWidget {
  const U22EC({super.key, required this.title});
  final String title;
  @override
  State<U22EC> createState() => _U22ECState();
}

class _U22ECState extends State<U22EC> {
  Map items = {};
  var data;
  int page = 1;

  Future<List> getData(int page) async {
    final url = Uri.parse(
        'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20220601?format=json&keyword=%E9%98%B2%E7%81%BD&genreId=215783&page=$page&applicationId=1053454460206373302');
    final http.Response response = await http.get(url);
    data = jsonDecode(response.body);
    return data['Items'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: getData(page),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                var error = snapshot.error;
                return Text(error.toString());
              } else if (snapshot.hasData) {
                var data = snapshot.data!;

                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Content(data[index]['Item'])));
                      },
                      child: Image.network(data[index]['Item']
                          ['mediumImageUrls'][0]['imageUrl']),
                    );
                  },
                );
              } else {
                return const Text('Waiting...');
              }
            },
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 1; i <= 5; i++)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          page = i;
                        });
                      },
                      child: Text(i.toString()),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
