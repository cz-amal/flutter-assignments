import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    return Scaffold(
        body: screenWidth <= 500
            ? Column(
                children: [
                  Image.asset(
                    "lib/assets/images/hotel.jpg",
                    height: 291,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hotel Park Residency",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Thrissur,Kerala",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      Row(
                        children: [
                          Text("4.3 "),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orange,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.call,
                            color: Colors.blue,
                          ),
                          Text(
                            "Phone",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.route, color: Colors.blue),
                          Text("Route", style: TextStyle(color: Colors.blue))
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.share, color: Colors.blue),
                          Text("Share", style: TextStyle(color: Colors.blue))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                    child: Text(
                        "Situated in Trichr, 1.7 km from Bible Tower, Daan Regency features accommodation with a restaurant, free private parking, a shared lounge and a garden. The property is located 2.1 km from Vadakkunnathan Shiva Shacthram, 2.1 km from Thrissur Pooram and 3.1 km from Thiruvambady Sri Krishna Temple. The accommodation provides a 24-hour front desk, room service and organising tours for guests."
                        "At the hotel, rooms come with a wardrobe. At Daan Regency the rooms have a desk, a flat-screen TV and a private bathroom."
                        "An Asian breakfast is available each morning at the accommodation."),
                  )
                ],
              )
            : Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "lib/assets/images/hotel.jpg",
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 55,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 150),
                              child: Text(
                                "Hotel Park Residency",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Text("4.3 "),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.orange,
                                )
                              ],
                            )
                          ],
                        ),
                        Text(
                          "Thrissur,Kerala",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          child: Text(
                              "Situated in Trichr, 1.7 km from Bible Tower, Daan Regency features accommodation with a restaurant, free private parking, a shared lounge and a garden. The property is located 2.1 km from Vadakkunnathan Shiva Shacthram, 2.1 km from Thrissur Pooram and 3.1 km from Thiruvambady Sri Krishna Temple. The accommodation provides a 24-hour front desk, room service and organising tours for guests."
                              "At the hotel, rooms come with a wardrobe. At Daan Regency the rooms have a desk, a flat-screen TV and a private bathroom."
                              "An Asian breakfast is available each morning at the accommodation."),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.blue,
                                ),
                                Text(
                                  "Phone",
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.route, color: Colors.blue),
                                Text("Route",
                                    style: TextStyle(color: Colors.blue))
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.share, color: Colors.blue),
                                Text("Share",
                                    style: TextStyle(color: Colors.blue))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ));
  }
}
