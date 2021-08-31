import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // Map data = {};
  void fetchData() async {
    // var url = Uri.parse('http://10.0.2.2:5279');
    // var response = await http.post(
    //     url,
    //     body:
    //     json.encode({"method": "claim_search",
    //       "params": {"order_by":"effective_amount", "claim_type":"stream",
    //         "page":1, "page_size":5}}));
    // setState(() {
    //   data = json.decode(response.body)["result"];
    // });
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: SpinKitFadingCube(
      //     color: Colors.green,
      //     size: 50.0,
      //   ),
      // ),
    );
  }
}
