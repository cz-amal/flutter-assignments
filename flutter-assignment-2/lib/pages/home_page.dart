import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/components/avatar_bar.dart';
import 'package:flutter_assignment_2/components/data_bar.dart';
import 'package:flutter_assignment_2/components/icon_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imagePath = [
    "lib/assets/icons/twitter.png",
    "lib/assets/icons/facebook.png",
    "lib/assets/icons/instagram.png",
    "lib/assets/icons/github.png",
    "lib/assets/icons/pinterest.png",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  "lib/assets/images/background.jpg",
                  fit: BoxFit.fitHeight,
                ),
              ),

              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ],
          ),

          Positioned(
            height: 600,
            width: 400,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.5,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Eastin Arafat",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "UI/UX DESIGNER",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(imagePath.length, (index) {
                      return IconBar(
                        iconPath: imagePath[index],
                        isSelected: index == selectedIndex,
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 50,
                    children: [
                      DataBar(title: "240", subtitle: "FOLLOWING"),
                      DataBar(title: "24K", subtitle: "FOLLOWER"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  AvatarBar(),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "FOLLOW NOW",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 90,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 82,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("lib/assets/images/profile.jpg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
