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
    @State private var showPtImages = UserDefaults.standard.array(forKey: "showPtImages") ?? [false, false, false, false, false, false, false]
    @State private var nextImageToShowIndex = UserDefaults.standard.integer(forKey: "nextImageToShowIndex") ?? 0
    @State private var inputText = ""

    
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
                    if showPtImages[0] as! Bool {
                                            Image("pt0")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -115-17-55/2)
                                                .rotationEffect(Angle(degrees: 0))
                                                .offset(x: 0, y: 17+55/2)
                                        }
                    if showPtImages[1] as! Bool {
                                            Image("pt1")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -115-17-55/2)
                                                .rotationEffect(Angle(degrees: 20))
                                                .offset(x: 0, y: 17+55/2)
                                        }
                    if showPtImages[2] as! Bool {
                                            Image("pt2")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -115-17-55/2)
                                                .rotationEffect(Angle(degrees: 50))
                                                .offset(x: 0, y: 17+55/2)
                                        }
                    if showPtImages[3] as! Bool {
                                            Image("pt3")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -115-17-55/2)
                                                .rotationEffect(Angle(degrees: 60))
                                                .offset(x: 0, y: 17+55/2)
                                        }
                    if showPtImages[4] as! Bool {
                                            Image("pt4")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -115-17-55/2)
                                                .rotationEffect(Angle(degrees: 120))
                                                .offset(x: 0, y: 17+55/2)
                                        }
                    if showPtImages[5] as! Bool {
                                            Image("pt5")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -115-17-55/2)
                                                .rotationEffect(Angle(degrees: 200))
                                                .offset(x: 0, y: 17+55/2)
                                        }
                    if showPtImages[6] as! Bool {
                                            Image("pt6")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.1)
                                                .offset(x: 0, y: -115-17-55/2)
                                                .rotationEffect(Angle(degrees: 300))
                                                .offset(x: 0, y: 17+55/2)
                                        }
                }
                Button(action: {
                    if nextImageToShowIndex < showPtImages.count {
                                showPtImages[nextImageToShowIndex] = true
                                nextImageToShowIndex += 1
                                UserDefaults.standard.set(showPtImages, forKey: "showPtImages")
                                UserDefaults.standard.set(nextImageToShowIndex, forKey: "nextImageToShowIndex")
                            } else {
                                print("Error: index out of bounds")
                            }
                                }, label: {
                                    Text("Set Location")
                                        .font(.system(size: 30))
                                        .foregroundColor(Color.black)
                                })
                                .padding()
                                .background(Color(#colorLiteral(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0)))
                                .cornerRadius(15)
                                .offset(y: 280)
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
                    Text("Saved Locations")
                        .font(.title)
                        .padding()
                    HStack {
                        Image("pt0")
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
                        Image("trash")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.2)
                    }
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
