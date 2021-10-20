//
//  UnsplashNetworkService.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import Foundation

class NetworkService {
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
        
        let parameters = self.setParameters(searchTerm: searchTerm)
        let url = self.url(mainParameters: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID 4JhZeXEklefz5su9xFXSTxr5mvsa9lg88MqXaVJJ4io"
        return headers
    }
    
    private func setParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(mainParameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = mainParameters.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
