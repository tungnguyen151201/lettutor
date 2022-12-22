import 'package:flutter/material.dart';

List<double> generateAsisChildRatio(BoxConstraints constraints) {
  if (constraints.maxWidth > 1024) {
    return [8, .3];
  } else if (constraints.maxWidth > 700) {
    return [5, .3];
  } else if (constraints.maxWidth > 600) {
    return [4, .3];
  } else if (constraints.maxWidth > 500) {
    return [3, .3];
  } else if (constraints.maxWidth > 300) {
    return [2, .3];
  } else {
    return [1, .2];
  }
}
