//
//  GroupsView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 02.05.2022.
//  Table created as per: https://habr.com/ru/post/461645/

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var showGroupsState: ShowGroupsState
    @ObservedObject var viewModel: GroupsViewModel
    
    init(viewModel: GroupsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
            List(viewModel.groupsAPI.sorted(by: { $0.name < $1.name})) { groupAPI in
                    NavigationLink(destination: PhotoGridView()) {

                    GroupCellView(groupAPI: groupAPI)
                    }
            
                }
            .onAppear { viewModel.fetch() }
         }
         
    }
    
    




struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView(viewModel: GroupsViewModel(api: GroupsAPI()))
    }
}
