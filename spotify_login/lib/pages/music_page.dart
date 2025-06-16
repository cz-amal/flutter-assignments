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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: const Color(0xFF2D264B)),
                    ),
                    title: Text(
                      "Now playing",
                      style: GoogleFonts.poppins(
                        fontSize: isTablet ? 20 : 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(Icons.more_vert, color: const Color(0xFF7D7D7D)),
                      ),
                    ],
                  ),
          body: isTablet ? buildTabletLayout(constraints) : buildMobileLayout(),
        );
      },
    );
  }

  Widget buildTabletLayout(BoxConstraints constraints) {
    return Row(
      children: [
        // Left side - Album Art
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.15, // 15% of the screen width
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset('assets/images/billy-1.jpg', fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: const AssetImage('assets/images/billy-1.jpg'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF404040),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_outline),
                      iconSize: 22,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Right side - Controls and Lyrics
        Expanded(
          flex: 4,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Progress bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: 0.7,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[800]!),
                          minHeight: 6,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "2:23",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF404040),
                              ),
                            ),
                            Text(
                              "4:45",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF404040),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Playback controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(icon: const Icon(Icons.repeat), iconSize: 32, onPressed: () {}),
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        iconSize: 42,
                        onPressed: () {},
                      ),
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xFF42C83C),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF42C83C).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.pause),
                          iconSize: 42,
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      IconButton(icon: const Icon(Icons.skip_next), iconSize: 42, onPressed: () {}),
                      IconButton(icon: const Icon(Icons.shuffle), iconSize: 32, onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Lyrics toggle
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        showLyrics = !showLyrics;
                      });
                    },
                    icon: Icon(
                      showLyrics ? Icons.arrow_downward : Icons.arrow_upward,
                      color: const Color(0xFF404040),
                    ),
                    label: Text(
                      "Lyrics",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF404040),
                      ),
                    ),
                  ),
                  if (showLyrics) Expanded(child: buildLyricsView()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMobileLayout() {
    return Column(
      children: [
        AnimatedSwitcher(duration: const Duration(milliseconds: 500), child: buildMusicPlayer()),
      ],
    );
  }

  // Move lyrics list to be accessible by both layouts
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

  Widget buildMusicPlayer() {
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
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              "Bad Guy",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ...lyrics.map(
              (line) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  line,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
