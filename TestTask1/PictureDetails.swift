//
//  PicturesDetails.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 21.10.2021.
//

import Foundation


struct PictureDetails: Codable {
    let id: String
    let user: User
    let location: Location
    let created_at: String
    let downloads: Int
    let urls: URLs
}

struct User: Codable {
    let name: String
}

struct Location: Codable {
    let city: String?
    let country: String?
}


var savedImages = [UnsplashPhoto]()
