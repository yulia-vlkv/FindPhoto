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
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoURL = unsplashPhoto.urls.regular
            guard let url = URL(string: photoURL) else { return }
            
            pictureImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    let pictureImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupPicturesImageView()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
