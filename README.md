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

## ⚡ Sample Navigation

### Login

<img width="353" alt="Image" src="https://github.com/user-attachments/assets/99202bf5-b184-4180-907a-b26767ba5717" />

### Can See Current Friends And Toggle Whether Or Not They Are Watching

<img width="351" alt="Image" src="https://github.com/user-attachments/assets/4347f19b-b408-42b7-8aaf-5c5789193daa" />

### Can login to Simkl to pull user watch history

<img width="358" alt="Image" src="https://github.com/user-attachments/assets/efb64f7d-144b-4586-a6b8-18084033982b" />

### In-app account auto generated

<img width="359" alt="Image" src="https://github.com/user-attachments/assets/42b0ad82-6c04-46ad-8591-c72ba49d0fc9" />
<img width="351" alt="Image" src="https://github.com/user-attachments/assets/5ebb643b-c0b2-4945-a179-2f305c2e2460" />

### Can generate "joint watchlist" (intersection of all users' watchlists)

<img width="358" alt="Image" src="https://github.com/user-attachments/assets/bcbf036f-e147-401e-b401-0e57621f1d1c" />

### Movies have TMDb metadata

<img width="343" alt="Image" src="https://github.com/user-attachments/assets/42969dd9-be7d-4ec3-a0e7-855ee94a5adc" />

### Can generate "watchdlist" (select minimum rating and last seen date to generate movies users previously watched and enjoyed)

<img width="340" alt="Image" src="https://github.com/user-attachments/assets/ff67663e-4caa-4b2c-80ef-a77810a8c544" />
<img width="358" alt="Image" src="https://github.com/user-attachments/assets/a4a65b36-5cfc-4c41-8295-227918c8f566" />
