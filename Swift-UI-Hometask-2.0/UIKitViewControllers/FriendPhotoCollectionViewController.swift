//
//  FriendPhotoCollectionViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 07.06.2022.
//
//  UIButton programmatically by Coding Tutor
//  https://youtu.be/iLumM3X3Yu8
//
//  NavigationController with code by iOS Academy
//  https://youtu.be/Ime8NK5NLgc

import UIKit

class FriendPhotoCollectionViewController: UIViewController {
    
    private var photosAPI = PhotosAPI()
    private var photos: [PhotoAPI] = []
    //This is used for Internet fetching
    //public var photosAPI = [PhotoAPI].self
 
    var api: PhotosService
    //Added to get other people's photos:
    var friend: FriendAPI
    
    //Configure cell:
    //2 photos per row
    private let itemsPerRow: CGFloat = 2
    //Padding
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    
    //init(api: PhotosService) {
    //Modified to get other people's photos:
    init(friend: FriendAPI, api: PhotosService) {
        //Added to get other people's photos:
        self.friend = friend
        self.api = api
        //self.photosAPI = [PhotoAPI]()
       
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var photoCollectionView: UICollectionView?
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var photosAPI = PhotosAPI()
        //var photos: [PhotoAPI]
        
        photoCollectionView?.backgroundColor = .white
        
        self.view = view
        photosAPI.getPhotos(userId: friend.id) { [weak self] photos in
            guard let self = self else { return }
            self.photos = photos
            //print("WWWWWWWWWWWWW")
            //print(photos)
            //print("WWWWWWWWWWWWW")
            self.displayCollectionView()
            
        }
       
        //print("friend.id")
        //print(friend.id)
        //print("============")
        //print("H")
        //print("============")
        //print(photos)
        //print("+++++++++++++")
        
        
    }
    

    
    private func displayCollectionView() {
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let photoCollectionView = photoCollectionView else {
            return
        }
        photoCollectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCollectionCell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        view.addSubview(photoCollectionView)
        photoCollectionView.frame = view.frame
        
        //Define images layout
        photoCollectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        photoCollectionView.contentInsetAdjustmentBehavior = .automatic
    }
}

extension FriendPhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ photoCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        
        
        let photo = photos[indexPath.row]
        let cellView = UIImageView()
        if let url = URL(string: photo.sizes?[0].url ?? "Heart-img") {
        //if let url = URL(string: "https://proflebedev.ru/images/freckles.jpg") {
        let cellView = cellView.sd_setImage(with: url, placeholderImage: UIImage(named: "Heart-img")) }
        //print(photo.sizes[0].url)
        //let imageName = friendsData[indexPath.row].imageName
        //let image = UIImage(named: String(imageName))
        
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath)
        cell.backgroundView = cellView
        cell.backgroundColor = UIColor.orange
       
        
        return cell
    }
}

extension FriendPhotoCollectionViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}

extension FriendPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    /// Defines the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //We want to calculate the measurements of a certain photo
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width / itemsPerRow
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(photo.sizes?[0].height ?? 50) * widthPerItem / CGFloat(photo.sizes?[0].width ?? 50)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
}
