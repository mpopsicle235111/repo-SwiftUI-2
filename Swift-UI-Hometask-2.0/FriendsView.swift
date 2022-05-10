//
//  FriendsView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 02.05.2022.
//  Table created as per: https://habr.com/ru/post/461645/
//  Navigation as per: https://www.hackingwithswift.com/quick-start/swiftui/how-to-push-a-new-view-when-a-list-row-is-tapped

import SwiftUI

struct FriendsView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var showFriendsState: ShowFriendsState
    
    var friends: [Friend]
    
    var body: some View {
        NavigationView {
            List(friends) { friend in
                NavigationLink(destination: PhotoGridView()) {
                    
                    HStack {
                            Image(friend.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                            VStack(alignment: .leading) {
                                Text(friend.name)
                                Text(friend.headline)
                                    .foregroundColor(.gray)
                                
                            }
                    }
                }
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(friends: friendsData)
    }
}
