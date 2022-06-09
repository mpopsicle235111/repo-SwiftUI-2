//
//  GroupsViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//

import UIKit
import SDWebImage



final class GroupsViewController: UITableViewController {
    
    private var groupsAPI = GroupsAPI()
    var group: GroupAPI
    
    //This is used for Internet fetching
    private var groups: [GroupAPI] = []
    
    init(group: GroupAPI) {
        //Added to get other people's photos:
        self.group = group
        
       
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //These two are used with Realm
    //Token refreshes the table instead of plain old self.tableView.reloadData()
    //private var groups: Results<GroupDAO>?
    //private var groupsToken: NotificationToken?
    
    //This is for Firebase
    //let authService = Auth.auth()
    
    //This is for Firebase
    //This is a reference to container within Firebase
    //Which is a singletone
    //let ref = Database.database().reference(withPath: "Groups")
    
    
    //This is to fetch groups from Internet (also necessary for Firebase - because initially Firebase gets groups from Internet)
    //This is for Firebase
    //var groups: [GroupFirebase] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //We register system cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        
        
        //The controller is holding GroupsAPI
        //Inside GroupsAPI the closure catches controller through self
        //So we need weak self to avoid retain cycle
        groupsAPI.getGroups { [weak self] groups in
            //But inside we make groups strong again)))
            guard let self = self else { return }
            
            //This is used when we fetch data from Internet and Firebase
            self.groups = groups
            
            //This is used with Realm
            //Save groups to Realm
            //ONLY USE ONCE!
            //self.groupsDB.save(groups)
            
            //Fetch groups from Realm
            //self.groups = self.groupsDB.fetch()
            
            //Save groups to Firebase
            //saveToFirebase(groups)
            //Only enough TO DO THIS ONCE
            //SPECIAL BAZINGA GROUP ADDED MANUALLY TO FIREBASE TO PROVE THIS IS GETTING BACK FROM FIREBASE AND NOT INHERITED ELSEWHERE
            //BAZINGA'S AVATAR IS A PLACEHOLDER IMAGE
            //Go to console.firebase.google.com to check, what is uploaded
            //to Firebase
            
            //This is how we get data back from Firebase
            //If something happens in Firebase, we react to it
            //self.ref.observe(.value, with: { [weak self] snapshot in
                //print("-----------------")
                //print("SNAPSHOT")
                //print("-----------------")
                //print(snapshot.value as Any)
                
                //var groups: [GroupFirebase] = []
                //We check each child in snapshot
                //and add them to groups dictionary
                //for child in snapshot.children {
                    
                    //if let snapshot = child as? DataSnapshot, let group = //GroupFirebase(snapshot: snapshot) {
                        //groups.append(group)
                   // }
                //}
                //We transfer our local groups to external controller
                //self?.groups = groups
                //print("-----------------")
                //print("Output from Firebase")
                //print("-----------------")
                //print(groups)
                //let _ = self?.groups.map { print($0.name, $0.photo100)}
                
                //guard let self = self else { return }
                
                //self.tableView.reloadData()
                
            //})
            
            //This line was used for refreshing the table when it was Internet fetching
            self.tableView.reloadData()
            
            //This is used for refreshing the table in Realm
            //Token OBSERVES over the database changes
            //We receive different state changes and switch them
            //self.groupsToken = self.groups?.observe(on: .main, { [weak self] changes in
            
            //   guard let self = self else { return }
            
            //    switch changes {
            //    case .initial:
            //        self.tableView.reloadData()
            //    case .update(_, let deletions, let insertions, let modifications):
            //        self.tableView.beginUpdates()
            //        self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
            //       self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
            //      self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
            //      self.tableView.endUpdates()
            //   case .error(let error):
            //       print("\(error)")
            //    }
            //})
            
            
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //This line is for Realm
        //guard let groups = groups else { return 0 }
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        
        //This is for Internet fetching and Firebase
        let group = groups[indexPath.row]
        
        //This is for Realm
        //guard let groups = groups else { return cell }
        //let group: GroupDB = groups[indexPath.row]
        
        cell.textLabel?.text = groups[indexPath.row].name
        
        //We use SDWebImage Library to add picture into the cell
        //Setting placeholder image solves the cell image display problem
        if let url = URL(string: group.photo100) {
            cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "GrayLayer-Small-Heart-img"), completed: nil)
        }
        
        
        //Or, alternatively, this code can be used to refresh images in rows - REQUIRES PICTURE RESRESH EXTENSION SEEN
        //in FRIENDSVIEWCONTROLLER
        //Should also be noted, that this code WORKS SLOWER!
        //if let url = URL(string: group.photo100) {
        //cell.imageView?.load(url: url, completion: { image  in tableView.reloadRows(at: [indexPath], with: .automatic)
        //})
        //}
        
        //This is used to print Realm storage link,
        //which we can track by opening it in MongoDB
        //Open Terminal and command "open link"
        //let mainRealm = try! Realm ()
        //print(mainRealm.configuration.fileURL)
        
        return cell
        
    }
    
    //If the group is selected - this triggers a switch to FirebaseLogin
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showGroupPhotoCollectionViewController()
    }
    
    private func showGroupPhotoCollectionViewController() {
        let destination = GroupPhotoCollectionViewController(group: group, api: GroupsAPI())
        destination.group = self.group
        show(destination, sender: self)
    }
    
    
}
