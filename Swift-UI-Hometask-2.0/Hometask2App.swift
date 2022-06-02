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

class ShowGroupsState: ObservableObject {
    @Published var shouldShowGroupsView: Bool
    
    init(shouldShowGroupsView: Bool) {
        self.shouldShowGroupsView = shouldShowGroupsView
    }
}

class ShowPhotosState: ObservableObject {
    @Published var shouldShowPhotosView: Bool
    
    init(shouldShowPhotosView: Bool) {
        self.shouldShowPhotosView = shouldShowPhotosView
    }
}

@main
struct Hometask2App: App {
    @ObservedObject var appState = AppState(isUserLoggedIn: false)
    @ObservedObject var showFriendsState = ShowFriendsState    (shouldShowFriendsView: false)
    @ObservedObject var showGroupsState = ShowGroupsState    (shouldShowGroupsView: false)
    @State var isUserLoggedIn: Bool = true
    
    var body: some Scene {
        WindowGroup {
          
            if appState.isUserLoggedIn {
                UserView(groups: groupsData, friends: friendsData)
                    .environmentObject(appState)
                
                
            } else {
                //LoginAndPasswordView()
                    //.environmentObject(appState)
                TemporaryView(isUserLoggedIn: $isUserLoggedIn)
                    .environmentObject(appState)
            }
    
            
        }

    }
}
