//
//  WebImageView.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 14.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {

    private var currentUrlString: String?

    func set(imageURL: String?) {

        currentUrlString = imageURL

        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return }

        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, _) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }

    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))

        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}
