class SubtitleTrack {
  const SubtitleTrack({required this.url, required this.language, required this.isDefault});
  final String url;
  final String language;
  final bool isDefault;

  factory SubtitleTrack.fromJson(Map<String, dynamic> json) => SubtitleTrack(
    url: json['url'] as String? ?? '',
    language: json['lang'] as String? ?? 'Unknown',
    isDefault: json['default'] as bool? ?? false,
  );
}

class WatchResponse {
  const WatchResponse({
    required this.anilistId, required this.episode, required this.type,
    required this.source, required this.server, required this.availableServers,
    required this.hlsProxyUrl, required this.playbackMode, required this.iframeOnly,
    required this.subtitles, this.title, this.m3u8, this.intro, this.outro,
  });

  final int anilistId;
  final int episode;
  final String type;
  final String source;
  final String server;
  final List<String> availableServers;
  final String hlsProxyUrl;
  final String playbackMode;
  final bool iframeOnly;
  final List<SubtitleTrack> subtitles;
  final String? title;
  final String? m3u8;
  final Map<String, dynamic>? intro;
  final Map<String, dynamic>? outro;

  factory WatchResponse.fromJson(Map<String, dynamic> json) {
    final subtitleJson = json['subtitles'] as List<dynamic>? ?? const [];
    return WatchResponse(
      anilistId: (json['anilistId'] as num?)?.toInt() ?? 0,
      episode: (json['episode'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? 'sub',
      source: json['source'] as String? ?? 'anikoto',
      server: json['server'] as String? ?? '',
      availableServers: (json['availableServers'] as List<dynamic>? ?? const [])
          .whereType<String>().toList(growable: false),
      hlsProxyUrl: json['hlsProxyUrl'] as String? ?? '',
      playbackMode: json['playbackMode'] as String? ?? 'unknown',
      iframeOnly: json['iframeOnly'] as bool? ?? false,
      subtitles: subtitleJson.whereType<Map<String, dynamic>>()
          .map(SubtitleTrack.fromJson).where((track) => track.url.isNotEmpty)
          .toList(growable: false),
      title: json['title'] as String?,
      m3u8: json['m3u8'] as String?,
      intro: json['intro'] as Map<String, dynamic>?,
      outro: json['outro'] as Map<String, dynamic>?,
    );
  }
}
