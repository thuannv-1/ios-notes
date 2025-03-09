# 📝 Notes App

## 📌 Description
A simple yet powerful notes-taking application built with SwiftUI and Core Data, following MVVM architecture. Supports offline storage, searching, and seamless syncing when online.

## 🚀 Features
- ✅ Load all notes
- ✅ Create a new note
- ✅ Update an existing note
- ✅ Delete a note (soft delete & force delete)
- ✅ Search notes
- ✅ Store notes in the device’s local database (Core Data)
- ✅ Synchronize notes online

## 🛠️ Tech Stack
- **Language:** Swift
- **Frameworks:** UIKit
- **Storage:** Core Data, FirebaseDatabase
- **Architecture:** MVVM, Clean Architecture
- **Testing:** XCTest (Unit & UI Testing)

## 📥 Installation & Setup
Required: Xcode 16.2
1. Clone the repository:
   ```sh
   git clone git@github.com:thuannv-1/ios-notes.git
   cd ios-notes
   ```
2. Get dependency
   ```sh
   pod install
   ```
3. Open the project in Xcode:
   ```sh
   open ios-notes.xcworkspac
   ```
4. Build & run the project on a simulator or a real device.

## 📸 Demo & Development feature description
![App Screenshot](path-to-screenshot.png)

### Load all notes
### Create New Note
### Update an existing note
### Delete note
### Search note
### Synchronize notes online

## 🏗️ Architecture & Design Decisions
- **MVVM:** Separation of concerns for better maintainability.
- **Core Data:** Persistent storage for offline access.
- **Combine:** Reactive programming for better UI state management.
- **Synchronization:** Background sync implementation to ensure notes stay updated across devices.


