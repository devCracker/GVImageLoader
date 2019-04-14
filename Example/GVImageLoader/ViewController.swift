//
//  ViewController.swift
//  GVImageLoader
//
//  Created by venkat on 04/10/2019.
//  Copyright (c) 2019 venkat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: CollectionViewLayout!
    
    // MARK: Properties
    
    let dataSource = ProfileDataSource()

    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupCollectonView()
        loadData()
    }
    
    // MARK: Private Methods
    
    private func setupCollectonView() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)

        collectionViewLayout.delegate = self
    }
    
    private func loadData() {
        dataSource.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

}

// MARK: UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    // MARK: Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let items = dataSource.profiles
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        let items = dataSource.profiles

        cell.configure(items[indexPath.row])
        
        return cell
    }
}

extension ViewController: CollectionViewLayoutDelegate {
    
    // MARK: Functions
    
    func numberOfColumns() -> Int {
        return 2
    }
    
    func heightForItem(at indexPath: IndexPath) -> CGFloat {
        return 100 // height can be dynamic, this method has flexibilty to have different height for different cell like Pinterest
    }
    
}
