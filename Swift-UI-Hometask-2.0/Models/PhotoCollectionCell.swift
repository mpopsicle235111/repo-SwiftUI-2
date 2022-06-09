//
//  PhotoCollectionCell.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 06.06.2022.
//
//  PhotoCollectionCell и ViewController к нему by Алексей Пархоменко
//  https://youtu.be/qmYNDXILDjY

import UIKit
import SDWebImage

class PhotoCollectionCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCollectionCell"
    
    private let likeButton: UIImageView = {
        let image = UIImage(named: "GrayLayer-Small-Heart-img")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Like button initially is not visible
        imageView.alpha = 0
        
        return imageView
    }()
    
    //This is an object, that contains the photo
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //Accepts photo from JSON
//    var photoAPI: PhotoAPI! {
//        didSet {
//            //We use SDWebImage Library to add picture into the cell
//            //Setting placeholder image solves the cell image display problem
//            if let url = URL(string: photoAPI.sizes.last?.url ?? "GrayLayer-Small-Heart-img") {
//                photoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "GrayLayer-Small-Heart-img"), completed: nil)
//                
//            }
//        }
//    }
    

    
    //Add tap action to cell (like)
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    //Optimize the reuse to refresh image when reused
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.7 : 1
        likeButton.alpha = isSelected ? 1 : 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Refresh cells to avoid reuse
        updateSelectedState()
        
        setupPhotoImageView()
        setupLikeButtonView()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //Apple uses trailing and leading, because in some languages people write from right to left
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    //Locate Like Button on the screen
    private func setupLikeButtonView() {
        addSubview(likeButton)
        likeButton.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

