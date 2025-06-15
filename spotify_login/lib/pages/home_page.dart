import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_login/components/music_card.dart';
import 'package:spotify_login/components/singer_card.dart';
import 'package:spotify_login/models/music.dart';
import 'package:spotify_login/models/singer.dart';
import 'package:spotify_login/pages/artist_page.dart';
import 'package:spotify_login/pages/profile_page.dart';

const Color bannerTextColor = Color(0xFFFBFBFB);

final sectionTiles = const ['News', 'Video', 'Artists', 'Podcast', 'Concerts'];
final sectionTileColors = const [
  Color(0xFF62CD5D),
  Color(0xFF42C83C),
  Color(0xFF2D264B),
  Color(0xFF7D7D7D),
  Color(0xFFFBFBFB),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages {
    return [
      // Home
      Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                height: 130,
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF42C83C),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                  child: Stack(
                    clipBehavior: Clip.none,
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: sectionTiles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(7.0),
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
            padding: EdgeInsets.symmetric(horizontal: 20),
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
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
      // Discovery
      Center(
        child: Text(
          'Discovery',
          style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      // Artist
      ArtistPage(),
      // Profile
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool showAppBar = _selectedIndex == 0 || _selectedIndex == 1;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar:
          showAppBar
              ? AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  padding: EdgeInsets.only(left: 20),
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/search.png',
                    height: 23.44,
                    width: 23.44,
                    color: Color(0xFF2D264B),
                  ),
                ),
                title: Image.asset(
                  'assets/images/spotify-logo.png',
                  height: 33,
                  width: 108,
                  color: Color(0xFF62CD5D),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Image.asset(
                      'assets/images/dot-menu.png',
                      height: 23.44,
                      color: Color(0xFF7D7D7D),
                    ),
                  ),
                ],
              )
              : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: _selectedIndex, onTap: _onNavTap),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({Key? key, required this.selectedIndex, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          IconButton(
            icon: Image.asset(
              'assets/images/home.png',
              color: selectedIndex == 0 ? Color(0xFF1DB954) : Colors.black,
            ),
            onPressed: () => onTap(0),
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/discovery.png',
              color: selectedIndex == 1 ? Color(0xFF1DB954) : Colors.black,
            ),
            onPressed: () => onTap(1),
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/heart.png',
              color: selectedIndex == 2 ? Color(0xFF1DB954) : Colors.black,
            ),
            onPressed: () => onTap(2),
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/profile.png',
              color: selectedIndex == 3 ? Color(0xFF1DB954) : Colors.black,
            ),
            onPressed: () => onTap(3),
          ),
        ],
      ),
    );
  }
}
