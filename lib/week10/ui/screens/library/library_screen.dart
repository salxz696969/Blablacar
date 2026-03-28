import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/artist/artist_repository.dart';
import '../../services/song_interaction_service.dart';
import 'view_model/library_view_model.dart';
import '../../../data/repositories/songs/song_repository.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryViewModel(
        songInteractionService: context.read<SongInteractionService>(),
        songRepository: context.read<SongRepository>(),
        artistRepository: context.read<ArtistRepository>(),
      ),
      child: LibraryContent(),
    );
  }
}
