//
//  FriendsAPI.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 18.05.2022.
//

import Foundation
import Alamofire
import SwiftUI

/// Temporary plug
//struct Friend {
//    var name = "Bobik"
//}

//This is VK API's request structure
//We access binary
//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

protocol FriendsService {
    func getFriends(completion: @escaping ([FriendAPI])->())
}


class FriendsAPI: FriendsService {
    
    @ObservedObject var session = Session.shared
    
    let baseUrl = "https://api.vk.com/method"
    let userId = Session.shared.userId
    let accessToken = Session.shared.token
    let version = "5.131"
    
    /// Through completion handler it transfers closure,
    ///which receives Friend array
    func getFriends(completion: @escaping([FriendAPI])->()) {
        
        let path = "/friends.get"
        let url = baseUrl + path
        
        //Params is a dictionary
        let params: [String: String] = [
            "user_id": userId,
            "order": "name",  //The order, in which results are appearing
            "count": "5",
            "fields": "photo_100, photo_50, city, domain",
            "access_token": accessToken,     //"domain" here means User ID
            "v": version
        ]
        //We send a request to server using Alamofire
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            
            //print(response.result)
            
            print(response.data?.prettyJSON)
            //We unpack optional binary here
            guard let jsonData = response.data else { return }
            
            //In this variant "try?" can not throw errors
            //So when some fields are missing,
            //the whole table displays nothing
            //let friendsContainer  = try?  JSONDecoder().decode(FriendsContainer.self,
            //    from: jsonData)
            
            //So we need a try/catch block here:
            do {
                let friendsContainer  = try  JSONDecoder().decode(FriendsContainer.self, from: jsonData)
                let friendsAPI = friendsContainer.response.items
                print(friendsAPI)
                completion(friendsAPI)
            } catch {
                print(error)
            }
        }
        
        
        
        
        
    }
    
  
    
}
