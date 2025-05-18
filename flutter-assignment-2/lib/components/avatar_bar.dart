import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarBar extends StatelessWidget {
  AvatarBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(color: Color.fromARGB(100, 200, 215, 230)),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(6, (index) {
                return Positioned(
                  left:
                      screenWidth <= 500
                          ? 70 + (index * 40)
                          : 100 + (index * 40),
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
              }),
            ),
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
