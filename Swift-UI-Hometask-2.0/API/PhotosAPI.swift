//
//  PhotosAPI.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 31.05.2022.
//

import Foundation
import Alamofire
import SwiftUI

//This is VK API's request structure
//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

protocol PhotosService {
    //func getPhotos(completion: @escaping ([PhotoAPI])->())
    //Modified to get friends' photos
    func getPhotos(userId: Int, completion: @escaping ([PhotoAPI])->())
}

class PhotosAPI: PhotosService {

    let baseUrl = "https://api.vk.com/method"
    let userId = Session.shared.userId
    let accessToken = Session.shared.token
    let version = "5.131"

    ///Through completion handler it transfers closure
    ///which receives Photos array, it is a container, where
    ///the Photos array is packed into
    //Modified to get friends' photos
    //func getPhotos(completion: @escaping([PhotoAPI])->()) {
    func getPhotos(userId: Int, completion: @escaping([PhotoAPI])->()) {
       
           //Modified to get friends' photos
           //let path = "/photos.get"
           let path = "/photos.getAll"
           let url = baseUrl + path

            //Params is a dictionary
           var photoParams: [String: String] = [
                //Modified to get friends' photos
                //"user_id": ("\(userId)"),
                "owner_id": ("\(userId)"),
                "album_id": "wall",
                "count": "20",
                "access_token": accessToken,
                "v": version
                ]

            
           //We send a request to server using Alamofire
            AF.request(url, method: .get, parameters: photoParams).responseJSON { response in

               //print(response.result)
               print(response.data?.prettyJSON)
               //Then put into quicktype.io

               guard let jsonData = response.data else { return }
               
               
               ///MARK: THIS IS QUICKTYPE.IO auto parsing
               let photosContainer = try? JSONDecoder().decode(PhotosContainer.self, from: jsonData)
       
            
            guard let photos = photosContainer?.response?.items else { return }
            
               completion(photos)
        
            }
             
            }
    }

