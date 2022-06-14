//
//  UserPhotoCollectionViewController.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 07.06.2022.
//  UIButton programmatically by Coding Tutor
//  https://youtu.be/iLumM3X3Yu8
//
//  NavigationController with code by iOS Academy
//  https://youtu.be/Ime8NK5NLgc
//
//  PhotoCollectionViewController by Алексей Пархоменко
//  https://youtu.be/qmYNDXILDjY

import UIKit

class UserPhotoCollectionViewController: UIViewController {
    
    private var photosAPI = PhotosAPI()
    
    //This is used for Internet fetching
    private var photos: [PhotoAPI] = []
        
    //private let button = UIButton()
    private var userCollectionView: UICollectionView?
    
    //The images which we select by tapping
    private var selectedImages = [UIImage]()
    
    var api: PhotosService
    //Added to get other people's photos:
    //var friend: FriendAPI
    
    //Configure cell:
    //2 photos per row
    private let itemsPerRow: CGFloat = 2
    //Padding
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    //2 navigation buttons to save selected photos to Gallery
    //We just use one bar button item in this project
    //private lazy var addBarButtonItem: UIBarButtonItem = {
    //    return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    //}()
    //We just use one bar button item in this project
        private lazy var actionBarButtonItem: UIBarButtonItem = {
            return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonTapped))
        }()
        private var numberOfSelectedPhotos: Int {
            return userCollectionView?.indexPathsForSelectedItems?.count ?? 0  //If there are none - it's zero
        }
        

        init(api: PhotosService) {
        //Modified to get other people's photos:
        //init(friend: FriendAPI, api: PhotosService) {
            //Added to get other people's photos:
            //self.friend = friend
            self.api = api
            //self.photosAPI = [PhotoAPI]()

            super.init(nibName: nil, bundle: nil)

        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = view
        
        userCollectionView?.backgroundColor = .white
        
        photosAPI.getPhotos(userId: Int(Session.shared.userId) ?? 0) { [weak self] photos in
        guard let self = self else { return }
        self.photos = photos
        self.displayCollectionView()
        
        self.updateNavigationButtonsState()
        self.setupNavigationBar()
        
        
        
        //displayNavigationBar()
        //displayCollectionView()
        
        }
    }
    
    ///The buttons that sre sending the selected images to DeviceGallery will be unavailable untill we select the images
    private func updateNavigationButtonsState() {
        
        //This second button is not used
        //addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        
        actionBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }
    
    ///Clears all selections as soon as images have been sent to Device Gallery
    func refresh() {
        self.selectedImages.removeAll()
        self.userCollectionView?.selectItem(at: nil, animated: true, scrollPosition: [])
        updateNavigationButtonsState()
        
    }
    
    //This is a NavBar with export buttons
    private func setupNavigationBar() {
        //If we wanted to give a custom name to the left nav button
        //let titleLabel = UILabel()
        //titleLabel.text = "Friend's Photos"
        //titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        //titleLabel.textColor = .orange
        //navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        self.title = "SAVE SELECTED ->>>"
        
        //navigationItem.rightBarButtonItems = [actionBarButtonItem, addBarButtonItem]
        //We just use one button:
        navigationItem.rightBarButtonItem = actionBarButtonItem
    }
    
    //Not used
    //@objc private func addBarButtonTapped() {
    //    print(#function)
    //}
    
    
    @objc private func actionBarButtonTapped() {
        print(#function)
        
        let shareController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
        
        //If we have successfully exported photos, clear marks.
        //Refresh is defined above
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                self.refresh()
            }
        }
        //This necessary for our modal controller to work on any device
        shareController.popoverPresentationController?.sourceView = self.view
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        present(shareController, animated: true, completion: nil)
    }
    
    private func displayCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        userCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let userCollectionView = userCollectionView else {
            return
        }
        userCollectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCollectionCell")
        userCollectionView.dataSource = self
        userCollectionView.delegate = self
        view.addSubview(userCollectionView)
        userCollectionView.frame = view.frame
        
        //Define images layout
        userCollectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        userCollectionView.contentInsetAdjustmentBehavior = .automatic
        
        //Allow to select many images
        userCollectionView.allowsMultipleSelection = true
    }
    
    //private func displayNavigationBar() {
    //    title = "Jack's Photos"
    //    navigationItem.leftBarButtonItem = UIBarButtonItem(
    //        title: "<Home",
    //        style: .plain,
    //        target: self,
    //        action: #selector(dismissSelf))
    //}
}

//Select/deselect items for sending away
extension UserPhotoCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //We have selected the image to export - make export buttons active
        updateNavigationButtonsState()
        print("Selected item: \(indexPath.row)")
        //This is our selected cell
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionCell
        //We get the image view from the cell
        guard let image = cell.backgroundView?.largeContentImage else { return }
        //Add selected image to array
        selectedImages.append(image)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //We have deselected the image to export - chech if we need to deactivate the export buttons
        updateNavigationButtonsState()
        print("Deselected item: \(indexPath.row)")
        //This is our selected cell
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionCell
        //We get the image view from the cell
        guard let image = cell.backgroundView?.largeContentImage else { return }
        //If we have previously selected this image - we remove it from the array
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
        
    }
}

extension UserPhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ userCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        let cellView = UIImageView()
        if let url = URL(string: photo.sizes?[0].url ?? "Heart-img") {
        //if let url = URL(string: "https://proflebedev.ru/images/freckles.jpg") {
            let cellView = cellView.sd_setImage(with: url, placeholderImage: UIImage(named: "Heart-img")) }
            //print(photo.sizes[0].url)
            //let imageName = friendsData[indexPath.row].imageName
            //let image = UIImage(named: String(imageName))
                
            let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath)
                cell.backgroundView = cellView
                
            cell.backgroundColor = UIColor.blue
            return cell
    }
}


extension UserPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    /// Defines the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //We want to calculate the measurements of a certain photo
        let photo = photos[indexPath.item]
        //How many paddings do we have:
        //PADDING+PHOTO+PADDING+PHOTO+PADDING
        //If we want two photos, we need 3 paddings
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        //Three photos in row:
        //let availableWidth = view.frame.width / itemsPerRow
        //Two photos in row
        //The width that we have: screen width minus 3 paddings
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        // We calculate image height and keep aspect ration
        // by adjusting height as per available width.
        // Put these 3 values into proportion equation
        // and you'll see that the 4th value (numerator) is:
        // denominator * 2nd numerator / denominator
        let height = CGFloat(photo.sizes?[0].height ?? 50) * widthPerItem / CGFloat(photo.sizes?[0].width ?? 50)
        return CGSize(width: widthPerItem, height: height)
    }
    
    /// Calculates the distances between the objects
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    /// Calculates the distances between the objects
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
}
