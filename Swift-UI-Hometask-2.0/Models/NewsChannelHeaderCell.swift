//
//  NewsChannelHeaderCell.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//
//  Custom Cell by iOS Academy
//  https://youtu.be/Pu7B7uEzP18

import UIKit

class NewsChannelHeaderCell: UITableViewCell {
        
    static let reuseId = "NewsChannelHeaderCell"
    
    //Set border insets.
    let insets: CGFloat = 2.0
    
    //This is a switch
    //"Switch" is a reserved function, so we go with _switch"
    //private let _switch: UISwitch = {
    //    let _switch = UISwitch()
    //   _switch.onTintColor = .blue
    //    _switch.isOn = true
    //    return _switch
    //}()

    
    //This is an object, that contains the photo
    let newsChannelAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let newsChannelNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
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
        newsChannelAvatar.image = nil
    }
    
    private func updateSelectedState() {
        newsChannelAvatar.alpha = isSelected ? 0.7 : 1
        //likeButton.alpha = isSelected ? 1 : 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Set cell's background color
        contentView.backgroundColor = .black
        //contentView.addSubview(_switch)
        contentView.addSubview(newsChannelAvatar)
        contentView.addSubview(newsChannelNameLabel)
        contentView.addSubview(dateAndTimeLabel)
        
        
        //Refresh cells to avoid reuse
        updateSelectedState()
        
        setupNewsChannelAvatar()
        //setupLikeButtonView()
    }
    
    private func setupNewsChannelAvatar() {
        addSubview(newsChannelAvatar)
        newsChannelAvatar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        newsChannelAvatar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //Apple uses trailing and leading, because in some languages people write from right to left
        newsChannelAvatar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        newsChannelAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    // Standard intializer, just keep it
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// This func defines the size of the label, based on text length and font size
    /// - Returns: our label size
    func getLabelSize(text: String, font: UIFont) -> CGSize {
    //the maximum text width is the cell width minus insets
    let maxWidth = bounds.width - insets * 2
    //we get the text block size using max width and max possible height
    let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
    //we get a rectangle for text and define font
    let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
    //we get block width and convert it to Double
    let width = Double(rect.size.width)
    //we get block height and convert it to Double
    let height = Double(rect.size.height)
    //we get the size and round them values to greater integer value
    let size = CGSize(width: ceil(width), height: ceil(height))
    
    return size
    }
    
    
    /// Manage the layout of the subViews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Our image is a square with equal sides
        let imageSize = contentView.frame.size.height-6
        
        //_switch.frame = CGRect(x: 5, y: 5, width: 100, height: contentView.frame.size.height-10)
        
        let dateAndTimeLabelSize = getLabelSize(text: dateAndTimeLabel.text!, font: dateAndTimeLabel.font)
        
        
        dateAndTimeLabel.frame = CGRect(x: (contentView.frame.size.width - insets - dateAndTimeLabelSize.width - imageSize)/2, y: bounds.height - dateAndTimeLabelSize.height - insets*4, width: dateAndTimeLabelSize.width, height: dateAndTimeLabelSize.height)
        
        let newsChannelNameLabelSize = getLabelSize(text: newsChannelNameLabel.text!, font: newsChannelNameLabel.font)
        
        
        newsChannelNameLabel.frame = CGRect(x: (contentView.frame.size.width - insets - newsChannelNameLabelSize.width - imageSize)/2, y: bounds.midY - newsChannelNameLabelSize.height + insets, width: newsChannelNameLabelSize.width, height: newsChannelNameLabelSize.height)
        
        newsChannelAvatar.frame = CGRect(x: contentView.frame.size.width-imageSize-insets, y: 3, width: imageSize, height: imageSize)
        
    }
}
    
