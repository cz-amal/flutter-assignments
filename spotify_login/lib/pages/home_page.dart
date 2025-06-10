import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_login/components/music_card.dart';
import 'package:spotify_login/components/singer_card.dart';
import 'package:spotify_login/models/music.dart';
import 'package:spotify_login/models/singer.dart';

const Color bannerTextColor = Color(0xFFFBFBFB);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final sectionTiles = const ['News', 'Video', 'Artists', 'Podcast', 'Concerts'];
  final sectionTileColors = const [
    Color(0xFF62CD5D),
    Color(0xFF42C83C),
    Color(0xFF2D264B),
    Color(0xFF7D7D7D),
    Color(0xFFFBFBFB),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: () {},
          icon: Image.asset(
            'assets/images/search.png',
            height: 23.44,
            width: 23.44,
            color: const Color(0xFF2D264B),
          ),
        ),

        title: Image.asset(
          'assets/images/spotify-logo.png',
          height: 33,
          width: 108,
          color: const Color(0xFF62CD5D),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              'assets/images/dot-menu.png',
              height: 23.44,
              color: const Color(0xFF7D7D7D),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // green container
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 130,
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF42C83C),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 14, bottom: 14),
                  child: Stack(
                    clipBehavior: Clip.none, // Allow overflow
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "New Album",
                            style: GoogleFonts.poppins(fontSize: 10, color: bannerTextColor),
                          ),
                          Text(
                            "Happier Than\nEver",
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: bannerTextColor,
                            ),
                          ),
                          Text(
                            "Billie Ellish",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: bannerTextColor,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 35,
                        top: -65.5,
                        child: Image.asset('assets/images/billy.png', height: 183, width: 320),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: sectionTiles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      sectionTiles[index],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 255,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SingerCard(singer: singers[index % singers.length]);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Playlist",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  "See more",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 255,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return MusicCard(music: musics[index % musics.length]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 73,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(17),
            bottomRight: Radius.circular(17),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/home.png'),
            Image.asset('assets/images/discovery.png'),
            Image.asset('assets/images/heart.png'),
            Image.asset('assets/images/profile.png'),
          ],
        ),
      ),
    );
  }
}
