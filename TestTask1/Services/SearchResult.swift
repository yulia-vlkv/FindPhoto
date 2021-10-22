//
//  UnsplashSearchResult.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import Foundation

struct SearchResults: Decodable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: URLs
    let id: String
    let user: User
}

struct URLs: Codable {
    let raw, full, regular, small, thumb: String
}