//    @IBOutlet weak var newsChannelAvatar: UIImageView! {
//        //This didSet is only used for frame-based layout
//        didSet {
//            newsChannelAvatar.translatesAutoresizingMaskIntoConstraints = false
//
//            //Nice animation found while trying to solve refreshing
//            //newsChannelAvatar.layoutIfNeeded()
//            //UIView.animate(withDuration: 2) {
//            //self.newsChannelAvatarFrame()
//            //self.newsChannelAvatar.layoutIfNeeded()
//            //}
//        }
//    }
//    @IBOutlet weak var newsChannelNameLabel: UILabel! {
//        //This didSet is only used for frame-based layout
//        didSet {
//            newsChannelNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
//
//    @IBOutlet weak var dateAndTimeLabel: UILabel! {
//        //This didSet is only used for frame-based layout
//        didSet {
//            dateAndTimeLabel.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
//
//
//    //Set border insets.
//    let insets: CGFloat = 2.0
//
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        //This makes news Channel Avatar circular
//        //Removed for the sake of speed
//        //newsChannelAvatar?.layer.cornerRadius = (newsChannelAvatar?.frame.height)! / 2
//        //newsChannelAvatar?.clipsToBounds = true
//    }
//
//    //This is used for frame-based layout
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        //Adds nice shadows to views
//        self.layer.shadowRadius = 9
//        layer.shadowOpacity = 0.3
//        layer.shadowOffset = CGSize(width: 5, height: 8)
//        self.clipsToBounds = false
//
//        newsChannelAvatarFrame()
//        newsChannelNameLabelFrame()
//        dateAndTimeLabelFrame()
//
//    }
//
//
//
//    /// This func defines the size and location of a news Channel avatar
//    func newsChannelAvatarFrame() {
//        let newsChannelAvatarSideLength: CGFloat = 60
//        let newsChannelAvatarSize = CGSize(width: newsChannelAvatarSideLength, height: newsChannelAvatarSideLength)
//        //That would be horizontal center
//        //let newsChannelAvatarOrigin = CGPoint(x: bounds.midX - newsChannelAvatarSideLength / 2, y: bounds.midY - newsChannelAvatarSideLength / 2)
//        //We would like origin to be the left edge of the cell:
//        let newsChannelAvatarOrigin = CGPoint(x: 0, y: bounds.midY - newsChannelAvatarSideLength / 2)
//        newsChannelAvatar.frame = CGRect(origin: newsChannelAvatarOrigin, size: newsChannelAvatarSize)
//    }
//
//    /// This func defines the size of the label, based on text length and font size
//    /// - Returns: our label size
//    func getLabelSize(text: String, font: UIFont) -> CGSize {
//        //the maximum text width is the cell width minus insets
//        let maxWidth = bounds.width - insets * 2
//        //we get the text block size using max width and max possible height
//        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
//        //we get a rectangle for text and define font
//        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
//        //we get block width and convert it to Double
//        let width = Double(rect.size.width)
//        //we get block height and convert it to Double
//        let height = Double(rect.size.height)
//        //we get the size and round them values to greater integer value
//        let size = CGSize(width: ceil(width), height: ceil(height))
//        return size
//    }
//
//    /// This func defines the size and location of a news Channel name label
//    func newsChannelNameLabelFrame() {
//        //we get text size by providing the text itself and the font
//        let newsChannelNameLabelSize = getLabelSize(text: newsChannelNameLabel.text!, font: newsChannelNameLabel.font)
//        //That would be the X coordinate, 60 is the avatar size
//        let newsChannelNameLabelSizeX = (bounds.width - newsChannelNameLabelSize.width + 60) / 2
//        //That would be the Y coordinate
//        //The below line would place label below
//        //let newsChannelNameLabelSizeY = bounds.height - newsChannelNameLabelSize.height - insets
//        let newsChannelNameLabelSizeY = bounds.midY - newsChannelNameLabelSize.height - insets
//        //This is the upper left corner of the label
//        let newsChannelNameLabelOrigin = CGPoint(x: newsChannelNameLabelSizeX, y: newsChannelNameLabelSizeY )
//        //we get frame and set UILabel
//        newsChannelNameLabel.frame = CGRect(origin: newsChannelNameLabelOrigin, size: newsChannelNameLabelSize)
//    }
//
//    /// This func defines the size and location of a date and time label
//    func dateAndTimeLabelFrame() {
//        //we get text size by providing the text itself and the font
//        let dateAndTimeLabelSize = getLabelSize(text: dateAndTimeLabel.text!, font: dateAndTimeLabel.font)
//        //That would be the X coordinate, 60 is the avatar size
//        let dateAndTimeLabelSizeX = (bounds.width - dateAndTimeLabelSize.width + 60) / 2
//        //That would be the Y coordinate
//        //The below line would place label below
//        //let dataLabelSizeY = bounds.height - dataLabelSize.height - insets
//        let dateAndTimeLabelSizeY = bounds.midY + insets
//        //This is the upper left corner of the label
//        let dateAndTimeLabelOrigin = CGPoint(x: dateAndTimeLabelSizeX, y: dateAndTimeLabelSizeY )
//        //we get frame and set UILabel
//        dateAndTimeLabel.frame = CGRect(origin: dateAndTimeLabelOrigin, size: dateAndTimeLabelSize)
//    }
//
//    /// This func sets the text for the news channel name label
//    func setNewsChannelNameLabelText(text: String) {
//        newsChannelNameLabel.text = text
//        newsChannelNameLabelFrame()
//    }
//
//    /// This func sets the text for the data label
//    func setDateAndTimeLabelText(text: String) {
//        dateAndTimeLabel.text = text
//        dateAndTimeLabelFrame()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
//
    
    


