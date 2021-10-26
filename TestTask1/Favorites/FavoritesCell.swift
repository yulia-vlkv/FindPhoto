//
//  FavoritesTableViewCell.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 22.10.2021.
//

import Foundation
import UIKit
import SDWebImage

class FavoritesCell: UITableViewCell {
    
    var photo: PhotoRealmObject! {
        didSet {
            authorLabel.text = "by \(photo.author)"
            image.sd_setImage(with: URL(string: photo.url), completed: nil)
        }
    }
    
    private var topBottomInset: CGFloat { return 5 }
    private var sideInset: CGFloat { return 20 }
    private var height: CGFloat { return 50 }
    
    private let backgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "pastelSandy")
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.toAutoLayout()
        return label
    } ()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
    
        image.toAutoLayout()
        return image
    } ()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 2
        label.textAlignment = .right
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
        contentView.addSubviews(backgroundLabel, image, authorLabel)
        
        let constraints = [
            backgroundLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                 constant: topBottomInset),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                    constant: -topBottomInset),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: backgroundLabel.topAnchor,
                                       constant: topBottomInset),
            image.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor,
                                           constant: sideInset),
            image.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor,
                                          constant: -topBottomInset),
            image.heightAnchor.constraint(equalToConstant: height),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),

            authorLabel.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor,
                                                constant: -topBottomInset),
            authorLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor,
                                                  constant: -sideInset),
            authorLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                                                 constant: sideInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
