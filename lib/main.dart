import 'package:earthquake_visualiser/api/usgsController.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final USGSController usgs = USGSController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () async {
                    await usgs.getResponse().then();
                  },
                  child: const Text("Get results"))
            ]),
          ),
        ),
      ),
    );
  }
}
// 
// 