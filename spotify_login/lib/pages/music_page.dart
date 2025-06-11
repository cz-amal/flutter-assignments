import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool showLyrics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar:
          showLyrics
              ? null
              : AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  padding: const EdgeInsets.only(left: 20),
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back, color: const Color(0xFF2D264B)),
                ),
                title: Text(
                  "Now playing",
                  style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(Icons.more_vert, color: const Color(0xFF7D7D7D)),
                  ),
                ],
              ),
      body: Column(
        children: [
          AnimatedSwitcher(duration: const Duration(milliseconds: 500), child: buildMusicPlayer()),
        ],
      ),
    );
  }

  Widget buildMusicPlayer() {
    final lyrics = [
      "Sleepin', You're On Your Tippy Toes",
      "Creepin' Around Like No One Knows",
      "Think You're So Criminal",
      "Bruises On Both My Knees For You",
      "Don't Say Thank You Or Please",
      "I Do What I Want When I'm Wanting To",
      "My Soul? So Cynical",
      "Sleepin', You're On Your Tippy Toes",
      "Creepin' Around Like No One Knows",
      "Think You're So Criminal",
      "Bruises On Both My Knees For You",
      "Don't Say Thank You Or Please",
      "I Do What I Want When I'm Wanting To",
      "My Soul? So Cynical",
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius:
                  showLyrics
                      ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )
                      : BorderRadius.circular(30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/billy-1.jpg',
                    height: showLyrics ? 570 : 400,
                    width: showLyrics ? double.infinity : 320,
                    fit: BoxFit.cover,
                  ),
                  if (showLyrics)
                    Container(
                      height: showLyrics ? 480 : 320,
                      width: 320,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bad Guy",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            ...lyrics.map(
                              (line) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  line,
                                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  showLyrics = false;
                                });
                              },
                              icon: const Icon(Icons.arrow_downward, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 44),
        Row(
          children: [
            if (showLyrics)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: const AssetImage('assets/images/billy-1.jpg'),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bad Guy",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Billie Eilish",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF404040),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(padding: const EdgeInsets.only(right: 35), child: Icon(Icons.favorite_outline)),
          ],
        ),
        const SizedBox(height: 44),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Row(
            children: [
              Expanded(flex: 2, child: Container(height: 4, color: Colors.grey[800])),
              ClipOval(child: Container(height: 14, width: 14, color: Colors.black)),
              Expanded(flex: 1, child: Container(height: 2, color: Colors.grey[300])),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                "2:23",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF404040),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Text(
                "4:45",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF404040),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 44),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.repeat, size: 24),
              Icon(Icons.skip_previous, size: 24),
              ClipOval(
                child: Container(
                  height: 56,
                  width: 56,
                  color: const Color(0xFF42C83C),
                  child: const Icon(Icons.pause, color: Colors.white, size: 28),
                ),
              ),
              Icon(Icons.skip_next, size: 24),
              Icon(Icons.shuffle, size: 24),
            ],
          ),
        ),
        const SizedBox(height: 32),
        if (!showLyrics) ...[
          IconButton(
            onPressed: () {
              setState(() {
                showLyrics = true;
              });
            },
            icon: Icon(Icons.arrow_upward),
          ),
          const SizedBox(height: 8),
          Text(
            "Lyrics",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF404040),
            ),
          ),
        ] else ...[
          IconButton(
            onPressed: () {
              setState(() {
                showLyrics = false;
              });
            },
            icon: Icon(Icons.arrow_downward),
          ),
          const SizedBox(height: 8),
          Text(
            "Lyrics",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF404040),
            ),
          ),
        ],
      ],
    );
  }

  Widget buildLyricsView() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showLyrics = false;
        });
      },
      child: Stack(
        children: [
          // Lyrics + avatar
          SingleChildScrollView(
            child: Column(
              children: [
                // Circular album art avatar
                Text(
                  "Bad Guy",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
