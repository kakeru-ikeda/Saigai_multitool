import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'U22Map.dart';
import 'U22EC.dart';
import 'U22Radio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '災害対策マルチアプリケーション',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '災害対策マルチアプリケーション'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map categorys = {
    'ECサイト': const U22EC(title: '災害のECサイト'),
    'ハザードマップ': const U22Map(title: '君の地域のハザードマップ'),
    'Webラジオ': const U22Radio(title: 'Webラジオ')
  };

  setCategoryButton(key) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => categorys[key]),
          );
        },
        child: Text(
          key,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var category in categorys.keys) setCategoryButton(category)
        ],
      ),
    );
  }
}
