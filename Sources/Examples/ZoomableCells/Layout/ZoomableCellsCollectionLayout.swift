//
//  ZoomableCellsCollectionLayout.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ZoomableCellsCollectionLayout: BaseCollectionViewLayout {
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    private var itemSize: CGSize = .zero
    private let spacing: CGFloat = 8
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let reminder = proposedContentOffset.y.truncatingRemainder(dividingBy: itemSize.height)
        let whole = proposedContentOffset.y - reminder
        
        let contentOffset = CGPoint(x: proposedContentOffset.x,
                                    y: whole + round(reminder / itemSize.height) * itemSize.height)
        
        return super.targetContentOffset(forProposedContentOffset: contentOffset, withScrollingVelocity: velocity)
    }
    
    override func setup(collectionView: UICollectionView) {
        super.setup(collectionView: collectionView)
        
        var sectionOffset: CGFloat = spacing
        
        let numberOfSections = collectionView.numberOfSections
        for sectionIndex in 0..<numberOfSections {
            setupSectionAttributes(at: sectionIndex,
                                   sectionOffset: sectionOffset,
                                   collectionView: collectionView)
            sectionOffset += CGFloat(collectionView.numberOfItems(inSection: sectionIndex)) * itemSize.width
        }
        
        let expectedContentSize = CGSize(width: contentBounds.width, height: contentBounds.height)
        contentBounds = CGRect(origin: contentBounds.origin, size: expectedContentSize)
    }
    
    private func setupSectionAttributes(at sectionIndex: Int,
                                        sectionOffset: CGFloat,
                                        collectionView: UICollectionView) {
        let numberOfItems = collectionView.numberOfItems(inSection: sectionIndex)
        for itemIndex in 0..<numberOfItems {
            setupItemAttributes(at: itemIndex,
                                sectionIndex: sectionIndex,
                                sectionOffset: sectionOffset,
                                collectionView: collectionView)
        }
    }
    
    private func setupItemAttributes(at itemIndex: Int,
                                     sectionIndex: Int,
                                     sectionOffset: CGFloat,
                                     collectionView: UICollectionView) {
        let frame = CGRect(x: 0,
                           y: sectionOffset + CGFloat(itemIndex) * itemSize.height,
                           width: itemSize.width,
                           height: itemSize.height)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: itemIndex, section: sectionIndex))
        attributes.frame = frame
        
        var sectionAttributes = cachedAttributes[sectionIndex] ?? []
        sectionAttributes.append(attributes)
        cachedAttributes[sectionIndex] = sectionAttributes
        
        contentBounds = contentBounds.union(frame)
    }
}
