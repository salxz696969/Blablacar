import 'package:blabla/week10/model/songs/song_detail.dart';
import 'package:blabla/week10/ui/screens/artist_detail/view_model/artist_detail.dart';
import 'package:blabla/week10/ui/screens/artist_detail/view_model/artist_detail_view_model.dart';
import 'package:blabla/week10/ui/screens/artist_detail/widgets/add_comment_section.dart';
import 'package:blabla/week10/ui/screens/artist_detail/widgets/comment_section.dart';
import 'package:blabla/week10/ui/theme/theme.dart';
import 'package:blabla/week10/ui/utils/async_value.dart';
import 'package:blabla/week10/ui/widgets/song/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistDetailContent extends StatelessWidget {
  const ArtistDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtistDetailViewModel mv = context.watch<ArtistDetailViewModel>();
    final asyncValue = mv.data;
    final bool showComposer = asyncValue.state == AsyncValueState.success;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;
      case AsyncValueState.success:
        final ArtistDetail detail = asyncValue.data!.first;
        content = SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ArtistHeader(detail: detail),
                const SizedBox(height: 28),
                ListView.builder(
                  itemBuilder: (context, index) {
                    final data = SongDetail(
                      song: detail.songs[index],
                      artist: detail.artist,
                    );
                    return SongTile(
                      data: data,
                      isLiked: mv.isSongLiked(data.song),
                      onHeartTap: () => mv.toggleLike(data.song),
                      isPlaying: mv.isSongPlaying(data.song),
                      onTap: () => mv.start(data.song),
                    );
                  },
                  itemCount: detail.songs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                const SizedBox(height: 28),
                CommentSection(comments: detail.comments),
              ],
            ),
          ),
        );
        break;
    }

    return Column(
      children: [
        Expanded(
          child: Padding(padding: const EdgeInsets.all(20), child: content),
        ),
        if (showComposer)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: AddCommentSection(onSend: mv.addComment),
          ),
      ],
    );
  }
}

class _ArtistHeader extends StatelessWidget {
  const _ArtistHeader({required this.detail});

  final dynamic detail;

  @override
  Widget build(BuildContext context) {
    final artist = detail.artist;
    return Column(
      children: [
        CircleAvatar(
          radius: 62,
          backgroundImage: NetworkImage(artist.imageUrl.toString()),
        ),
        const SizedBox(height: 18),
        Text(
          artist.name,
          style: AppTextStyles.body.copyWith(fontSize: 34),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          artist.genre,
          style: AppTextStyles.title.copyWith(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
