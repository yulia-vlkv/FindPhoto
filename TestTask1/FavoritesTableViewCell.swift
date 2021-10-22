//
//  FavoritesTableViewCell.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 22.10.2021.
//

import Foundation
import UIKit
import SDWebImage

class FavoritesTableViewCell: UITableViewCell {
    
    var photo: PhotoRealmObject! {
        didSet {
            setCell()
        }
    }
    
    private func setCell() {
        authorLabel.text = "by \(photo.id)"
        image.sd_setImage(with: URL(string: photo.url), completed: nil)
    }
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleToFill
        image.toAutoLayout()
        return image
    } ()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.toAutoLayout()
        return label
    } ()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupSubviews() {
        contentView.addSubviews(image, authorLabel)
        
        image.layer.cornerRadius = 10
        
        let constraints = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
