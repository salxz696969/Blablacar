// // song_repository_mock.dart

// import '../../../model/songs/song.dart';
// import 'song_repository.dart';

// class SongRepositoryMock implements SongRepository {
//   final List<Song> _songs = [
//     Song(
//       id: 's1',
//       title: 'Mock Song 1',
//       artist: 'Mock Artist',
//       artistId: 'a1',
//       imageUrl: Uri.parse('https://example.com/image1.jpg'),
//       duration: const Duration(minutes: 2, seconds: 50),
//     ),
//     Song(
//       id: 's2',
//       title: 'Mock Song 2',
//       artist: 'Mock Artist',
//       artistId: 'a2',
//       imageUrl: Uri.parse('https://example.com/image2.jpg'),

//       duration: const Duration(minutes: 3, seconds: 20),
//     ),
//     Song(
//       id: 's3',
//       title: 'Mock Song 3',
//       artist: 'Mock Artist',
//       artistId: 'a3',
//       imageUrl: Uri.parse('https://example.com/image3.jpg'),
//       duration: const Duration(minutes: 3, seconds: 20),
//     ),
//     Song(
//       id: 's4',
//       title: 'Mock Song 4',
//       artist: 'Mock Artist',
//       artistId: 'a4',
//       imageUrl: Uri.parse('https://example.com/image4.jpg'),
//       duration: const Duration(minutes: 3, seconds: 20),
//     ),
//     Song(
//       id: 's4',
//       title: 'Mock Song 4',
//       artist: 'Mock Artist',
//       artistId: 'a4',
//       imageUrl: Uri.parse('https://example.com/image4.jpg'),
//       duration: const Duration(minutes: 3, seconds: 20),
//     ),
//     Song(
//       id: 's5',
//       title: 'Mock Song 5',
//       artist: 'Mock Artist',
//       artistId: 'a5',
//       imageUrl: Uri.parse('https://example.com/image5.jpg'),
//       duration: const Duration(minutes: 3, seconds: 20),
//     ),
//   ];

//   @override
//   Future<List<Song>> fetchSongs() async {
//     return Future.delayed(Duration(seconds: 4), () {
//       throw Exception("G3 and G4 the class is finished");
//     });
//   }

//   @override
//   Future<Song?> fetchSongById(String id) async {
//     return Future.delayed(Duration(seconds: 4), () {
//       return _songs.firstWhere(
//         (song) => song.id == id,
//         orElse: () => throw Exception("No song with id $id in the database"),
//       );
//     });
//   }
// }
