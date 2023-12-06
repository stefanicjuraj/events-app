//
//  ListView.swift
//  Events
//
//  Created by Juraj Stefanic on 01.12.2023..
//

import SwiftUI

// ListView
struct ListView: View {
    
    // Firebase Firestore Manager
    @EnvironmentObject var firestoreManager: FirestoreManager
    // Search text state
    @State private var searchText = ""
    // Sort by remaining days
    @State private var isSortedByRemainingDays = false
    
    // Event format date - "Jan 01 2024, Saturday"
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy, EEEE"
        return formatter.string(from: date)
    }
    
    // Days remaining until event countdown
    func daysRemaining(until date: Date) -> Int {
        let calendar = Calendar.current
        let startOfCurrentDay = calendar.startOfDay(for: Date())
        let startOfEventDay = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfCurrentDay, to: startOfEventDay)
        return components.day ?? 0
    }
    
    // body
    var body: some View {
        // NavigationStack
        NavigationStack {
            // List
            List {
                HStack {
                    // Search events
                    TextField("Search Events", text: $searchText)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .cornerRadius(30)
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 0.5)
                        )
                    // Sort by remaining days
                    Button(action: {
                        isSortedByRemainingDays.toggle()
                    }) {
                        Image(systemName: isSortedByRemainingDays ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle")
                    }
                    .padding(.trailing, 10)
                }
                // ForEach event id
                ForEach(filteredEvents, id: \.id) { event in
                    NavigationLink(value: event) {
                        HStack {
                            VStack(alignment: .leading) {
                                // Event name
                                Text(event.name)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.top, 8)
                                // Event description
                                Text(event.description)
                                    .font(.footnote)
                                    .padding(.top, 4)
                                // Event days remaining and Attendees
                                HStack(spacing: 6) {
                                    Image(systemName: "person.2.fill")
                                        .font(.subheadline)
                                        .padding(.top, 8)
                                    Text("\(event.attendees) attendees")
                                        .font(.subheadline)
                                        .padding(.top, 8)
                                }
                                HStack(spacing: 6) {
                                    Image(systemName: "calendar")
                                        .font(.subheadline)
                                        .padding(.top, 4)
                                    Text("\(daysRemaining(until: event.date)) days remaining")
                                        .font(.subheadline)
                                        .padding(.top, 4)
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.vertical, 5)
                }
                
            }
            // navigationTitle
            .navigationTitle("IT Events in Zagreb")
            .listStyle(PlainListStyle())
            .navigationDestination(for: Event.self) { event in
                EventView(event: event)
            }
        }
    }
    
    // Computed property to filter events based on search text
    var filteredEvents: [Event] {
        var events = firestoreManager.events.filter { event in
            searchText.isEmpty || event.name.lowercased().contains(searchText.lowercased())
        }
        // isSortedByRemainingDays
        if isSortedByRemainingDays {
            events.sort { daysRemaining(until: $0.date) < daysRemaining(until: $1.date) }
        }
        return events
    }
    
}

// Extension Event : Hashable
extension Event: Hashable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
    // hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Preview
#Preview {
    ListView()
}
