//
//  Friend.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 18.05.2022.
//


import Foundation

// MARK: - FriendsContainer
struct FriendsContainer: Codable {
    let response: FriendsResponse
}

//MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [FriendAPI]
}

/// Friend is our replacement for Item from the example
struct FriendAPI: Codable, Identifiable {
    let canAccessClosed: Bool?   //Here we make optional something that may
    let domain: String           //be missing, like friend name
    let city: City?            //etc.
    let id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let trackCode: String?
    let isClosed: Bool?
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case domain, city, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
    
}

//MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}
