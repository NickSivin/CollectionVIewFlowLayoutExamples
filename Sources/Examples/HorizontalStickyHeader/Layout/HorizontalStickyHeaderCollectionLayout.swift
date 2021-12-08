//
//  HorizontalStickyHeaderCollectionLayout.swift
//  CollectionViewLayoutExamples
//

import UIKit

protocol HorizontalStickyHeaderCollectionLayoutDelegate: AnyObject {
    func horizontalStickyHeaderCollectionLayout(_ collectionView: UICollectionView,
                                                layout collectionViewLayout: UICollectionViewLayout,
                                                referenceSizeForHeaderInSection section: Int) -> CGSize
}

class HorizontalStickyHeaderCollectionLayout: BaseCollectionViewLayout {
    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
      return .rightToLeft
    }

    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
      return true
    }
    
    weak var delegate: HorizontalStickyHeaderCollectionLayoutDelegate?
    
    private let itemSize = CGSize(width: 120, height: 60)
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let reminder = proposedContentOffset.x.truncatingRemainder(dividingBy: itemSize.width)
        let whole = proposedContentOffset.x - reminder
        
        let contentOffset = CGPoint(x: whole + round(reminder / itemSize.width) * itemSize.width,
                                    y: proposedContentOffset.y)
        
        return super.targetContentOffset(forProposedContentOffset: contentOffset, withScrollingVelocity: velocity)
    }
    
    override func setup(collectionView: UICollectionView) {
        super.setup(collectionView: collectionView)
        
        let inset = contentBounds.width / 2 - itemSize.width / 2
        var sectionOffset: CGFloat = inset
        
        let numberOfSections = collectionView.numberOfSections
        for sectionIndex in 0..<numberOfSections {
            setupSectionAttributes(at: sectionIndex,
                                   sectionOffset: sectionOffset,
                                   collectionView: collectionView)
            sectionOffset += CGFloat(collectionView.numberOfItems(inSection: sectionIndex)) * itemSize.width
        }
        
        let expectedContentSize = CGSize(width: contentBounds.width + inset, height: contentBounds.height)
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
        
        let sectionWidth = CGFloat(numberOfItems) * itemSize.width
        setupSupplementaryAttributes(sectionIndex: sectionIndex,
                                     sectionOffset: sectionOffset,
                                     sectionWidth: sectionWidth,
                                     collectionView: collectionView)
    }
    
    private func setupItemAttributes(at itemIndex: Int,
                                     sectionIndex: Int,
                                     sectionOffset: CGFloat,
                                     collectionView: UICollectionView) {
        let frame = CGRect(x: sectionOffset + CGFloat(itemIndex) * itemSize.width,
                           y: collectionView.bounds.height - itemSize.height,
                           width: itemSize.width,
                           height: itemSize.height)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: itemIndex, section: sectionIndex))
        attributes.frame = frame
        
        var sectionAttributes = cachedAttributes[sectionIndex] ?? []
        sectionAttributes.append(attributes)
        cachedAttributes[sectionIndex] = sectionAttributes
        
        contentBounds = contentBounds.union(frame)
    }
    
    private func setupSupplementaryAttributes(sectionIndex: Int,
                                              sectionOffset: CGFloat,
                                              sectionWidth: CGFloat,
                                              collectionView: UICollectionView) {
        let headerSize = delegate?.horizontalStickyHeaderCollectionLayout(collectionView,
                                                                          layout: self,
                                                                          referenceSizeForHeaderInSection: sectionIndex) ?? .zero
        let headerWidth = ceil(headerSize.width)
        
        var xPoint = collectionView.contentOffset.x
        + (collectionView.bounds.width / 2)
        - (headerWidth / 2)
        let headerBoundOffset = (itemSize.width - headerWidth) / 2
        
        let leftBound = sectionOffset + headerBoundOffset
        if xPoint < leftBound {
            xPoint = leftBound
        }
        
        let rightBound = sectionOffset + sectionWidth - headerWidth - headerBoundOffset
        if xPoint > rightBound {
            xPoint = rightBound
        }
        
        let frame = CGRect(x: xPoint,
                           y: 0,
                           width: headerWidth,
                           height: collectionView.bounds.height - itemSize.height)
        
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                          with: IndexPath(item: 0, section: sectionIndex))
        attributes.frame = frame
        cachedSupplementaryAttributes.append(attributes)
    }
}
