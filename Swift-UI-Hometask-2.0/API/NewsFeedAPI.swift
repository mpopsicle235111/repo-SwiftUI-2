//
//  NewsFeedAPI.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//

import Foundation
import Alamofire
import SwiftyJSON //This is necessary for JSON variable


/// This is a temporary plug
//struct NewsItem {
//   var name = "Britney shaved her head"
//   }

//This is VK API's request structure
//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

class NewsFeedAPI {
    
    let baseURL = "https://api.vk.com/method"
    
    //@ObservedObject var session = Session.shared
    
    //Added for Infinite Scrolling Pattern
    var nextFrom = ""
    
    //func newsRequest (completion: @escaping ([ModelNews] , [PhotoPost]) -> ()) {
    //Modified for pull-to refresh:
    func newsRequest (startTime: Int, startFrom: String = "", completion: @escaping ([ModelNews] , [PhotoPost] , (String)) -> ()) {
        let method = "/newsfeed.get"
        let url = baseURL + method
        let params : [String: Any] = ["user_id": Session.shared.userId,
                                      "access_token": Session.shared.token,
                                      "filters": "post",
                                      //We just need news posts
                                      //"filters": "post , photo , photo_tag , wall_photo , friend , note , audio , video",
                                      
                                      
                                      //Added for Pull-to-refresh
                                      "start_time": startFrom,
                                      
                                      "return_banned":"1",
                                      "max_photos": "100",
                                      "source_ids": "groups , pages, following",
                                      "fields":"name , photo_100 , first_name , last_name",
                                      "count" : "100",
                                      "v": "5.131"
        ]
        //print("Url")
        //print("===========")
        //print(url)
        //print("===========")
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else { return}
            
            //This is necessary for parsing, removed for speed
            //print(response.data?.prettyJSON)
            
            let decoder = JSONDecoder()
            
            let dispatchGroup = DispatchGroup()
            
            var arrayNews: [ItemNews] = []
            var arrayGroups: [Groups] = []
            var arrayProfiles:[Profiles] = []
            let newsItem = JSON(data)["response"]["items"].arrayValue
            let groupNews = JSON(data)["response"]["groups"].arrayValue
            let profileNews = JSON(data)["response"]["profiles"].arrayValue
            
            //Added for pull-to-request
            let nextFrom = JSON(data)["response"]["next_from"].stringValue
            
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index , items) in newsItem.enumerated() {
                    do {
                        
                        let decodeItem = try decoder.decode(ItemNews.self, from: items.rawData())
                        arrayNews.append(decodeItem)
                        
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, groups) in groupNews.enumerated() {
                    
                    do {
                        let decodeGroup = try decoder.decode(Groups.self, from: groups.rawData())
                        arrayGroups.append(decodeGroup)
                        
                    } catch (let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, profiles) in profileNews.enumerated() {
                    do {
                        let profiles = try decoder.decode(Profiles.self, from: profiles.rawData())
                        arrayProfiles.append(profiles)
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                
                var resp: [ModelNews] = []
                var photoPost: [PhotoPost] = []
                
                for item in arrayNews {
                    if item.sourceID! < 0  {
                        
                        let group = arrayGroups.first{-($0.id!) == item.sourceID}
                        
                        var resultModel = ModelNews(source_ID: item.sourceID, text: item.text, photo_100: group?.photo100, name: group?.name ?? "no name", date: item.date, like: item.likes?.count, comments: item.comments?.count, reposts: item.reposts?.count, views: item.views?.count)
                        
                        
                        item.attachments?.forEach {
                            
                            guard let post = $0.photo else {return}
                            photoPost.append(post)
                            //This printout was for test purposes, removed 4 speed
                            //print(post)
                            
                            resultModel.photoSizes = post.sizes
                        }
                        
                        
                        
                        resp.append(resultModel)
                        
                    }
                    
                    else {
                        
                        let a = arrayProfiles.first{$0.id == item.sourceID}
                        
                        let response = ModelNews(source_ID: item.sourceID, text: item.text, photo_100: a?.photo_100!, name: a?.lastName ?? "no name1", date: item.date, like: item.likes?.count, comments: item.comments?.count, reposts: item.reposts?.count, views: item.views?.count, photoUrl: nil, photoSizes: nil)
                        
                        item.attachments?.forEach({
                            guard let post = $0.photo else {return}
                            photoPost.append(post)
                        })
                        
                        resp.append(response)
                    }
                }
                //Old version
                //completion (resp , photoPost)
                //print("resp:")
                //print("++++++++++++++")
                //print(resp)
                //print("photoPost:")
                //print("++++++++++++++")
                //print(photoPost)
                //print("++++++++++++++")
                //print("nextFrom:")
                //print(nextFrom)
                //print("++++++++++++++")
                //Modified for Infinite Scrolling Pattern
                completion (resp , photoPost, nextFrom)
                
            }
        }
    }
}
