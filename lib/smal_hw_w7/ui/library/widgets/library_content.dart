import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/songs/song.dart';
import '../../states/settings_state.dart';
import '../../theme/theme.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryViewModel = context.watch<LibraryViewModel>();
    final settingsState = context.watch<AppSettingsState>();
    final songs = libraryViewModel.songs;

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          const SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                final isPlaying = libraryViewModel.isPlaying(song);

                return _SongTile(
                  song: song,
                  isPlaying: isPlaying,
                  onTap: () => libraryViewModel.onSongTap(song),
                  onStop: () => libraryViewModel.onSongTap(song),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SongTile extends StatelessWidget {
  const _SongTile({
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: isPlaying
          ? SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Playing", style: TextStyle(color: Colors.amber)),
                  TextButton(onPressed: onStop, child: const Text("Stop")),
                ],
              ),
            )
          : null,
    );
  }
}
