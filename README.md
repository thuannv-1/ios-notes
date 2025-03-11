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
<img width="490" alt="image" src="https://github.com/user-attachments/assets/8726dc0d-c789-4a38-bf25-442ddd8f6574" />

- **Testing:** XCTest (Unit & UI Testing)
## 📂 Project Structure
```
📂 ios-notes
├── 📁 Data
│   ├── ServiceProvider.swift
│   ├── 📁 CoreData
│   └── 📁 FireBase
├── 📁 Domain
│   └── 📁 Models
├── 📁 Resources
├── 📁 Supports
│   ├── 📁 Extensions
│   └── 📁 Architecture
├── 📁 Scenes
│   ├── 📁 Home
└── └── ...
```

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

## 📸 Demo Feature

### ✅ Load all notes & Synchronize notes online
### Usage
When opening the main screen, all notes will be displayed, users can pull down to refresh to get the latest notes from online. The displayed notes will be grouped by day.

https://github.com/user-attachments/assets/2ea4769a-5776-44a6-9f36-212726c71a6f


#### How to developement?
Use CoreData to store local data, Firebase to store online data. Every time the app opens, the home screen appears, the user pulls down => Immediately triggers calling data from remote and local. Then, this data is mixed by the prepareSyncNotes function. The mixed data will be displayed to the user, and saved to CoreData & Firebase.
![image](https://github.com/user-attachments/assets/20628242-0c78-4f9a-b423-9c907bf2f15c)


### ✅ Create New Note
#### Usage
Click the "Pencil" button in the lower right corner of the screen to create a new note. Click "Save" after successfully entering data. The first line of the note will be the title, the next lines will be the content.

https://github.com/user-attachments/assets/3c1077c6-2a97-4ada-aee7-7c56aff3887b
#### How to developement?
Use UITextView to allow users to enter information. The applyTitleStyling function is responsible for bolding the first line as the title. After the user clicks the "Save" button => Note will be saved immediately to CoreData. After that, utomatically pops back to Home. On the Home screen, data will be synchronized to FireBase

### ✅ Update an existing note
#### Usage
Select a note on the Home screen to view Note details, here you can edit the note. After editing is complete, click the "Save" button to save the note.

https://github.com/user-attachments/assets/19d540bf-2775-4a4f-9ba4-dca1f8b0ad13
#### How to developement?
On Note Detail Screen, after the user clicks the "Save" button => Note will be saved immediately to CoreData. After that, utomatically pops back to Home. On the Home screen, data will be synchronized to FireBase

### ✅ Delete note
#### ✅ Soft Delete
##### Usage
Select the note you want to delete on the Home screen. On the detail information screen, click the trash icon to "Soft Delete" the note 


https://github.com/user-attachments/assets/55abf78a-4e17-449c-9cae-c8d191a6acce



##### How to developement?
When the user clicks the "Trash" button on an existing note, the deletedAt field will be updated immediately. The filtered Trash screen only displays Notes with deletedAt != nil

#### ✅ Force Delete
Usage: When you select a Note inside the trash, you continue to delete. That Note will disappear completely.


https://github.com/user-attachments/assets/11a0dbc2-5108-4e86-a144-d7da3dc574f3



##### How to developement?
When force deleting Note, Note will be removed from DB

### ✅ Search Notes
##### Usage
Click on Search Bar on the Home screen, enter the keyword you want to search => The system will return a list of Notes matching the keyword being searched and highlight the characters matching the keyword being searched.


https://github.com/user-attachments/assets/c2f5daa9-f7bc-495a-a684-730eb0a08696



##### How to developement?
Khi user nhập từ khoá vào Search Bar tại màn Home, sẽ filter dự trên danh sách notes của user từ DB => nếu có từ khoá match sẽ được highlight qua hàm highlightText trong NoteTableViewCell

## 🔮 Testing
- Unit Tests for ViewModel logic.
- Run tests using:
  ```sh
  cmd + U (in Xcode)
  ```
![image](https://github.com/user-attachments/assets/836a3992-3528-44e5-b0c6-1c10f79efe0d)

## 🎯 Future Improvements
- Multi-device sync via CloudKit.
- Rich text support for notes.
