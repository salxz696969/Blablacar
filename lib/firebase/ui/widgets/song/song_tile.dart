import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final artistName = song.artist != null
        ? "${song.artist!.name} - ${song.artist!.genre}"
        : "Unknown Artist";

    final songDuration = song.duration.inMinutes;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(song.title),
          subtitle: Text("$songDuration min - $artistName"),
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(song.imageUrl.toString()),
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: const TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
