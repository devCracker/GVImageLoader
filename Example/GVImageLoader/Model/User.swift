//
//  User.swift
//  GVImageLoader_Example
//
//  Created by Venkat on 14/04/2019.
//

import Foundation

struct User: Decodable {
    
    // MARK: Properties
    
    let id: String?
    let userName: String?
    let name: String?
    let profileImage: Image?

}

extension User {
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName
        case name
        case profileImage = "profile_image"
    }
    
}
