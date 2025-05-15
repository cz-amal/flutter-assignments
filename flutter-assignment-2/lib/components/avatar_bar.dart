import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarBar extends StatelessWidget {
  AvatarBar({super.key});

  final List<Widget> avatars = List.generate(6, (index) {
    return Positioned(
      left: 70 + (index * 40),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 32,
        child: CircleAvatar(
          backgroundImage: AssetImage(
            "lib/assets/images/profile-${index + 1}.jpg",
          ),
          radius: 30,
        ),
      ),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(color: Color.fromARGB(100, 200, 215, 230)),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Stack(alignment: Alignment.center, children: avatars),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "22 FOLLOWERS YOU KNOW",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
