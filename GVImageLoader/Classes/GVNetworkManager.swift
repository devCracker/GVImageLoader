//
//  GVNetworkManager.swift
//  GVImageLoader
//
//  Created by Venkat on 14/04/2019.
//

import Foundation

open class GVNetworkManager {
    
    static func urlRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    public static func request(url: URL, with httpMethod: HTTPMethod, and completion: @escaping Competion) {
        let session = URLSession(configuration: .ephemeral)
        let request = urlRequest(for: url)
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                if let errorDescription = error?.localizedDescription {
                    completion(.error(NetworkError.other(errorDescription)))
                } else {
                    completion(.error(NetworkError.unknown))
                }
                
                return
            }
            
            guard let data = data else {
                completion(.error(NetworkError.noDataRecived))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.error(NetworkError.invalidResponse))
                
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                completion(.value(data))
            default:
                completion(.error(NetworkError.noDataRecived))
            }
            }.resume()
        
    }
    
}
