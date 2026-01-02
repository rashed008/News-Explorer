//
//  ImageDownloader.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import UIKit

final class ImageDownloader {

    static let shared = ImageDownloader()
    private init() {}

    func downloadImage(
        from url: URL,
        completion: @escaping (UIImage?) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard
                let data = data,
                let image = UIImage(data: data),
                error == nil
            else {
                completion(nil)
                return
            }

            completion(image)

        }.resume()
    }
}
