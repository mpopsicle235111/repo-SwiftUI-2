//
//  ContainerView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 27.04.2022.
//
//Container View holds a state that allows LoginAndPasswordView to go to the UserView

import SwiftUI

struct ContainerView: View {
    @State private var shouldShowMainView: Bool = false
    @ObservedObject var session = Session.shared
    @State private var currentIndex = 0
    
    var body: some View {
        NavigationView {
            HStack {
               // LoginAndPasswordView(isUserLoggedIn: $shouldShowMainView)
                NavigationLink(destination: BasicView(selectedIndex: $currentIndex)) {
                        EmptyView()
                }
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
