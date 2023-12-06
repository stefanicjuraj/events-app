<div align="center">
<img src="./lib/assets/logo.png" height="50%" width="50%">
</div>

iOS Swift application fetching and displaying events with Google Firebase (Firestore) database integration.

## Features
- [x] **Google Firebase (Firestore) integration**
  - All event data is stored in the database, enabling real-time updates and scalability.
- [x] **Dynamic event listings**
  - Users can browse and search for various upcoming events.
- [x] **Detailed event view**
  - Upon tapping any event from the listing, users are presented with comprehensive details about the event. This includes a description, date and time, venue, event image, organizer details, and any other associated data.
- [x] **Event reminders**
  - Users can set reminders for events they're interested in, ensuring they don't miss out. The application creates a reminder in the native Reminders application.
- [x] **Dynamic Search & Sort**
  - Users can search events by event name.
- [x] **Countdown Calculations**
  - Calculates remaining days until the event.
- [x] **Dark Mode & Light Mode**
  - Automatic by detecting user settings.

### Integration

This repository contains the Swift code for managing Google Firebase database within an iOS application. The application utilizes `GoogleService-Info.plist`; a configuration file used in iOS applications that integrate Firebase services. 

The primary focus is on the FirestoreManager class and the EventsApp SwiftUI application. FirestoreManager is responsible for fetching and managing event data from Firestore, while EventsApp serves as the main entry point of the application. FirestoreManager is an ObservableObject class that fetches and stores event data from Firestore. It publishes an array of Event objects that can be observed by SwiftUI views. 

