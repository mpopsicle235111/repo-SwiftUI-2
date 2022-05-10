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
    Group(name: "We Hate Dogs", headline: "Public group", imageName: "WHDogs-img")
    
]
