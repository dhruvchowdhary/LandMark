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
    @Binding var tabBarHeight: CGFloat
    var index: Int
    //let image: String
    
    var body: some View {
        HStack {
            Image("pt\(index)")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.2)
            TextField("Enter text here", text: $inputText)
                .frame(width: 200, height: 10)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal, 15)
            Button(action: {
                nextImageToShowIndex = index
                showPtImages[nextImageToShowIndex] = false
                UserDefaults.standard.set(showPtImages, forKey: "showPtImages")
                UserDefaults.standard.set(nextImageToShowIndex, forKey: "nextImageToShowIndex")
                tabBarHeight -= 80
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

