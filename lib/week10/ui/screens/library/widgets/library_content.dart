import 'package:blabla/week10/model/songs/song_detail.dart';
import 'package:blabla/week10/ui/widgets/song/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    AsyncValue<List<SongDetail>> asyncValue = mv.data;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );

      case AsyncValueState.success:
        List<SongDetail> data = asyncValue.data!;
        content = RefreshIndicator(
          onRefresh: () async {
            mv.fetchSong();
          },
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => SongTile(
              onHeartTap: () => mv.toggleLike(data[index].song),
              isLiked: mv.isSongLiked(data[index].song),
              data: data[index],
              isPlaying: mv.isSongPlaying(data[index].song),
              onTap: () {
                mv.start(data[index].song);
              },
            ),
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
