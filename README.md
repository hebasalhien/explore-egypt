# Sawahny (Explore Egypt)

A cross-platform Flutter Graduation-Project app for exploring Egypt's landmarks, planning trips, and getting AI-powered travel guidance.

---

## ✨ Features

- **Authentication** — Login, Registration, and session persistence with auto-restore
- **Onboarding** — First-time user walkthrough
- **Home & Trending** — Discover popular Egyptian landmarks and trending destinations
- **Interactive Map** — MapLibre-powered map with landmark browsing
- **Trip Planner** — Create, manage, activate/deactivate multi-day travel plans with daily landmark scheduling
- **Suggested Plans** — Browse and save pre-built itineraries
- **AI Chat Assistant** — Text & voice conversation with a bot for travel recommendations (supports Markdown responses and voice bubbles)
- **Favorites** — Save and revisit favorite places
- **User Profile** — View and update user information
- **Help Center** — In-app support section
- **Offline Support** — Active trip cached locally via Hive for offline access

---

### 🎥 Video Demo

![App Demo](assets/screenshots/video_demo.gif)

---

## 📦 Key Dependencies

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management (Cubits) |
| `dio` | HTTP client |
| `hive` + `hive_flutter` | Local database / offline cache |
| `maplibre` | Interactive map rendering |
| `flutter_secure_storage` | Secure token storage |
| `record` + `flutter_pcm_sound` | Voice recording & playback |
| `just_audio` | Audio playback |
| `flutter_markdown` | Render bot responses as Markdown |
| `geolocator` | Device GPS location |
| `web_socket_channel` | Real-time chat via WebSocket |
| `cached_network_image` | Efficient image loading |
| `flutter_dotenv` | Environment variable management |
