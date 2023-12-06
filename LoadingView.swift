//
//  LoadingView.swift
//  Events
//
//  Created by Juraj Stefanic on 01.12.2023..
//

import SwiftUI

// LoadingView
struct LoadingView: View {
    // body
    var body: some View {
        // VStack
        VStack {
            LoadingImageView(imageName: "logo")
            Text("Loading...")
                .font(.caption)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // body
} // LoadingView

// LoadingImageView
struct LoadingImageView: View {
    // imageName
    let imageName: String
    // isLoading
    @State private var isLoading = true

    // body
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            }
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear { self.isLoading = false }
        }
        .frame(width: 350, height: 350)
    } // body
    
} // LoadingImageView
