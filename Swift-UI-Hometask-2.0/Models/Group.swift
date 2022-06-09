//
//  Group.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 19.05.2022.
//

import Foundation


//MARK: We have taken this JSON responce directly here from output
/*"is_member" : 0,
 "id" : 78045913,
 "photo_100" : "https:\/\/sun9-88.userapi.com\/s\/v1\/if2\/tuwJ9zqJHr4A3snNWp56gRYUJvkxyCSC59dD72-TKonM3sqYWKCDm2yS7Vsk0gVTWpJwrX9DWskP4K7HdJgEC0wi.jpg?size=100x100&quality=96&crop=41,75,287,287&ava=1",
 "is_advertiser" : 0,
 "is_admin" : 0,
 "photo_50" : "https:\/\/sun9-88.userapi.com\/s\/v1\/if2\/RukF8FE5GDr72lBQ18sRWLKBfOO1xNyu1_bRsi-oO8FQMWRTaOW_rlesdkJd0vNLXVXxYfJnRvqQtcQRhLrCosP_.jpg?size=50x50&quality=96&crop=41,75,287,287&ava=1",
 "photo_200" : "https:\/\/sun9-88.userapi.com\/s\/v1\/if2\/uZxNsV1JGt2CXbkqug-kQHKFPaOJWID1K0HLMdESjCr8ll5C5nt-2A3qQK5A6PmIl2xsXm5SRic3ninz-Xz0_I_Y.jpg?size=200x200&quality=96&crop=41,75,287,287&ava=1",
 "type" : "group",
 "screen_name" : "davydov_official",
 "name" : "Константин Давыдов | ОФИЦИАЛЬНАЯ ГРУППА АКТЕРА",
 "is_closed" : 0
 
 }
 */


// MARK: - GroupsContainer
struct GroupsContainer: Codable {
    let response: GroupsResponse
}

//MARK: - Response
struct GroupsResponse: Codable {
    let count: Int
    let items: [GroupAPI]
}

/// Friend is our replacement for Item from the example
struct GroupAPI: Codable, Identifiable {
    let id: Int
    let name: String
    let photo100: String
    let screen_name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case photo100 = "photo_100"
        case screen_name = "screen_name"
    }
    
}


