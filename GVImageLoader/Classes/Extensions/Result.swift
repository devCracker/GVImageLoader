//
//  Result.swift
//  GVImageLoader
//
//  Created by Venkat on 14/04/2019.
//

import Foundation

public enum Result<T> {
    case value(T)
    case error(Error)
}
