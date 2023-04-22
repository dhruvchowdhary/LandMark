//
//  LargeButton.swift
//  Compass
//
//  Created by Rohan Taneja on 4/22/23.
//

import SwiftUI

struct LargeButton: View {
    var text = "Download files"

    var body: some View {
        Button(action: {}) {
            Text(text)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(12)
    }
}
