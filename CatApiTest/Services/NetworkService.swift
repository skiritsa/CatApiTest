//
//  NetworkService.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 04.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params:[String:String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        let url = self.url(from: path, params: params)
        print(url)
        var request = URLRequest(url: url)
        request.addValue(API.apiKey, forHTTPHeaderField: "x-api-key")
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.version + path
        components.queryItems = params.map({ URLQueryItem(name: $0, value: $1)})
        
        return components.url!
    }
}
