import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFileMain extends StatefulWidget {
  @override
  _LargeFileMainState createState() => _LargeFileMainState();
}

class _LargeFileMainState extends State<LargeFileMain> {
  final imgUrl = 'https://effigis.com/wp-content/uploads/2015/02/Airbus_Pleiades_50cm_8bit_RGB_Yogyakarta.jpg';
  bool downloading = false;
  var progressString = '';
  var file;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
