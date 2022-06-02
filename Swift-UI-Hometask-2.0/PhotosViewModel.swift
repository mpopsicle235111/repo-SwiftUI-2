//
//  PhotosViewModel.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 31.05.2022.
//

import SwiftUI

class PhotosViewModel: ObservableObject {
    
    let api: PhotosService
    //Added to get other people's photos:
    let friend: FriendAPI
    
    @Published var photosAPI: [PhotoAPI] = []
    
    //init(api: PhotosService) {
    //Modified to get other people's photos:
    init(friend: FriendAPI, api: PhotosService) {
        self.api = api
        //Added to get other people's photos:
        self.friend = friend
    }
    
    func fetch() {
        //api.getPhotos { [weak self] photosAPI in
        //Modified to get other people's photos:
        api.getPhotos(userId: friend.id) { [weak self] photosAPI in
            guard let self = self else { return }
            self.photosAPI = photosAPI       }
            print("FRIEND ID")
            print(friend.id)
            print("++++++++++++++")
            print(friend)
            print("++++++++++++")
    }
}

