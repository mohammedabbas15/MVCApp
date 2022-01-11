//
//  ImageCache.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 7/1/21.
//

import Foundation

final class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, NSData>
 
    init(cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()) {
        self.cache = cache
    }
    
}

extension ImageCache {
    
    func getData(url: String) -> Data? {
        let key = NSString(string: url)
        guard let data = self.cache.object(forKey: key) else { return nil }
        return Data(referencing: data)
    }
    
    func setData(url: String, data: Data) {
        let key = NSString(string: url)
        let object = NSData(data: data)
        self.cache.setObject(object, forKey: key)
    }
    
}
