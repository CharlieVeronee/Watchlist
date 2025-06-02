# 🎬 Watchlist – Group Movie Recommendation iOS App

**Watchlist** is a movie recommendation app designed to make group viewing easier. By combining personal watch histories, preferences, and metadata from external sources, the app recommends movies that _everyone_ in your group will to enjoy. Everyone I know uses Letterboxd to rate movies, yet it's so hard to pick a movie when with friends. Watchlist takes your letterboxd ratings and history to recommend movies to your group of friends.

Live version coming soon. Clone the repo and download to iPhone with XCode to use.

## 🔍 Features

- **Smart group recommendations** based on unwatched and previously liked films
- **Automated data ingestion** from Letterboxd, Simkl, and TMDb
- **ETL pipeline** to auto-build in-app user profiles
- **UX tested** with 8 users; improved satisfaction by 50 percentage points

## 🛠️ Tech Stack

| Layer        | Tools / Frameworks              |
| ------------ | ------------------------------- |
| **Frontend** | Swift (iOS app)                 |
| **Backend**  | Swift Data, REST APIs, OAuth2   |
| **External** | TMDb API, Letterboxd, Simkl API |

## 📁 Folder Structure

watchlist/

├── files/ # Swift code

│ ├── API/ # API clients for metadata, posters, watch history, user ratings, and OAuth

│ ├── Assets/ # Static assets like icons, colors, and images

│ ├── Loader/ # Data loaders and async fetch logic

│ ├── Model/ # Data models representing movies, users, etc.

│ ├── Views/ # SwiftUI views and layout components

│ └── Widgets/ # Custom app widgets and extensions

├── README.md # Project documentation

└── Wireframe.pdf # Initial UI/UX mockup from Figma
