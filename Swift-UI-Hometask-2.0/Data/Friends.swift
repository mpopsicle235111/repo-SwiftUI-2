//
//  Friends.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 10.05.2022.
//

import SwiftUI

struct Friend: Identifiable {
    var id = UUID()
    var name: String
    var headline: String
    
    var imageName: String
}


let friendsData = [
    Friend(name: "Beth Garner", headline: "Psychologist", imageName: "Beth-img"),
    Friend(name: "Catherine Tramell", headline: "Writer/Socialite", imageName: "Catherine-img"),
    Friend(name: "Gus Moran", headline: "Policeman", imageName: "Gus-img"),
    Friend(name: "Johnny Boz", headline: "Musician/Playboy", imageName: "Johnny-img"),
    Friend(name: "Nick Curran", headline: "Policeman/Shooter", imageName: "Nick-img"),
    Friend(name: "Roxy Hardy", headline: "Lover/Driver", imageName: "Roxy-img")
    
]
