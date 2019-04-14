//
//  NetworkError.swift
//  GVImageLoader
//
//  Created by Venkat on 14/04/2019.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case notReachable
    case endPointNotFound
    case other(String)
    case noDataRecived
    case invalidResponse
    case unknown
}
