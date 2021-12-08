//
//  BaseCollectionViewLayout.swift
//  CollectionViewLayoutExamples
//

import Foundation
import UIKit

class BaseCollectionViewLayout: UICollectionViewLayout {
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    var contentBounds: CGRect = .zero
    var cachedAttributes: [Int: [UICollectionViewLayoutAttributes]] = [:]
    var cachedSupplementaryAttributes: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        cachedAttributes.removeAll()
        cachedSupplementaryAttributes.removeAll()
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
        
        setup(collectionView: collectionView)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let allAttributes = cachedSupplementaryAttributes + cachedAttributes.reduce([]) { $0 + $1.value }
        let expectedAttributes = allAttributes.filter { $0.frame.intersects(rect) }
        return expectedAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let sectionAttributes = cachedAttributes[indexPath.section] else { return nil }
        return sectionAttributes[indexPath.row]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String,
                                                       at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedSupplementaryAttributes[indexPath.section]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return super.shouldInvalidateLayout(forBoundsChange: newBounds)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    func setup(collectionView: UICollectionView) {}
}
