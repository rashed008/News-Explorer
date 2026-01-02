//
//  UIImageView + Extension.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import UIKit

extension UIImageView {
    
    func setImage(
        from urlString: String,
        placeholder: UIImage? = nil
    ) {
        self.image = placeholder
        
        guard let url = URL(string: urlString) else { return }

        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }

        ImageDownloader.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self, let image = image else { return }
            ImageCache.shared.setImage(image, forKey: urlString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}


