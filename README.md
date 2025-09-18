# Windo - Spaces & Files Management App

A modern macOS application built with SwiftUI for managing spaces and files with a clean, intuitive interface.

## 🚀 Quick Start

**Requirements:** macOS 13.0+, Xcode 15.0+, Free Apple ID

**Building & Running:**
1. **Clone/Download** this repository
2. **Open** `Windo.xcodeproj` in Xcode
3. **Sign the app:**
   - Go to Project Settings → Signing & Capabilities
   - Select "Automatically manage signing"
   - Add your Apple ID (free account works)
4. **Build & Run** the project (⌘+R)

**Note:** App will work for 7 days before needing to be re-signed

## 🚀 Features

### Core Functionality
- **Spaces Management** - View and navigate between different spaces
- **Files Display** - Browse files within each space with proper file type icons
- **Real-time API Integration** - Fetches data from remote server
- **Loading States** - Smooth loading indicators and error handling
- **Responsive UI** - Clean, modern interface with hover effects

### Navigation
- **Click Navigation** - Tap on spaces to view their files
- **Keyboard Navigation** - Use left/right arrow keys to navigate between spaces
- **Swipe Navigation** - Swipe left/right to navigate between spaces (trackpad)
- **Back Navigation** - Easy return to spaces list

### File Management
- **File Type Icons** - Automatic icon assignment based on file extensions
- **File Type Support**:
  - 📄 Documents (PDF, DOC, TXT)
  - 🖼️ Images (JPG, PNG, MOV, MP4)
  - 🎵 Audio (MP3, WAV, AAC)
  - 🌐 Web files
  - 📅 Calendar files
  - 💬 Chat files

## 🏗️ Architecture

### MVVM Pattern
The app follows a clean MVVM architecture with proper separation of concerns:

```
Views/
├── SpacesListView.swift      # Main spaces list
├── SpaceDetailView.swift     # Files view for selected space
└── Components/
    ├── SpaceListRow.swift    # Individual space row
    └── SpaceFileRow.swift    # Individual file row

ViewModels/
├── SpacesViewModel.swift     # Manages spaces data
└── FilesViewModel.swift      # Manages files data

Models/
├── Space.swift              # Space data model
└── SpaceFile.swift          # File data model

Services/
└── NetworkService.swift     # API communication

Utils/
└── UiState.swift           # Generic UI state management
```

### State Management
- **UiState Pattern** - Generic enum for handling loading, success, and error states
- **ObservableObject** - Reactive data binding with SwiftUI
- **Async/Await** - Modern concurrency for API calls

## 🔧 Technical Details

### Dependencies
- **SwiftUI** - UI framework
- **Foundation** - Core functionality
- **Combine** - Reactive programming

### API Integration
- **Base URL**: `http://84.247.189.50:3333`
- **Authentication**: Bearer token
- **Endpoints**:
  - `GET /spaces` - Fetch all spaces
  - `GET /files/user_312fp4VVEvlL0nSKysxjpf7MwAz/{spaceName}` - Fetch files for space

### Network Features
- **Comprehensive Debug Logging** - Detailed request/response logging
- **Error Handling** - Graceful error states with retry functionality
- **URL Encoding** - Automatic space name encoding for API calls
- **Loading States** - Visual feedback during API operations

## 🎨 UI/UX Features

### Visual Design
- **Transparency Effects** - Semi-transparent windows with background blur
- **Hover Effects** - Interactive hover states for better UX
- **Loading Indicators** - Smooth progress views
- **Error States** - User-friendly error messages with retry options
- **Empty States** - Clear messaging when no files are present

### Responsive Design
- **Adaptive Layout** - Works with different window sizes
- **Touch/Trackpad Support** - Native gesture recognition
- **Keyboard Accessibility** - Full keyboard navigation support

## 🚀 Getting Started

### Prerequisites
- macOS 13.0+
- Xcode 15.0+
- Swift 5.9+

### Installation
1. Clone the repository
2. Open `Windo.xcodeproj` in Xcode
3. Build and run the project

### Configuration
The app is pre-configured with:
- API endpoints
- Authentication tokens
- Network security settings

## 📱 Usage

### Basic Navigation
1. **View Spaces** - The app loads all available spaces on startup
2. **Select Space** - Click on any space to view its files
3. **Navigate Between Spaces** - Use arrow keys or swipe gestures
4. **Return to List** - Use the back button or swipe back gesture

### File Management
- Files are automatically loaded when you enter a space
- File icons are assigned based on file extensions
- Hover over files to see interactive effects

## 🔮 Future Enhancements

### Planned Features
- **SwiftUI Navigation** - Migration to native NavigationStack for production
- **File Operations** - Upload, download, and manage files
- **Search Functionality** - Search within spaces and files
- **Offline Support** - Cache data for offline access
- **User Authentication** - Dynamic user login system

### Production Considerations
- **Navigation System** - Will use SwiftUI's built-in navigation for production
- **Error Analytics** - Comprehensive error tracking and reporting
- **Performance Optimization** - Caching and lazy loading improvements
- **Accessibility** - Full VoiceOver and accessibility support

## 🛠️ Development Notes

### Code Quality
- **Clean Architecture** - Well-structured MVVM pattern
- **Type Safety** - Strong typing throughout the codebase
- **Error Handling** - Comprehensive error management
- **Debug Support** - Extensive logging for development


---

**Note**: This is a demonstration project showcasing SwiftUI development patterns and API integration. The navigation system is simplified for demo purposes and should be replaced with SwiftUI's built-in navigation for production use.
