class Music {
  final String name;
  final String singer;
  final String duration;

  Music({required this.name, required this.singer, required this.duration});
}

final List<Music> musics = [
  Music(name: "As It Was", singer: "Harry Style", duration: "5:33"),
  Music(duration: "3:11", name: "Battle Symphony", singer: "Linkin Park"),
];
