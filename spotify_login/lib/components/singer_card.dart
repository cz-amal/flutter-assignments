import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_login/models/singer.dart';

class SingerCard extends StatelessWidget {
  final Singer singer;
  const SingerCard({super.key, required this.singer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(singer.imagePath, height: 185, width: 147, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  singer.song,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  singer.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 50,
            child: Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(color: Color(0xFFE6E6E6), shape: BoxShape.circle),
              child: Image.asset("assets/images/Play.png", color: Color(0xFF555555)),
            ),
          ),
        ],
      ),
    );
  }
}
