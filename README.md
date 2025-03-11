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
#### Soft Delete
##### Usage
Select the note you want to delete on the Home screen. On the detail information screen, click the trash icon to "Soft Delete" the note 
https://github.com/user-attachments/assets/2d7aea42-75ae-4249-b80e-5af12dd1371a
##### How to developement?
Khi người dùng bấm nút "Trash" 1 note sẵn có. ngay lập tức trường deletedAt sẽ được update. Tại màn Trash được lọc chỉ hiển thị các Note có deletedAt != nil

#### Force Delete
Usage: When you select a Note inside the trash, you continue to delete. That Note will disappear completely.
https://github.com/user-attachments/assets/fce14be9-d987-4d79-a2b7-d9cdf4b45799


### Search note
- Click on Search Bar on the Home screen, enter the keyword you want to search => The system will return a list of Notes matching the keyword being searched and highlight the characters matching the keyword being searched.



