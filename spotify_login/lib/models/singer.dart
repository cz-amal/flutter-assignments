class Singer {
  final String name;
  final String song;
  final String imagePath;

  Singer({required this.name, required this.song, required this.imagePath});
}

final List<Singer> singers = [
  Singer(name: "Billy Ellish", song: "Bad guy", imagePath: "assets/images/billy-1.jpg"),
  Singer(name: "Drake", song: "Scorpion", imagePath: "assets/images/drake.jpg"),
];
