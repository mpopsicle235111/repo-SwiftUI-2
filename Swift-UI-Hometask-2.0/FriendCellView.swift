//
//  FriendCellView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 19.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendCellView: View {
    
    var friendAPI: FriendAPI
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: friendAPI.photo100))
                    .resizable() // Resizable like SwiftUI.Image
                    // Supports ViewBuilder as well
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                    
            
                VStack(alignment: .leading) {
                    Text("\((friendAPI.lastName )) \(friendAPI.firstName )")
                    Text(friendAPI.domain)
                        .foregroundColor(.gray)
                    
                }
            
        }
    }
}

struct FriendCellView_Previews: PreviewProvider {
    var friendsAPI: FriendsAPI
    static var previews: some View {
        FriendsView(viewModel: FriendsViewModel(api: FriendsAPI()))
    }
}
