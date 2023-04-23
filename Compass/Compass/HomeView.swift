//
//  HomeView.swift
//  Compass
//
//  Created by Dhruv Chowdhary on 4/22/23.
//

import SwiftUI

struct HomeView: View {
    @State private var tabBarHeight: CGFloat = 0
    @State private var tabBarOffset: CGFloat = UIScreen.main.bounds.height * 0.55 // Initial position
    
    var body: some View {
        ZStack {
            ZStack {
                Image("mountain-background1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                ZStack {
                    Image("compass")
                        .resizable()
                        .scaledToFit()
                    Image("needle1")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.2)
                        .rotationEffect(Angle(degrees: 1))
                        .offset(x: 0, y: 42.5)
                    Image("pt1")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.1)
                        .offset(x: 0, y: -115-17-55/2)
                        .rotationEffect(Angle(degrees: 80))
                        .offset(x: 0, y: 17+55/2)
                }
            }
            .animation(.easeInOut(duration: 0.2))
            .offset(y: tabBarOffset - UIScreen.main.bounds.height * 0.55) // To adjust the view offset
            
            VStack {
                VStack {
                    Rectangle()
                        .frame(width: 60, height: 5)
                        .cornerRadius(2.5)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                    Text("Tab Bar Content")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: tabBarHeight, alignment: .center)
                .background(Color.white)
                .cornerRadius(15)
                .offset(y: tabBarOffset)
                .gesture(DragGesture().onChanged { value in
                    tabBarOffset = max(value.startLocation.y + value.translation.height, UIScreen.main.bounds.height * 0.45 - tabBarHeight)
                }.onEnded { value in
                    tabBarOffset = value.predictedEndLocation.y > UIScreen.main.bounds.height * 0.7 ? UIScreen.main.bounds.height * 0.55 : UIScreen.main.bounds.height * 0.45 - tabBarHeight
                })
            }
            .onAppear {
                tabBarHeight = UIScreen.main.bounds.height * 0.2
            }
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
