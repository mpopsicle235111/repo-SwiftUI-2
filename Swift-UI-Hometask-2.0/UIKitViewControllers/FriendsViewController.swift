//
//  FriendsViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//

//
//  FriendsViewController.swift
//  Lesson 2
//
//  Created by Anton Lebedev on 14.12.2021.
//

import UIKit
import SDWebImage

class FriendsViewController: UITableViewController {
    
   
    var friend: FriendAPI
    
    private var friendsAPI = FriendsAPI()
    private var friends: [FriendAPI] = []
    var photosAPI: [PhotoAPI] = []
    
    init(friend: FriendAPI) {
        //Added to get other people's photos:
        self.friend = friend
        
       
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Let us register some system cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        friendsAPI.getFriends{ [weak self] friends in
            guard let self = self else { return }
            
            self.friends = friends
            self.tableView.reloadData()
        
        }
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let friend = friends[indexPath.row]
        
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        
        //We use SDWebImage Library to add picture into the cell
        //Setting placeholder image solves the cell image display problem
        if let url = URL(string: friend.photo100) {
            cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "GrayLayer-Small-Heart-img"), completed: nil)
            
        }
        
        return cell
    }
    
    //If the friend is selected - this triggers a switch to PhotoCollectionVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showPhotoCollectionViewController()
    }
    
    func showPhotoCollectionViewController() {
       let destination = FriendPhotoCollectionViewController(friend: friend, api: PhotosAPI())
        destination.friend = self.friend
        show(destination, sender: self)
    }
}

