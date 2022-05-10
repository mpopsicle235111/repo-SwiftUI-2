//
//  GroupsView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 02.05.2022.
//  Table created as per: https://habr.com/ru/post/461645/

import SwiftUI

struct GroupsView: View {
    var groups: [Group]
    
    var body: some View {
       
        List(groups) { group in
            HStack {
                    Image(group.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(group.name)
                        Text(group.headline)
                            .foregroundColor(.gray)
                    }
            }
        }
    }
}

    
struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(groups: groupsData)
    }
}
