import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription? connectivitySubscription;
  ConnectivityResult? oldres;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          print("No Connected!");
          //showNoConnectedDialog(context);
          showNoConnectedSnackBar();
        } else if (oldres == ConnectivityResult.none) {
          if (event == ConnectivityResult.mobile) {
            print("Mobile");
          } else if (event == ConnectivityResult.wifi) {
            print("Wifi");
          }
        }
        oldres = event;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription!.cancel();
  }

  void showNoConnectedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: const Text("No internet connection."),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // void showNoConnectedDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("No Connection"),
  //         content: Row(
  //           children: [
  //             Image.network(
  //               "https://image.lexica.art/md2/f08b79ad-5209-4359-aba9-4dda57338b7a",
  //               width: 30,
  //               height: 30,
  //               fit: BoxFit.cover,
  //             ),
  //             SizedBox(width: 10),
  //             Text("No internet connection."),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  //socket method;
  // void checkConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup("google.com");
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print("connected!");
  //     }
  //   } on SocketException catch (_) {
  //     print("No connection!");
  //   }
  // }

  //method package
  // void checkConnection() async {
  //   var connecResult = await (Connectivity().checkConnectivity());
  //   if (connecResult == ConnectivityResult.none) {
  //     print("No Connection!");
  //   } else if (connecResult == ConnectivityResult.mobile) {
  //     print("Mobile");
  //   } else if (connecResult == ConnectivityResult.wifi) {
  //     print("Wifi");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Status",
                style: TextStyle(fontSize: 30),
              ),

              //
              TextButton(
                onPressed: () => print("hi"),
                //checkConnection();
                // // ignore: avoid_print
                // print("Pressed!");

                child: const Text("Check!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
