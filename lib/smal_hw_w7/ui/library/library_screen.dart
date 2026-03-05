import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/songs/song_repository.dart';
import '../states/player_state.dart';
import 'view_model/library_view_model.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final songRepository = context.read<SongRepository>();
    final playerState = context.read<PlayerState>();

    return ChangeNotifierProvider<LibraryViewModel>(
      create: (_) {
        final viewModel = LibraryViewModel(
          songRepository: songRepository,
          playerState: playerState,
        );
        viewModel.init();
        return viewModel;
      },
      child: const LibraryContent(),
    );
  }
}
