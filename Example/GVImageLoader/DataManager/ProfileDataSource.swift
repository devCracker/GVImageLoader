//
//  ProfileDataManager.swift
//  GVImageLoader_Example
//
//  Created by Venkat on 14/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import GVImageLoader

enum APISource {
    case profileData
    
    var endPoint: String {
        switch self {
        case .profileData:
            return "http://pastebin.com/raw/wgkJgazE"
        }
    }
}

class ProfileDataSource {
    var profiles: [ProfileData]
    let apiSource: APISource
    
    init() {
        profiles = []
        apiSource = .profileData
    }

    func loadData(completion: @escaping () -> ()) {
        guard let url = URL(string: apiSource.endPoint) else { return }
        
        GVNetworkManager.request(url: url, with: .get) { [weak self] result in
            switch result {
            case .value(let data):
                self?.handle(data)
                completion()
            case .error(_):
                self?.profiles = []
            }
        }
    }
    
    // MARK: Private Methods
    
    private func handle(_ data: Data) {
        let decoder = JSONDecoder()

        do {
          profiles = try decoder.decode([ProfileData].self, from: data)
        } catch {}
    }
}
