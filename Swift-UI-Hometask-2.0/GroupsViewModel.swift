//
//  GroupsViewModel.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 19.05.2022.
//

import SwiftUI

class GroupsViewModel: ObservableObject {
    
    let api: GroupsService
    
    @Published var groupsAPI: [GroupAPI] = []
    
    init(api: GroupsService) {
        self.api = api
    }
    
    func fetch() {
        api.getGroups { [weak self] groupsAPI in
            guard let self = self else { return }
            self.groupsAPI = groupsAPI       }
    }
}
