//
//  CollectionViewLayout.swift
//  GVImageLoader_Example
//
//  Created by Venkat on 14/04/2019.
//

import UIKit

protocol CollectionViewLayoutDelegate {
    
    // MARK: Functions
    
    func numberOfColumns() -> Int
    func heightForItem(at indexPath: IndexPath) -> CGFloat
    
}

class CollectionViewLayout: UICollectionViewLayout {
    
    //
    // LAYOUT STRUCTURE FOR LANDSCAPE
    // --------------------------------------
    // | Group1 | Group2 |
    // | Group3 | Group4 |
    // |  ...   |  ...   |
    //          | Group_n |
    // --------------------------------------
    //

    // MARK: Constant
    
    struct StyleGuide {
        static let padding: CGFloat = 12.0
    }
    
    // MARK: Properties
    
    var delegate: CollectionViewLayoutDelegate?
    
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var itemHeight = CGFloat(0)
    
    private var numberOfColumns: Int {
        return delegate?.numberOfColumns() ?? 1
    }
    
    private var itemWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // MARK: UICollectionViewLayout
    
    override func invalidateLayout() {
        layoutAttributes.removeAll()
        itemHeight = CGFloat(0)
        
        super.invalidateLayout()
    }
    
    override func prepare() {
        guard
            layoutAttributes.isEmpty,
            let collectionView = collectionView
            else {
                return
        }
        
        let columnWidth = itemWidth / CGFloat(numberOfColumns)
        var columnIndex = 0
        var yPos = [CGFloat](repeating: 0, count: numberOfColumns)
        var xPos = [CGFloat]()
        
        for column in 0 ..< numberOfColumns {
            xPos.append(CGFloat(column) * columnWidth)
        }
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let itemHeight = delegate?.heightForItem(at: indexPath) ?? 0
            let height = StyleGuide.padding * 2 + itemHeight
            let frame = CGRect(x: xPos[columnIndex],
                               y: yPos[columnIndex],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: StyleGuide.padding, dy: StyleGuide.padding)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attribute.frame = insetFrame
            
            layoutAttributes.append(attribute)
            
            self.itemHeight = max(self.itemHeight, frame.maxY)
            yPos[columnIndex] = yPos[columnIndex] + height
 
            columnIndex = columnIndex < (numberOfColumns - 1) ? (columnIndex + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in layoutAttributes {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
