import 'package:blabla/week10/model/artist/artist.dart';
import 'package:blabla/week10/ui/screens/artist_detail/view_model/artist_detail_view_model.dart';
import 'package:blabla/week10/ui/screens/artist_detail/widgets/artist_detail_content.dart';
import 'package:blabla/week10/ui/services/song_interaction_service.dart';
import 'package:blabla/week10/ui/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;
  const ArtistDetailScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    AppSettingsState settingsState = context.watch<AppSettingsState>();
    return ChangeNotifierProvider<ArtistDetailViewModel>(
      create: (context) => ArtistDetailViewModel(
        artistRepository: context.read(),
        songRepository: context.read(),
        commentRepository: context.read(),
        songInteractionService: context.read<SongInteractionService>(),
        artist: artist,
      ),
      child: Scaffold(
        backgroundColor: settingsState.theme.backgroundColor,
        appBar: AppBar(title: Text(artist.name)),
        body: ArtistDetailContent(),
      ),
    );
  }
}
