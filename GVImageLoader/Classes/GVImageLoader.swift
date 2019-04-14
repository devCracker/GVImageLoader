//
//  GVImageLoader.swift
//  GVImageLoader
//
//  Created by Venkat on 10/04/2019.
//

import Foundation

public typealias Competion = (Result<Data>) -> ()

open class GVImageLoader {
    
    // MARK: Properties
    
    public static let shared: GVImageLoader = GVImageLoader()
    private let cacheManager = CacheHandler(true)
    
    open var cacheLimit: Int = 10*1024*1024 /*10MB* by default*/ {
        didSet {
            cacheManager.totalCostLimit = cacheManager.totalCostLimit
        }
    }
    
    // MARK: Initializer
    
    private init() { }

    // MARK: Private Methods
    
    private func requestImage(from url: String,
                      with completion: @escaping (Result<UIImage?>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.error(NetworkError.invalidURL))
            
            return
        }
        
        GVNetworkManager.request(url: url, with: .get) { result in
            switch result {
            case .value(let value):
                let imageData = UIImage(data: value)
                
                completion(.value(imageData))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    public func setCacheLimit(_ limit: Int) {
        self.cacheLimit = limit
    }
    
    // MARK: Public Methods
    
    public func image(from url: String, allowToReadFromCache: Bool, completion: @escaping (UIImage?) -> ()) {
        if allowToReadFromCache,
            let cacheData =  cacheManager.value(forKey: url),
            let imageData = cacheData.value as? Data {
            
            let uiImage = UIImage(data: imageData)
            
            completion(uiImage)
            
            return
        }
        
        requestImage(from: url) { result in
            switch result {
            case .value(let image):
                completion(image)
            case .error(_):
                completion(nil)
            }
        }
    }
    
}
