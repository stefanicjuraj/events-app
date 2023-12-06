//
//  FirestoreManager.swift
//  Events
//
//  Created by Juraj Stefanic on 01.12.2023..
//

import Foundation
import Firebase

// FirestoreManager
class FirestoreManager: ObservableObject {
    
    // Events
    @Published var events: [Event] = []
    
    // Init
    init() {
        fetchEvent()
    }
    
    // Fetch event
    func fetchEvent() {
        events.removeAll()
        // db
        let db = Firestore.firestore()
        // ref
        let ref = db.collection("Events")
        // ref.getDocuments
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            // Safely unwrap snapshot.documents
            if let documents = snapshot?.documents {
                for document in documents {
                    // data
                    let data = document.data()
                    // Fetch data properties
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let about = data["about"] as? String ?? ""
                    let venue = data["venue"] as? String ?? ""
                    let organizer = data["organizer"] as? String ?? ""
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let latitude = data["latitude"] as? Double ?? 0
                    let longitude = data["longitude"] as? Double ?? 0
                    let contact = data["contact"] as? NSNumber ?? 0
                    let email = data["email"] as? String ?? ""
                    let technologies = data["technologies"] as? String ?? ""
                    let attendees = data["attendees"] as? String ?? ""
                    
                    let event = Event(id: id, name: name, description: description, about: about, venue: venue, organizer: organizer, date: date, imageUrl: imageUrl, latitude: latitude, longitude: longitude, contact: contact, email: email, technologies: technologies, attendees: attendees)
                    self.events.append(event)
                } // documents
            } // documents snapshot
        } // getDocuments
    } // fetchEvent
    
} // FirestoreManager
