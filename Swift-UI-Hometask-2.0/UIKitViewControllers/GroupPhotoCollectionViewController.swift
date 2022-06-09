//
//  GroupPhotoCollectionViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 07.06.2022.
//

//  Created by Anton Lebedev on 07.06.2022.
//  UIButton programmatically by Coding Tutor
//  https://youtu.be/iLumM3X3Yu8
//
//  NavigationController with code by iOS Academy
//  https://youtu.be/Ime8NK5NLgc

import UIKit

class GroupPhotoCollectionViewController: UIViewController {
    
    var api: GroupsService
    var group: GroupAPI
    //private let button = UIButton()
    private var groupCollectionView: UICollectionView?
    
    //Configure cell:
    //2 photos per row
    private let itemsPerRow: CGFloat = 2
    //Padding
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    //init(api: PhotosService) {
    //Modified to get other people's photos:
    init(group: GroupAPI, api: GroupsService) {
        //Added to get other people's photos:
        self.group = group
        self.api = api
       
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let view = UIView()
        
        groupCollectionView?.backgroundColor = .white
        
        //button.setTitle("Push another controller", for: .normal)
        //view.addSubview(button)
        //button.backgroundColor = .white
        // //Set text color
        //button.setTitleColor(.black, for: .normal)
        //button.frame = CGRect(x: 60, y: 100, width: 200, height: 52)
        // //Make circular edges
        //button.layer.cornerRadius = 15
        // //Add action
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.view = view
        
        //displayNavigationBar()
        displayCollectionView()
        
    }
    
    private func displayCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        groupCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let groupCollectionView = groupCollectionView else {
            return
        }
        groupCollectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCollectionCell")
        groupCollectionView.dataSource = self
        groupCollectionView.delegate = self
        view.addSubview(groupCollectionView)
        groupCollectionView.frame = view.frame
        
        //Define images layout
        groupCollectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        groupCollectionView.contentInsetAdjustmentBehavior = .automatic
        
    }
    
}

extension GroupPhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupsData.count
    }
    
    func collectionView(_ groupCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageName = groupsData[indexPath.row].imageName
        let image = UIImage(named: String(imageName))
        let cellView = UIImageView(image: image)
        let cell = groupCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath)
        cell.backgroundColor = UIColor.systemPink
        cell.backgroundView = cellView
        return cell
    }
}

extension GroupPhotoCollectionViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}

extension GroupPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    /// Defines the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //We want to calculate the measurements of a certain photo
        let imageName = groupsData[indexPath.row].imageName
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width / itemsPerRow
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(50) * widthPerItem / CGFloat(50)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
}

