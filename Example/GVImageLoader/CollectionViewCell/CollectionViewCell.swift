//
//  CollectionViewCell.swift
//  GVImageLoader_Example
//
//  Created by Venkat on 14/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Properties
    
    static let identifier = "\(CollectionViewCell.self)"
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        imageview.image = nil
        spinner.isHidden = false
    }

    func configure(_ data: ProfileData) {
        let smallImageURL = data.user?.profileImage?.medium ?? ""
        
        imageview.loadImage(from: smallImageURL) { [weak self] in
            self?.spinner.isHidden = true
        }
    }
}
