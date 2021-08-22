import 'package:flutter/material.dart';
import 'package:lbry/pages/home.dart';
import 'package:lbry/pages/loading.dart';


void main() {
  // runApp(MyApp());
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/loading': (context) => Loading(),
    },
  )
  );
}

