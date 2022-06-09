//
//  PhotoPostCell.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//

import UIKit

class PhotoPostCell: UITableViewCell {
    
    static let reuseId = "PhotoPostCell"
    
    //This is an object, that contains the photo
    let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    //Add tap action to cell (like)
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    //Optimize the reuse to refresh image when reused
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.image = nil
    }
    
    private func updateSelectedState() {
        newsImage.alpha = isSelected ? 0.7 : 1
        //likeButton.alpha = isSelected ? 1 : 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Refresh cells to avoid reuse
        updateSelectedState()
        
        setupNewsImage()
        //setupLikeButtonView()
    }
    
    private func setupNewsImage() {
        addSubview(newsImage)
        newsImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        newsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //Apple uses trailing and leading, because in some languages people write from right to left
        newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
/*    //@IBOutlet weak var collectionPhoto: UICollectionViewCell!
    @IBOutlet weak var imageView2: UIImageView! {
        //This didSet is only used for frame-based layout
        didSet {
            imageView2.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //Set border insets. They seem to only work for text labels
    let insets: CGFloat = 2.0
    
    //let newsAPI = NewsAPI()
    var photoArray: [PhotoPost] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //collectionPhoto.delegate = self
        //collectionPhoto.dataSource = self
        
        //        newsAPI.newsRequest { _, Photo in
        //            self.photoArray = Photo
        //            self.collectionPhoto.reloadData()
        //        }
    }
    
    //This is used for frame-based layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Adds nice shadows to views
        //self.layer.shadowRadius = 9
        //layer.shadowOpacity = 0.3
        //layer.shadowOffset = CGSize(width: 5, height: 8)
        //self.clipsToBounds = false
        
        imageView2Frame()
        
    }
    
    
    /// This func defines the size and location of a main news image
    func imageView2Frame() {
        let imageView2SideLength: CGFloat = (bounds.width - insets * 2)
        let imageView2SideHeight: CGFloat = (bounds.height - insets * 2)
        
        let imageView2Size = CGSize(width: imageView2SideLength, height: imageView2SideHeight)
        //That would be horizontal center
        //let newsChannelAvatarOrigin = CGPoint(x: bounds.midX - newsChannelAvatarSideLength / 2, y: bounds.midY - newsChannelAvatarSideLength / 2)
        //We would like origin to be the left edge of the cell:
        let imageView2Origin = CGPoint(x: 0 + insets, y: 0 + insets)
        imageView2.frame = CGRect(origin: imageView2Origin, size:  imageView2Size)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure() {
        
    }
    
}

extension PhotoPostCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotoCollectionCellCollectionViewCell", for: indexPath) as! NewsPhotoCollectionCellCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}*/

