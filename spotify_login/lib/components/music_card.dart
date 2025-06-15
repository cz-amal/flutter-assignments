import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_login/models/music.dart';

class MusicCard extends StatelessWidget {
  final Music music;
  const MusicCard({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(color: Color(0xFFE6E6E6), shape: BoxShape.circle),
            child: Image.asset("assets/images/Play.png", color: Color(0xFF555555)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  music.name,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                music.singer,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            width: 40,
            child: Text(
              music.duration,
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite, color: Colors.grey)),
        ],
      ),
    );
  }
}
