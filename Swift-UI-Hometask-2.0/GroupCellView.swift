//
//  GroupCellView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 19.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct GroupCellView: View {
    
    var groupAPI: GroupAPI
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: groupAPI.photo100))
                    .resizable() // Resizable like SwiftUI.Image
                    // Supports ViewBuilder as well
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                    
            
                VStack(alignment: .leading) {
                    Text(groupAPI.name)
                    Text(groupAPI.screen_name)
                        .foregroundColor(.gray)
                    
                }
            
        }
    }
}

struct GroupCellView_Previews: PreviewProvider {
    var groupsAPI: GroupsAPI
    static var previews: some View {
        GroupsView(viewModel: GroupsViewModel(api: GroupsAPI()))
    }
}

