import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotify_login/pages/get_started_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => const GetStartedPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Center(
        child: Image.asset(
          'assets/images/spotify-logo.png',
          width: 196,
          height: 59,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
