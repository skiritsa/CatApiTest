//
//  FullPhotoLayout.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 20.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation
import UIKit

protocol FullPhotoLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class FullPhotoLayout: UICollectionViewLayout {
    
    weak var delegate: FullPhotoLayoutDelegate!
    
    fileprivate var cellPadding: CGFloat = 6
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeight: CGFloat {
        
        guard let collectionView = collectionView else { return 0 }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: 400)
    }
    
    override func prepare() {
        
        contentWidth = 0
        cache = []

        guard cache.isEmpty == true, let collectionView = collectionView else { return }

        var yOffset: CGFloat = 0
        var xOffset: CGFloat = 0

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            guard let delegate = delegate else { return }
            let superviewWidth = collectionView.frame.width
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            let photoRatio = photoSize.height / photoSize.width
            let rowHeight = superviewWidth * photoRatio
            
            yOffset = (collectionView.frame.height / 2) - (rowHeight / 2) - 44
            let width = rowHeight / photoRatio

            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)

            contentWidth = max(contentWidth, frame.maxX)
            xOffset = xOffset + width
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

