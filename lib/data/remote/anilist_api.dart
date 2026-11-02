import 'package:dio/dio.dart';

class AniListApi {
  AniListApi({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://graphql.anilist.co',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 30),
                headers: const {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ),
            );

  final Dio _dio;

  Future<Map<String, dynamic>> getAnimeCharacters(int anilistId) async {
    const query = r'''
      query ($id: Int) {
        Media(id: $id, type: ANIME) {
          characters(page: 1, perPage: 25, sort: ROLE) {
            edges {
              role
              node {
                id
                name { full native }
                image { large }
                description(asHtml: false)
              }
              voiceActors(language: JAPANESE) {
                id
                name { full }
                image { large }
              }
            }
          }
        }
      }
    ''';

    final response = await _dio.post<Map<String, dynamic>>(
      '',
      data: {'query': query, 'variables': {'id': anilistId}},
    );
    final data = response.data;
    if (data == null) {
      throw const FormatException('AniList returned an empty response.');
    }
    if (data['errors'] != null) {
      throw StateError('AniList GraphQL request failed: ${data['errors']}');
    }
    return data['data'] as Map<String, dynamic>;
  }
}
