import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: isTablet,
            title: Text(
              'Profile',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: isTablet ? 24 : 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                onPressed: () {},
                iconSize: isTablet ? 28 : 24,
              ),
            ],
          ),
          body: isTablet ? _buildTabletLayout() : _buildMobileLayout(),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileHeader(),
          const SizedBox(height: 32),
          _buildPlaylistSection(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Left panel - Profile info
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Soroushnrz',
                      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'soroushmrorouyi@gmail.com',
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTabletStatsCard('778', 'Followers'),
                        _buildTabletStatsCard('243', 'Following'),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1DB954),
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Right panel - Playlists
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.grey[50],
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PUBLIC PLAYLISTS',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add, color: Color(0xFF1DB954)),
                          label: Text(
                            'Create New',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF1DB954),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletStatsCard(String number, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(number, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
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
          Text('Soroushnrz', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
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
    );
  }

  Widget _buildPlaylistSection() {
    return Padding(
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
          _buildPlaylistItem('Dont Smile At Me', 'Billie Eilish', 'assets/images/album-1.jpg'),
          _buildPlaylistItem('As It Was', 'Harry Styles', 'assets/images/album-2.jpg'),
          _buildPlaylistItem('Super Freaky Girl', 'Nicki Minaj', 'assets/images/album-3.jpg'),
          _buildPlaylistItem('Bad Habit', 'Steve Lacy', 'assets/images/album-1.jpg'),
          _buildPlaylistItem('Planet Her', 'Doja Cat', 'assets/images/album-2.jpg'),
          _buildPlaylistItem('Sweetest Pie', 'Megan Thee Stallion', 'assets/images/album-3.jpg'),
        ],
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
