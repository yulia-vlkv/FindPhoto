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
        authorLabel.text = "by \(photo.author)"
        image.sd_setImage(with: URL(string: photo.url), completed: nil)
    }
    
    private let backgroundLabel: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = UIColor(named: "pastelSandy")
        lable.clipsToBounds = true
        lable.layer.cornerRadius = 15
        lable.toAutoLayout()
        return lable
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
            
            backgroundLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: backgroundLabel.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: 25),
            image.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor, constant: -5),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),

            authorLabel.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor, constant: -15),
            authorLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -25),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
