import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentScreen: Screen = .homeScreen
}

enum Screen {
    case homeScreen
    case circleScreen
}
