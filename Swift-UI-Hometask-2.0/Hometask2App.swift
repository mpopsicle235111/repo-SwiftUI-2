//
//  Hometask2App.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 02.05.2022.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isUserLoggedIn: Bool
    
    init(isUserLoggedIn: Bool) {
        self.isUserLoggedIn = isUserLoggedIn
    }
}

class ShowFriendsState: ObservableObject {
    @Published var shouldShowFriendsView: Bool
    
    init(shouldShowFriendsView: Bool) {
        self.shouldShowFriendsView = shouldShowFriendsView
    }
}

@main
struct Hometask2App: App {
    @ObservedObject var appState = AppState(isUserLoggedIn: false)
    @ObservedObject var showFriendsState = ShowFriendsState    (shouldShowFriendsView: false)
    
    var body: some Scene {
        WindowGroup {
          
            if appState.isUserLoggedIn {
                UserView()
                    .environmentObject(appState)
                
                
            } else {
                LoginAndPasswordView()
                    .environmentObject(appState)
            }
    
            
        }

    }
}
