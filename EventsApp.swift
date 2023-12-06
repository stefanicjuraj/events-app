//
//  EventsApp.swift
//  Events
//
//  Created by Juraj Stefanic on 01.12.2023..
//

import SwiftUI
import FirebaseCore
import Firebase

// EventsApp
@main
struct EventsApp: App {
    
    // FirestoreManager
    @StateObject var firestoreManager = FirestoreManager()
    // isLoading
    @State private var isLoading = true
    
    // Init
    init() {
        FirebaseApp.configure()
    }
    
    // body
    var body: some Scene {
        // WindowGroup
        WindowGroup {
            // isLoading
            if isLoading {
                // LoadingView
                LoadingView()
                    .onAppear {
                        // Simulate loading task
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                        }
                    }
            } else {
                // ListView
                ListView()
                    .environmentObject(firestoreManager)
            } // ListView
        } // WindowGroup
    } // body
    
} // EventsApp

