import 'package:flutter/material.dart';

class Animal {
  String animalName;
  String kind;
  String imagePath;
  bool flyExist = false;

  Animal({
    @required this.animalName,
    @required this.kind,
    @required this.imagePath,
    this.flyExist
  });
}