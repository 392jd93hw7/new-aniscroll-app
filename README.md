# AniScroll

AniScroll is an Android-first anime streaming app built with Flutter.

## Product direction

- Dark-only interface inspired by the supplied Animax references.
- Purple accent replacing the original green.
- Account-based authentication (not local-only profiles).
- AniScroll API for watch data and HLS proxy URLs.
- AniList for anime metadata, characters and voice actors.
- Kitsu for episode information and thumbnails.
- MPV/libmpv is the planned playback engine, with Flutter-owned controls.

## Getting started

1. Install Flutter (stable) and Android Studio / Android SDK.
2. Run `flutter pub get`.
3. Run `flutter run` on an Android 10+ device or emulator.

## Current implementation status

The initial app foundation and API clients are in place. Authentication UI is a presentation layer only until the account/authentication endpoints are confirmed. Home, discovery, player, downloads and profile features will be implemented in subsequent milestones.

## API configuration

- AniScroll API: `https://api.aniscroll.in/api/`
- Kitsu API: `https://kitsu.io/api/edge/`
- AniList GraphQL: `https://graphql.anilist.co`

Do not commit API secrets or user credentials.
