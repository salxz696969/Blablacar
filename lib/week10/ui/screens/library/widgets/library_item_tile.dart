import 'package:flutter/material.dart';
import '../view_model/library_item_data.dart';

class LibraryItemTile extends StatelessWidget {
  const LibraryItemTile({
    super.key,
    required this.data,
    required this.isPlaying,
    required this.onTap,
    required this.onHeartTap,
    required this.isLiked,
  });

  final LibraryItemData data;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onHeartTap;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(data.song.title),
          subtitle: Row(
            children: [
              Text("${data.song.duration.inMinutes} mins"),
              SizedBox(width: 20),
              Text("Likes: ${data.song.like}"),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data.song.imageUrl.toString()),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onHeartTap,
                icon: Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
              ),
              Text(
                isPlaying ? "Playing" : "",
                style: TextStyle(color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
