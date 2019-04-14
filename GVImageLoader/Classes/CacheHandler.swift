//
//  CacheHandler.swift
//  GVImageLoader
//
//  Created by Venkat on 14/04/2019.
//

import Foundation

class CacheData {
    let value: Any
    
    init(_ value: Any) {
        self.value = value
    }
}

class CacheKey<T: Hashable> {
    let key: T
    
    init(_ key: T) {
        self.key = key
    }
    
}

class CacheHandler {
    
    // MARK: Properties
    
    private let cache: NSCache<CacheKey<String>, CacheData> = NSCache()
    
    open var totalCostLimit: Int {
        get {
            return cache.totalCostLimit
        }
        set {
            cache.totalCostLimit = totalCostLimit
        }
    }
    
    // MARK: Initialiser
    
    public init(_ memoryManagement: Bool = true) {
        guard memoryManagement else { return }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onDidReceiveMemoryWarning),
                                               name: UIApplication.didReceiveMemoryWarningNotification,
                                               object: nil)
    }
    
    // MARK: Functions
    
    @objc private func onDidReceiveMemoryWarning() {
        cache.removeAllObjects()
    }
    
    func value(forKey key: String) -> CacheData? {
        return cache.object(forKey: CacheKey(key))?.value as? CacheData
    }
    
    func setObject(_ obj: CacheData, forKey key: String, cost: Int) {
        return cache.setObject(CacheData(obj), forKey: CacheKey(key), cost: cost)
    }
    
    func removeObject(forKey key: String) {
        return cache.removeObject(forKey: CacheKey(key))
    }
    
    func removeAllObjects() {
        return cache.removeAllObjects()
    }
    
}
