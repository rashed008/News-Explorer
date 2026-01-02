//
//  ImageCache.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 200
        cache.totalCostLimit = 50 * 1024 * 1024 
    }
    
    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        let cost = Int(
            image.size.width *
            image.size.height *
            image.scale *
            image.scale * 4
        )
        cache.setObject(image, forKey: key as NSString, cost: cost)
    }
    
    
    
}
