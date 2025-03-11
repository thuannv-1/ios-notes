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

4. Build & run the project on a simulator or a real device.

## 📸 Demo & Development feature description

### Load all notes
- When opening the main screen, all notes will be displayed, users can pull down to refresh to get the latest notes from online. The displayed notes will be grouped by day.
- Video Demo

### Create New Note
- Click the "Pencil" button in the lower right corner of the screen to create a new note. Click "Save" after successfully entering data. The first line of the note will be the title, the next lines will be the content.
- Video Demo

### Update an existing note
- Select a note on the Home screen to view Note details, here you can edit the note. After editing is complete, click the "Save" button to save the note.

### Delete note
#### Soft Delete
- Select the note you want to delete on the Home screen. On the detail information screen, click the trash icon to "Soft Delete" the note (put the note in the trash and not delete it from the DB).
- Video Demo
#### Force Delete

### Search note
- Click on Search Bar on the Home screen, enter the keyword you want to search => The system will return a list of Notes matching the keyword being searched and highlight the characters matching the keyword being searched.
- Video Demo

### Synchronize notes online
- Every time the Home Screen apear, or the User actively pulls down to refresh, the system will call information from Online DB and Local DB to synchronize. Then it will save the synchronized information to local DB and online DB
- Video Demo
- ![image](https://github.com/user-attachments/assets/20628242-0c78-4f9a-b423-9c907bf2f15c)

