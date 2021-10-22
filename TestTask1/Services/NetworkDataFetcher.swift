//
//  UnsplashNetworkDataFetcher.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> Void ) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func fetchDetails(photoID: String, completion: @escaping (PictureDetails?) -> Void ) {
        networkService.detailsRequest(photoID: photoID) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: PictureDetails.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
