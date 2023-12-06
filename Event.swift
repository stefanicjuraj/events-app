//
//  Event.swift
//  Events
//
//  Created by Juraj Stefanic on 01.12.2023..
//

import SwiftUI

// Event
struct Event: Identifiable {
    var id: String
    var name: String
    var description: String
    var about: String
    var venue: String
    var organizer: String
    var date: Date
    var imageUrl: String
    var latitude: Double
    var longitude: Double
    var contact: NSNumber
    var email: String
    var technologies: String
    var attendees: String
}
