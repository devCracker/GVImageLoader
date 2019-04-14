//
//  UIImageView+Extensions.swift
//  GVImageLoader
//
//  Created by Venkat on 14/04/2019.
//

import Foundation

extension UIImageView {
    
    public func loadImage(from url: String, canReadFromCache: Bool = true, completion: @escaping () -> ()) {
        GVImageLoader.shared.image(from: url, allowToReadFromCache: canReadFromCache) { uiImage in
            DispatchQueue.main.async { [weak self] in
                self?.image = uiImage
                completion()
            }
        }
    }
    
}
