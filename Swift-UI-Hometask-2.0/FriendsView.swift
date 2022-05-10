//
//  FriendsView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 02.05.2022.
//

import SwiftUI

struct FriendsView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var showFriendsState: ShowFriendsState

    
    var body: some View {
        Text("A list of Jack's Friends")
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
