//
//  PostTextCell.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//
//  Cell layout lesson: by Алексей Пархоменко
//  https://youtu.be/qmYNDXILDjY

import UIKit

class PostTextCell: UITableViewCell {
    
    static let reuseId = "PostTextCell"
    
    //This is an object, that contains the text
    let postText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.contentMode = .scaleAspectFill
        return textView
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
        postText.text = nil
    }
    
    private func updateSelectedState() {
        postText.alpha = isSelected ? 0.7 : 1
        //likeButton.alpha = isSelected ? 1 : 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Refresh cells to avoid reuse
        updateSelectedState()
        
        setupPostTextCell()
        //setupLikeButtonView()
    }
    
    private func setupPostTextCell() {
        addSubview(postText)
        postText.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        postText.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //Apple uses trailing and leading, because in some languages people write from right to left
        postText.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        postText.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
//    @IBOutlet weak var postText: UITextView!
//    //PostTextCell is constraint-based
//    //All other cells are layout-on-frame-based
//
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        postText.isEditable = false
//
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
//
//}

