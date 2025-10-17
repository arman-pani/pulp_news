# Odia News App Implementation

## Overview
This Flutter app implements a news application with Firebase Function endpoints for Odia language content. The app features offline support, bookmarking, search functionality, and category-based browsing.

## Features Implemented

### 1. Home Page
- **PageView.builder** with vertical scrolling for articles
- **Pagination** with automatic loading when reaching near the end
- **Offline support** - shows cached articles first, then fetches new ones
- **Loading states** and error handling
- **Bookmark functionality** with visual feedback

### 2. Search Page
- **Search functionality** using Firebase Function endpoint
- **Recent searches** stored locally with Hive
- **Category browsing** with dynamic category loading
- **Real-time search** with debouncing
- **Empty state** handling

### 3. Bookmarks Page
- **Local storage** of bookmarked articles using Hive
- **Bookmark management** (add/remove/clear all)
- **Empty state** with helpful messaging
- **Real-time updates** when bookmarks change

### 4. Profile Page
- **Theme toggle** (Dark/Light mode) with local persistence
- **Language settings** (English/Odia) with local persistence
- **About Us** section with app information
- **Anonymous user** support (no account management needed)

### 5. Article Detail Page
- **Full-screen article view** with image and content
- **Bookmark toggle** functionality
- **Share button** (placeholder)
- **Responsive design** with proper scrolling

## Technical Implementation

### Dependencies Added
- `hive` & `hive_flutter` - Local database for caching
- `cached_network_image` - Image caching and loading
- `flutter_localizations` & `intl` - Internationalization support
- `hive_generator` & `build_runner` - Code generation for Hive

### Architecture
- **GetX** for state management
- **GoRouter** for navigation
- **Hive** for local data persistence
- **Dio** for HTTP requests
- **Firebase** for backend services

### Data Flow
1. **Home Page**: Loads cached articles → Fetches new articles → Updates cache
2. **Search**: User input → API call → Store in recent searches → Display results
3. **Bookmarks**: Local storage operations → Real-time UI updates
4. **Profile**: Settings persistence → Theme/language updates

### Firebase Function Endpoints
- `GET /get_unseen_articles_endpoint` - Fetch unseen articles with pagination
- `GET /get_articles_by_category_endpoint` - Fetch articles by category
- `GET /search_articles_endpoint` - Search articles by query
- `GET /get_categories_endpoint` - Get available categories

### Local Storage (Hive)
- **Articles Box**: Cached news articles
- **Bookmarks Box**: Bookmarked article IDs
- **Recent Searches Box**: Search history
- **Settings Box**: Theme and language preferences

## Usage Instructions

1. **Update Firebase Configuration**:
   - Replace `https://your-firebase-project-id.cloudfunctions.net` in `dio_handler.dart` with your actual Firebase project URL
   - Ensure Firebase Functions are deployed and accessible

2. **Run the App**:
   ```bash
   flutter packages get
   flutter packages pub run build_runner build
   flutter run
   ```

3. **Features to Test**:
   - Swipe vertically on home page to browse articles
   - Search for articles using the search page
   - Bookmark articles by tapping the bookmark icon
   - View bookmarked articles in the bookmarks page
   - Change theme and language in profile page
   - Tap on articles to view full content

## Notes
- The app uses Firebase Anonymous Authentication (no login required)
- All data is cached locally for offline access
- Pagination loads 20 articles per batch
- Recent searches are limited to 10 items
- Theme and language settings persist across app restarts
