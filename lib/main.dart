// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:lbry/pages/home.dart';
import 'package:lbry/pages/loading.dart';
import 'package:lbry/pages/show_claim.dart';


void main() {
  // runApp(MyApp());
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/loading': (context) => Loading(),
      '/show_claim': (context) => ShowClaim(),
    },
  )
  );
}

