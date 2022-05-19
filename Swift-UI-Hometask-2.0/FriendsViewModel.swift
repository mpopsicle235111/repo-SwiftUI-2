//  FriendsViewModel.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 18.05.2022.
//

import SwiftUI

class FriendsViewModel: ObservableObject {
    
    let api: FriendsService
    
    @Published var friendsAPI: [FriendAPI] = []
    
    init(api: FriendsService) {
        self.api = api
    }
    
    public func fetch() {
        api.getFriends { [weak self] friendsAPI in
            guard let self = self else { return }
            self.friendsAPI = friendsAPI       }
    }
}

