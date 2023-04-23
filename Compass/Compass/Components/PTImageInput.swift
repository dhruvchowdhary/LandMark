//
//  PTImageInput.swift
//  Compass
//
//  Created by Dhruv Chowdhary on 4/22/23.
//

import SwiftUI

struct PTImageInput: View {
    @Binding var inputText: String
    @Binding var showPtImages: [Bool]
    @Binding var nextImageToShowIndex: Int
    let image: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .scaleEffect(1.5)
            TextField("Enter text here", text: $inputText)
                    .frame(width: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal, 15)
            Button(action: {
                nextImageToShowIndex = 0
                showPtImages[nextImageToShowIndex] = false
                UserDefaults.standard.set(showPtImages, forKey: "showPtImages")
                UserDefaults.standard.set(nextImageToShowIndex, forKey: "nextImageToShowIndex")
            }) {
            Image("trash")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.2)
            }
        }
        .padding()
    }
}

