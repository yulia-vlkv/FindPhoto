//
//  PicturesViewControllerCell.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit
import SDWebImage

class PicturesCollectionCell: UICollectionViewCell {
    
    static let reuseID = "PictureCell"
    
//    private let checkmark: UIImageView = {
//        let image = UIImageView(image: UIImage(named: "checkmark"))
//        image.toAutoLayout()
//        image.alpha = 0
//        return image
//    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoURL = unsplashPhoto.urls.regular
            guard let url = URL(string: photoURL) else { return }
            
            pictureImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
//    override var isSelected: Bool {
//        didSet {
//            updateForSelectedState()
//        }
//    }
    
    let pictureImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        
        return image
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
//    private func updateForSelectedState() {
//        pictureImageView.alpha = isSelected ?  0.8 : 1
//        checkmark.alpha = isSelected ? 1 : 0
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        updateForSelectedState()
        setupPicturesImageView()
//        setupCheckmark()
    }
    
    private func setupPicturesImageView() {
        addSubview(pictureImageView)
        
        let constraints = [
            pictureImageView.topAnchor.constraint(equalTo: self.topAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
//    private func setupCheckmark() {
//        addSubview(checkmark)
//
//        let constraints = [
//            checkmark.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: -8 ),
//            checkmark.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: -8 )
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
