import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:just_audio/just_audio.dart';

final Xml2Json xml2json = Xml2Json();
final audioPlayer = AudioPlayer();

void getData() async {
  String url = "https://www.nhk.or.jp/radio/config/config_web.xml";
  http.Response response = await http.get(Uri.parse(url));
  xml2json.parse(response.body);
  var jsondata = xml2json.toParker();
  var data = jsonDecode(jsondata);
  await audioPlayer
      .setUrl(data["radiru_config"]["stream_url"]["data"][2]["r1hls"]);
}

class U22Radio extends StatefulWidget {
  const U22Radio({super.key, required this.title});
  final String title;
  @override
  State<U22Radio> createState() => _U22RadioState();
}

class _U22RadioState extends State<U22Radio> {
  _U22RadioState() {
    getData();
  }
  bool _radioPlayer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(
                  width: 5,
                  color: Colors.red,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _radioPlayer ? audioPlayer.play() : audioPlayer.stop();
                  });
                  _radioPlayer = !_radioPlayer;
                },
                icon: Icon(
                  _radioPlayer ? Icons.play_arrow : Icons.pause,
                ),
                iconSize: 90,
              ),
            ),
            const Text(
              "NHKラジオ",
              style: TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
