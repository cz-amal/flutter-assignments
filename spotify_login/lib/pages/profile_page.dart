import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'soroushmrorouyi@gmail.com',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Soroushnrz',
                    style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '778',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Followes',
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      const SizedBox(width: 40),
                      Column(
                        children: [
                          Text(
                            '243',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Followes',
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PUBLIC PLAYLISTS',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPlaylistItem(
                    'Dont Smile At Me',
                    'Billie Eilish',
                    'assets/images/album-1.jpg',
                  ),
                  _buildPlaylistItem('As It Was', 'Harry Styles', 'assets/images/album-2.jpg'),
                  _buildPlaylistItem(
                    'Super Freaky Girl',
                    'Nicki Minaj',
                    'assets/images/album-3.jpg',
                  ),
                  _buildPlaylistItem('Bad Habit', 'Steve Lacy', 'assets/images/album-1.jpg'),
                  _buildPlaylistItem('Planet Her', 'Doja Cat', 'assets/images/album-2.jpg'),
                  _buildPlaylistItem(
                    'Sweetest Pie',
                    'Megan Thee Stallion',
                    'assets/images/album-3.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(String title, String artist, String imageAsset) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: AssetImage(imageAsset), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(artist, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Row(
            children: [
              Text('5:33', style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
              const SizedBox(width: 16),
              Icon(Icons.more_horiz_rounded, color: Colors.grey[600]),
            ],
          ),
        ],
      ),
    );
  }
}
