import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class U22Map extends StatefulWidget {
  const U22Map({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<U22Map> createState() => _U22MapState();
}

class _U22MapState extends State<U22Map> {
  @override
  void initState() {
    super.initState();
    checkLocation();
    getLocation();
  }

  Future<bool> checkLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Map locationDatas = {
    'longitude': '',
    'latitude': '',
    'address': '',
    'prefecture': '',
    'city': ''
  };
  Map disasterList = <String, Map<String, String>>{
    'jishin': {'content': '地震', 'url': ''},
    'tsunami': {'content': '津波', 'url': ''},
    'dosyasaigai': {'content': '土砂災害', 'url': ''},
    'kasai': {'content': '火災', 'url': ''},
    'kazan': {'content': '火山', 'url': ''},
    'sougou': {'content': '総合', 'url': ''}
  };

  Future<void> getLocation() async {
    Location location = Location();
    LocationData locationData = await location.getLocation();
    locationDatas['longitude'] = locationData.longitude.toString();
    locationDatas['latitude'] = locationData.latitude.toString();
    print(locationDatas);

    final placemarks = await geocoding.placemarkFromCoordinates(
        double.parse(locationDatas['latitude']),
        double.parse(locationDatas['longitude']));
    final placemark = placemarks.first;
    print(placemark);

    setState(() {
      locationDatas['address'] = placemark.street!;
      locationDatas['prefecture'] = placemark.administrativeArea!;
      locationDatas['city'] = placemark.locality!;
    });

    for (var disaster in disasterList.entries) {
      String loadData = await rootBundle.loadString('src/${disaster.key}.json');
      final List jsonResponse = json.decode(loadData);

      // 都道府県と市区町村の合致を探索し、URLを取得
      for (var data in jsonResponse) {
        // print(data);
        var find = data.entries.firstWhere(
            (entry) =>
                entry.key == 'prefecture' &&
                entry.value == locationDatas['prefecture'],
            orElse: () => const MapEntry('empty', 0));

        if (find.key != 'empty') {
          find = data.entries.firstWhere(
              (entry) =>
                  entry.key == 'city' && entry.value == locationDatas['city'],
              orElse: () => const MapEntry('empty', 0));
          if (find.key != 'empty') {
            setState(() {
              disasterList[disaster.key]['url'] = data['url'];
            });
            break;
          }
        } else {
          setState(() {
            disasterList[disaster.key]['url'] = '該当なし';
          });
          continue;
        }
      }
    }
  }

  Widget setCard(String disaster) {
    return GestureDetector(
        onTap: () async {
          final uri = Uri.parse(disasterList[disaster]['url']);
          if (disasterList[disaster]['url'] != '該当なし') {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Text(
                  disasterList[disaster]['content'],
                  style: const TextStyle(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(disasterList[disaster]['url'])
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                '現在の位置情報',
                style: TextStyle(fontSize: 24),
              ),
              Text(locationDatas['address']),
            ],
          ),
          for (var disaster in disasterList.entries) setCard(disaster.key)
        ],
      ),
    );
  }
}
