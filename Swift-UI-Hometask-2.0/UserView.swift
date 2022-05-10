//
//  UserView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 27.04.2022.
//  Navigation as per Paul Hudson: https://youtu.be/nA6Jo6YnL9g

import SwiftUI

struct UserView: View {
    @EnvironmentObject var appState: AppState
    @State private var isShowingFriendsView = false
    @State private var isShowingGroupsView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Jack-img")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                Text("Welcome, Jack Abramoff.")
                    
                NavigationLink("", destination: FriendsView(), isActive: $isShowingFriendsView)
                
                Button("Tap to see your friends") {
                    self.isShowingFriendsView = true
                }
                .font(.body)
                //.textFieldStyle(OvalTextFieldStyle())
                //.foregroundColor(.white)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                NavigationLink("", destination: GroupsView(), isActive: $isShowingGroupsView)
                    
                Button("Tap to see your groups") {
                        self.isShowingGroupsView = true
                }
                .font(.body)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Button("Exit App") {
                                appState.isUserLoggedIn = false
                }
                .font(.body)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
            } //VStack ends here
            .navigationBarTitle("The Main Page", displayMode: .inline)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
