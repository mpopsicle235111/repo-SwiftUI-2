//
//  TemporaryView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 17.05.2022.
//

import SwiftUI

struct TemporaryView: View {
    @Binding var isUserLoggedIn: Bool
    @EnvironmentObject var appState: AppState
    var body: some View {
        AuthView {
          isUserLoggedIn = true
          appState.isUserLoggedIn = true;
        }
    }
}

struct TemporaryView_Previews: PreviewProvider {
    static var previews: some View {
        TemporaryView(isUserLoggedIn: .constant(true))
    }
}
