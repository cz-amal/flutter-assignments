import 'package:flutter/material.dart';

import 'package:basics/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 33, 53, 109),
          Color.fromARGB(255, 2, 21, 149),
        ),
      ),
    ),
  );
}
