//
//  ContentView.swift
//  Events
//
//  Created by Juraj Stefanic on 01.12.2023..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    // body
    var body: some View {
        VStack {
            // List
            List(firestoreManager.events, id: \.id) { event in
                // HStack
                HStack {
                    // Event name
                    Text("Event: \(event.name)")
                }
            }
        }
    } // body
} // ContentView

// ContentView_Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // ContentView
        ContentView()
            .environmentObject(FirestoreManager())
    } // previews
} //ContentView_Previews
