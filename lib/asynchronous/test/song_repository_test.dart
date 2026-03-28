
import 'package:blabcar/asynchronous/data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  final songRepository = SongRepositoryMock();
  // Test both the success and the failure of the post request
  songRepository.fetchSongById('s1').then((song) {
    print('Song found: ${song?.title}');
  }).catchError((error) {
    print('Error: $error');
  });

  try {
    final song = await songRepository.fetchSongById('s25');
    print('Song found: ${song?.title}');
  } catch (error) {
    print('Error: $error');
  }
  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch.

}
