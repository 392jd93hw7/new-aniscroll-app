# AniScroll architecture (initial milestone)

## Product constraints
- Android 10+ (API 29+) target.
- Dark-only UI, purple accent.
- Preserve account-based sign-in/sign-up; do not replace it with local-only profiles.
- Flutter owns the player UI; MPV/libmpv is the planned playback engine.

## API ownership
- AniScroll API: watch response, available servers, HLS proxy URL and subtitle proxy URLs.
- AniList GraphQL: anime metadata, characters, staff and voice actors.
- Kitsu JSON:API: episode records, episode titles and thumbnails.

## Playback boundary
The watch endpoint is currently integrated as a typed API client. A playback feature must:
1. Request a fresh watch response for the selected episode/type/server.
2. Prefer hlsProxyUrl over the upstream m3u8 URL.
3. Reject iframe-only responses when the native player is selected and present a clear unsupported-source message.
4. Pass subtitle tracks to the player as external subtitle sources.
5. Treat stream URLs as temporary; do not persist them as offline media.

## Offline downloads
A proxy playlist URL is not itself an offline download. Offline support requires an authorized HLS download path that resolves the selected variant playlist, segments, audio renditions, subtitles and any permitted key material. Do not expose a download action until this has been validated for the source.

## Authentication
The sign-in screen is UI only until the account provider/endpoints and token contract are supplied. Never store passwords. Store issued tokens in platform secure storage once authentication is integrated.

## Android
Set minSdk to 29 in the Android app module after generating the Flutter Android project (flutter create .). Validate MPV native libraries, codecs, PiP and background playback on physical Android 10+ devices.
