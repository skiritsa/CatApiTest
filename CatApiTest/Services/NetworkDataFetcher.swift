//
//  NetworkDataFetcher.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 04.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getBreed(response: @escaping ([BreedResponse]?) -> Void)
    func getImageUrl(_ forBreed: BreedResponse?, response: @escaping ([BreedImageResponse]?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking

    init() {
        self.networking = NetworkService()
    }

    func getBreed(response: @escaping ([BreedResponse]?) -> Void) {
        var params = ["": ""]
        networking.request(path: API.breeds, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: [BreedResponse].self, from: data)
            response(decoded)
        }
    }

    func getImageUrl(_ forBreed: BreedResponse?, response: @escaping ([BreedImageResponse]?) -> Void) {
        var params = ["size": "full", "order": "ASC"]

        if let breed = forBreed {
        params["breed_id"] = breed.id
        }

        networking.request(path: API.breedImage, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: [BreedImageResponse].self, from: data)
            response(decoded)
        }
    }

    func getAllImageUrl(response: @escaping ([BreedImageResponse]?) -> Void) {
        let params = ["size": "full", "order": "RANDOM", "limit": "50"]
        networking.request(path: API.breedImage, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: [BreedImageResponse].self, from: data)
            response(decoded)
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil}
        return response
    }
}
