//
//  EventView.swift
//  Events
//
//  Created by Juraj Stefanic on 01.12.2023..
//

import SwiftUI
import MapKit
import EventKit

// EventView
struct EventView: View {
    // Event
    let event: Event
    // EventStore
    private let eventStore = EKEventStore()
    
    // body
    var body: some View {
        // ScrollView
        ScrollView {
            // VStack
            VStack(alignment: .leading, spacing: 20) {
                // Event image load & display
                if let imageUrl = URL(string: event.imageUrl) {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 5)
                    .cornerRadius(15)
                }
                // Event name
                Text(event.name)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // HStack
                HStack {
                    // Event date image
                    Image(systemName: "calendar")
                        .foregroundColor(.primary)
                    // Format and display date
                    Text(formatDate(event.date))
                        .font(.subheadline)
                }
                // HStack
                HStack {
                    // Event venue image
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.primary)
                    // Event venue
                    Text(event.venue)
                        .font(.subheadline)
                }
                // HStack
                HStack {
                    // Event image organizer
                    Image(systemName: "person.fill")
                        .foregroundColor(.primary)
                    // Event organizer
                    Text(event.organizer)
                        .font(.subheadline)
                }
                
                // HStack
                HStack {
                    // Event image attendees
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.primary)
                    // Event attendees
                    Text("\(event.attendees) attendees")
                        .font(.subheadline)
                }
                
                // VStack
                VStack(alignment: .leading, spacing: 20) {
                    
                    // HStack buttons
                    HStack(spacing: 10) {
                        // Tickets button
                        Button(action: {
                        }) {
                            // HStack button
                            HStack {
                                // Event ticket image
                                Image(systemName: "ticket.fill")
                                    .foregroundColor(.primary)
                                // Event tickets
                                Text("Tickets")
                                    .foregroundColor(.primary)
                            }
                            .fontWeight(.bold)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .font(.subheadline)
                        }
                        // Event reminder button
                        Button(action: {
                            addReminderForEvent(event)
                        }) {
                            // HStack button
                            HStack {
                                // Event reminder image
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.primary)
                                // Event set reminder
                                Text("Set Reminder")
                                    .foregroundColor(.primary)
                            }
                            .fontWeight(.bold)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .font(.subheadline)
                        }
                    }
                }
                // Event topics title
                Text("Topics")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                // HStack
                HStack {
                    // ForEach event technologies
                    ForEach(event.technologies.split(separator: ",").map(String.init), id: \.self) { technology in
                        Text(technology.trimmingCharacters(in: .whitespaces))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .font(.subheadline)
                    }
                }
                .padding(.bottom, 5)
                // Event about title
                Text("About")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                // Event about
                Text(event.about)
                    .font(.body)
                    .padding(.top, 5)
                // Contact Button
                Button(action: {
                }) {
                    HStack {
                        // Event email image
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.primary)
                        // Event email
                        Text(event.email)
                            .foregroundColor(.primary)
                            .font(.caption)
                    }
                    .fontWeight(.bold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .font(.subheadline)
                }
                // Spacer
                Spacer()
            }
            .padding()
        }
        // navigationBarTitle
        .navigationBarTitle("Event Details", displayMode: .inline)
        .background(Color(.systemBackground))
    }
    
    // Event format date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Event add reminder
    private func addReminderForEvent(_ event: Event) {
        eventStore.requestFullAccessToReminders { granted, error in
            if granted && error == nil {
                let reminder = EKReminder(eventStore: self.eventStore)
                reminder.title = event.name
                reminder.notes = "Reminder for \(event.name) at \(event.venue)"
                reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                
                let alarmDate = event.date
                let alarm = EKAlarm(absoluteDate: alarmDate)
                reminder.addAlarm(alarm)
                
                do {
                    try self.eventStore.save(reminder, commit: true)
                    DispatchQueue.main.async {
                        // Handle UI update or confirmation
                    }
                } catch let error {
                    print("Reminder failed with error \(error.localizedDescription)")
                    // Handle failure in UI
                }
            } else {
                print("Access to reminders denied or error: \(String(describing: error))")
                // Handle the case where permission is denied
            }
        }
    }
    
}
