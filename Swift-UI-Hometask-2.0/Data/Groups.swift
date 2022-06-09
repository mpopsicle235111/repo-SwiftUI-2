//
//  Groups.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 02.05.2022.
//

import SwiftUI

struct Group: Identifiable {
    var id = UUID()
    var name: String
    var headline: String
    
    var imageName: String
}


let groupsData = [
    Group(name: "We Love Cats", headline: "Public group", imageName: "WLCats-img"),
    Group(name: "We Love Britney Spears", headline: "Private group", imageName: "WLBritney-img"),
    Group(name: "We Love Christina Aguilera", headline: "Private group", imageName: "WLChristina-img"),
    Group(name: "We Love McDonalds", headline: "Public group", imageName: "WLMcdonalds-img"),
    Group(name: "We Love Dogs", headline: "Private group", imageName: "WLDogs-img"),
    Group(name: "We Hate Dogs", headline: "Public group", imageName: "WHDogs-img"),
    Group(name: "We Love Beth Garner", headline: "Public group", imageName: "Beth-img"),
    Group(name: "We Love Catherine Tramell", headline: "Public group", imageName: "Catherine-img"),
    Group(name: "We Love Gus Moran", headline: "Public group", imageName: "Gus-img"),
    Group(name: "We Love Johnny Boz", headline: "Public group", imageName: "Johnny-img"),
    Group(name: "We Love Nick Curran", headline: "Public group", imageName: "Nick-img"),
    Group(name: "We Love Roxy Hardy", headline: "Public group", imageName: "Roxy-img"),
    Group(name: "We Love Background", headline: "Private group", imageName: "background1"),
    Group(name: "We Love David Usher", headline: "Private group", imageName: "GrayLayer-Small-GHeart-img")
    
]
