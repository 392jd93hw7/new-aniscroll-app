import 'package:dio/dio.dart';
import '../models/watch_response.dart';

class AniScrollApi {
  AniScrollApi({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: 'https://api.aniscroll.in/api/',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
          headers: const {'Accept': 'application/json'},
        ));

  final Dio _dio;

  Future<WatchResponse> getWatchData({
    required int anilistId,
    required int episode,
    required String type,
    String source = 'anikoto',
    String? server,
  }) async {
    if (type != 'sub' && type != 'dub') {
      throw ArgumentError.value(type, 'type', 'Expected sub or dub');
    }
    final response = await _dio.get<Map<String, dynamic>>(
      'watch/$source/$anilistId/$episode/$type',
      queryParameters: server == null ? null : {'server': server},
    );
    final data = response.data;
    if (data == null) {
      throw const FormatException('AniScroll returned an empty watch response.');
    }
    final watch = WatchResponse.fromJson(data);
    if (watch.hlsProxyUrl.isEmpty && !watch.iframeOnly) {
      throw const FormatException('The watch response has no HLS proxy URL.');
    }
    return watch;
  }
}
